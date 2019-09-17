import 'package:flutter/material.dart';
import 'package:todo_list/config/api_service.dart';
import 'package:todo_list/config/api_strategy.dart';
import 'package:todo_list/database/database.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/json/task_bean.dart';
import 'package:todo_list/model/main_page_model.dart';
import 'package:todo_list/utils/shared_util.dart';

class SynchronizeWidget extends StatefulWidget {

  final MainPageModel mainPageModel;

  const SynchronizeWidget({Key key, @required this.mainPageModel}) : super(key: key);

  @override
  _SynchronizeWidgetState createState() => _SynchronizeWidgetState();
}

class _SynchronizeWidgetState extends State< SynchronizeWidget> {

  SynFlag synFlag = SynFlag.hasNotSynced;
  CancelToken cancelToken;

  String account;
  String token;


  ///表示需要同步的数量
  int needSyncedLength = 0;

  ///表示已经同步成功的数量
  List<String> syncedList = [];

  ///同步成功后需要在本地进行更新的task
  List<TaskBean> needSynTasks = [];

  bool loginSucceed = false;

  @override
  void initState() {
    cancelToken = CancelToken();
    doLogin();
    super.initState();
  }

  @override
  void dispose() {
    if(!cancelToken.isCancelled){
      cancelToken.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child:  Container(
        alignment: Alignment.center,
        child: getSynWidget(synFlag),
      ),
    );
  }

  void onTap(){
    if(synFlag == SynFlag.noNeedSynced) return null;
    return loginSucceed ? clickToSyn() : doLogin();
  }


  Widget getSynWidget(SynFlag synFlag){
    switch(synFlag){
      case SynFlag.hasNotSynced:
        return Container(
          width: 60,
          height: 60,
          child: needSyncedLength == 0 ? Container() : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 20,
                height: 20,
                margin: EdgeInsets.only(bottom: 5),
                child: CircularProgressIndicator(
                  value: 1.0,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              ),
              Text(DemoLocalizations.of(context).clickToSyn,style: TextStyle(color: Colors.white),),
              Text("(0 / $needSyncedLength)",style: TextStyle(color: Colors.white, fontSize: 12),),
            ],
          ),
        );
        break;
      case SynFlag.synchronizing:
        return Container(
          width: 200,
          height: 60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 20,
                height: 20,
                margin: EdgeInsets.only(bottom: 5),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              ),
              Text(DemoLocalizations.of(context).synchronizing,style: TextStyle(color: Colors.white),),
              Text("(${needSynTasks.length} / $needSyncedLength)",style: TextStyle(color: Colors.white, fontSize: 12),),
            ],
          ),
        );
        break;
      case SynFlag.cloudSynchronizing:
        return Container(
          width: 100,
          height: 60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 20,
                height: 20,
                margin: EdgeInsets.only(bottom: 5),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              ),
              Text(DemoLocalizations.of(context).cloudSynchronizing,style: TextStyle(color: Colors.white,fontSize: 12),),
            ],
          ),
        );
        break;
      case SynFlag.failSynced:
        return Container(
          width: 60,
          height: 60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 5),
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  value: 1.0,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              ),
              Text(DemoLocalizations.of(context).synchronizeFailed,style: TextStyle(color: Colors.white),)
            ],
          ),
        );
        break;
      case SynFlag.noNeedSynced:
        return Container(width: 60,height: 60,);
        break;
      default:
    }
    return Container();
  }


  void uploadTask(TaskBean taskBean, String token) async{
    if(synFlag == SynFlag.failSynced) return;
    ApiService.instance.postCreateTask(
      taskBean: taskBean,
      success: (UploadTaskBean bean){
        syncedList.add(bean.uniqueId);
        taskBean.uniqueId = bean.uniqueId;
        taskBean.needUpdateToCloud = 'false';
        updateLocalTasks(token);
      },
      failed: (UploadTaskBean bean){
        print("失败：${bean.toString()}");
        setState(() {
          synFlag = SynFlag.failSynced;
        });
      },
      error: (msg){
        print("错误：$msg");
        setState(() {
          synFlag = SynFlag.failSynced;
        });
      },
      token: token,
      cancelToken: cancelToken,
    );
  }


  ///在云端更新一个任务
  void postUpdateTask(TaskBean taskBean,String token ) async{

    final token = await SharedUtil.instance.getString(Keys.token);
    ApiService.instance.postUpdateTask(
      success: (CommonBean bean){
        syncedList.add(taskBean.uniqueId);
        taskBean.needUpdateToCloud = 'false';
        updateLocalTasks(token);
      },
      failed: (CommonBean bean){
        taskBean.needUpdateToCloud = 'true';
        widget.mainPageModel.needSyn = true;
        widget.mainPageModel.refresh();
      },
      error: (msg){
        taskBean.needUpdateToCloud = 'true';
        widget.mainPageModel.needSyn = true;
        widget.mainPageModel.refresh();
      },
      taskBean: taskBean,
      token: token,
      cancelToken: cancelToken,
    );
  }

  void updateLocalTasks(String token) {
    if(syncedList.length == needSyncedLength){
      DBProvider.db.updateTasks(needSynTasks).then((v){
        setState(() {
          this.synFlag = SynFlag.cloudSynchronizing;
          print("更新完成");
          ///将本地数据同步至云端后，从云端获取数据同步到本地(场景:手机A和手机B都在使用app)
          getCloudTasks(account, token);
        });
      });
    }
  }


  void checkIfNeedSyn(String account, String token) async{
    final allTasks = await DBProvider.db.getAllTasks(account: account);
    List<TaskBean> needSynTasks = [];
    int needSynNum = 0;
    for (var task in allTasks) {
      ///如果需要同步到云端
      if(task.getNeedUpdateToCloud(task)){
        needSynNum++;
        needSynTasks.add(task);
      }
    }
    ///当本地需要同步到云端的数据没有时，就从云端获取数据同步到本地
    if(needSynNum == 0){
      synFlag = SynFlag.noNeedSynced;
      getCloudTasks(account, token);
      return;
    }
    setState(() {
      needSyncedLength = needSynNum;
      this.needSynTasks.clear();
      this.needSynTasks.addAll(needSynTasks);
    });
    clickToSyn();
  }


  void clickToSyn() async{
    if(synFlag == SynFlag.synchronizing || synFlag == SynFlag.cloudSynchronizing) return;
    setState(() {
      synFlag = SynFlag.synchronizing;
    });
    final token = await SharedUtil.instance.getString(Keys.token);
    for (var task in needSynTasks) {
      if(task.uniqueId == null) {
        uploadTask(task, token);
      } else {
        postUpdateTask(task, token);
      }
    }
  }



  void getCloudTasks(String account, String token) async{
    if(synFlag == SynFlag.failSynced) return;
    ApiService.instance.getTasks(
      params: {
        'account':account,
        'token':token
      },
      success: (CloudTaskBean bean) async{
        final tasks = bean.taskList;
        List<TaskBean> needUpdateTasks = [];
        List<TaskBean> needCreateTasks = [];
        for (var task in tasks) {
          final uniqueId = task.uniqueId;
          final localTask = await DBProvider.db.getTaskByUniqueId(uniqueId);
          ///如果本地没有查到这个task，就需要在本地重新创建
          if(localTask == null){
            needCreateTasks.add(task);
          } else {
            task.id = localTask[0].id;
            needUpdateTasks.add(task);
          }
        }
        await DBProvider.db.updateTasks(needUpdateTasks);
        await DBProvider.db.createTasks(needCreateTasks);
        widget.mainPageModel.logic.getTasks().then((v){
          widget.mainPageModel.needSyn = false;
          widget.mainPageModel.refresh();
        });
        setState(() {
          synFlag = SynFlag.noNeedSynced;
        });
      },
      failed: (UploadTaskBean bean){
        setState(() {
          synFlag = SynFlag.failSynced;
        });
      },
      error: (msg){
        setState(() {
          synFlag = SynFlag.failSynced;
        });
      },
      token: cancelToken,
    );
  }

  ///这里有个隐藏问题，就是注册或者从登录页到主页来，登录操作相当于会执行两次，后续可以考虑解决这个问题
  void doLogin() async{
    final account = await SharedUtil.instance.getString(Keys.account) ?? 'default';
    if(account == 'default'){
      setState(() {
        synFlag = SynFlag.noNeedSynced;
      });
      return;
    }
    final password = await SharedUtil.instance.getString(Keys.password);
    ApiService.instance.login(
      params: {
        "account": "$account",
        "password": "$password"
      },
      success: (LoginBean loginBean) {
        loginSucceed = true;

        this.account = account;
        this.token = loginBean.token;
        SharedUtil.instance.saveString(Keys.account, account).then((value){
          SharedUtil.instance.saveString(Keys.currentUserName, loginBean.username);
          SharedUtil.instance.saveString(Keys.token, loginBean.token);
          SharedUtil.instance.saveBoolean(Keys.hasLogged, true);
          if(loginBean.avatarUrl != null){
            String cloudAvatarFileName = loginBean.avatarUrl.split("/").last;
            String localAvatarFileName = widget.mainPageModel.currentAvatarUrl.split("/").last;
            if(cloudAvatarFileName != localAvatarFileName){
              SharedUtil.instance.saveString(Keys.netAvatarPath, ApiStrategy.baseUrl + loginBean.avatarUrl);
              SharedUtil.instance.saveInt(Keys.currentAvatarType, CurrentAvatarType.net);
              widget.mainPageModel.currentAvatarUrl = ApiStrategy.baseUrl + loginBean.avatarUrl;
              widget.mainPageModel.currentAvatarType = CurrentAvatarType.net;
              widget.mainPageModel.logic.getCurrentAvatar();
            }
          }
          widget.mainPageModel.currentUserName = loginBean.username;
          ///检测是否需要进行本地与云端的数据同步
          checkIfNeedSyn(account, loginBean.token);
        });
      },
      failed: (LoginBean loginBean) {
        setState(() {
          synFlag = SynFlag.failSynced;
        });
      },
      error: (msg) {
        setState(() {
          synFlag = SynFlag.failSynced;
        });
      },
      token: cancelToken,
    );
  }
}

enum SynFlag{
  ///没有将本地数据同步到云端
  hasNotSynced,

  ///不需要进行同步
  noNeedSynced,

  ///同步本地数据到云端中
  synchronizing,

  ///同步云端数据到本地中
  cloudSynchronizing,

  ///同步失败
  failSynced,
}
