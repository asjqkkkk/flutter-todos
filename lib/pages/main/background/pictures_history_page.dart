import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/config/all_types.dart';
import 'package:todo_list/database/database.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/json/task_bean.dart';
import 'package:todo_list/model/account_page_model.dart';
import 'package:todo_list/model/global_model.dart';
import 'package:todo_list/utils/shared_util.dart';
import 'package:todo_list/widgets/custom_animated_switcher.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter/painting.dart' as painting;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_list/widgets/custom_cache_image.dart';

class PicturesHistoryPage extends StatefulWidget {
  final String useType;
  final AccountPageModel accountPageModel;
  final TaskBean taskBean;

  const PicturesHistoryPage({
    Key key,
    @required this.useType,
    this.accountPageModel,
    this.taskBean,
  }) : super(key: key);

  @override
  _PicturesHistoryPagState createState() => _PicturesHistoryPagState();
}

class _PicturesHistoryPagState extends State<PicturesHistoryPage> {
  List<String> pictureUrls = [];
  bool isDeleting = false;

  @override
  void initState() {
    super.initState();
    getHistoryPictures();
  }

  @override
  void dispose() {
    painting.imageCache.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final globalModel = Provider.of<GlobalModel>(context);
    final size = MediaQuery.of(context).size;
    final theMin = min(size.width, size.height) / 2;
    return Scaffold(
      appBar: AppBar(
        title: Text(IntlLocalizations.of(context).netPicHistory),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 20),
            child: pictureUrls.isNotEmpty
                ? CustomAnimatedSwitcher(
                    firstChild: Icon(
                      Icons.border_color,
                      size: 20,
                    ),
                    secondChild: Icon(
                      Icons.check,
                      size: 20,
                    ),
                    hasChanged: isDeleting,
                    onTap: () {
                      isDeleting = !isDeleting;
                      setState(() {});
                    },
                  )
                : SizedBox(),
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: pictureUrls.isEmpty ? Center(
          child: SvgPicture.asset(
            "svgs/empty_list.svg",
            color: globalModel.logic.getPrimaryGreyInDark(context),
            width: theMin,
            height: theMin,
            semanticsLabel: 'empty list',
          ),
        ) : GridView.builder(
          itemCount: pictureUrls.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, //每行三列
              childAspectRatio: 1.0 //显示区域宽高相等
          ),
          padding: EdgeInsets.all(10),
          itemBuilder: (ctx, index){
            final imageUrl = pictureUrls[index];

            return Stack(
              children: <Widget>[
                InkWell(
                  onTap: () => onPictureTap(pictureUrls, index, globalModel),
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: CustomCacheImage(url: imageUrl,fit: BoxFit.contain,),
                    ),
                  ),
                ),
                isDeleting
                    ? ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: Container(
                      color: Colors.grey.withOpacity(0.5),
                    ))
                    : SizedBox(),
                isDeleting
                    ? Container(
                  alignment: Alignment.center,
                  child: IconButton(
                    padding: EdgeInsets.all(0),
                    iconSize: 80,
                    icon: Icon(
                      Icons.delete,
                      color: Colors.redAccent,
                    ),
                    onPressed: () => onPictureDelete(imageUrl),
                  ),
                )
                    : SizedBox(),
              ],
            );
          },
        ),
      ),
    );
  }

  void getHistoryPictures() async {
    final urls = await SharedUtil.instance
            .getStringList(Keys.allHistoryNetPictureUrls) ??
        [];
    if (urls.isEmpty) return;
    pictureUrls.clear();
    pictureUrls.addAll(urls);
    setState(() {});
  }

  void onPictureTap(List<String> urls, int index, GlobalModel globalModel) {
    String currentUrl = urls[index];

    switch (widget.useType) {
      case NetPicturesUseType.accountBackground:
        SharedUtil.instance
            .saveString(Keys.currentAccountBackground, currentUrl);
        SharedUtil.instance.saveString(
            Keys.currentAccountBackgroundType, AccountBGType.netPicture);
        final accountPageModel = widget.accountPageModel;
        accountPageModel.backgroundUrl = currentUrl;
        accountPageModel.backgroundType = AccountBGType.netPicture;
        accountPageModel.refresh();
        break;
      case NetPicturesUseType.navigatorHeader:
        SharedUtil.instance.saveString(Keys.currentNetPicUrl, currentUrl);
        SharedUtil.instance.saveString(Keys.currentNavHeader, widget.useType);
        globalModel.currentNetPicUrl = currentUrl;
        globalModel.currentNavHeader = widget.useType;
        globalModel.refresh();
        break;
      case NetPicturesUseType.taskCardBackground:
        widget.taskBean?.backgroundUrl = currentUrl;
        DBProvider.db.updateTask(widget.taskBean);
        final searchModel = globalModel.searchPageModel;
        searchModel?.refresh();
        final taskDetailPageModel = globalModel.taskDetailPageModel;
        taskDetailPageModel?.refresh();
        final mainPageModel = globalModel.mainPageModel;
        mainPageModel?.refresh();
        break;
      default:
        SharedUtil.instance
            .saveString(Keys.currentMainPageBackgroundUrl, currentUrl);
        SharedUtil.instance.saveBoolean(Keys.enableNetPicBgInMainPage, true);
        globalModel.currentMainPageBgUrl = currentUrl;
        globalModel.enableNetPicBgInMainPage = true;
        globalModel.refresh();
        break;
    }
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  void onPictureDelete(String url) {
    pictureUrls.remove(url);
    SharedUtil.instance
        .saveStringList(Keys.allHistoryNetPictureUrls, pictureUrls);
    DefaultCacheManager().removeFile(url);
    setState(() {});
  }
}
