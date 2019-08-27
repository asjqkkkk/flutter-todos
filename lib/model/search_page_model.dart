import 'package:flutter/cupertino.dart';
import 'package:todo_list/config/api_service.dart';
import 'package:todo_list/json/task_bean.dart';
import 'package:todo_list/logic/search_page_logic.dart';
import 'package:todo_list/widgets/loading_widget.dart';

class SearchPageModel extends ChangeNotifier{

  BuildContext context;
  SearchPageLogic logic;

  List<TaskBean> searchTasks = [];
  final TextEditingController textEditingController = TextEditingController();
  bool isSearching = false;
  LoadingFlag loadingFlag = LoadingFlag.idle;
  //当前点击进入详情页的index，方便在详情页里面操作删除、更新等
  int currentTapIndex = 0;

  CancelToken cancelToken = CancelToken();


  SearchPageModel(){
    logic = SearchPageLogic(this);
  }

  void setContext(BuildContext context){
    if(this.context == null){
      this.context = context;

    }
  }


  @override
  void dispose(){
    textEditingController?.dispose();
    if(!cancelToken.isCancelled) cancelToken.cancel();
    super.dispose();
    debugPrint("SearchPageModel销毁了");
  }

  void refresh(){
    notifyListeners();
  }
}