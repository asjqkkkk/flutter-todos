import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/config/all_types.dart';
import 'package:todo_list/config/api_service.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/model/all_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:todo_list/pages/main/background/image_page.dart';
import 'package:todo_list/utils/shared_util.dart';



class NetPicturesPageLogic{

  final NetPicturesPageModel _model;

  NetPicturesPageLogic(this._model);

  void getPhotos({
    int page = 1,
    int perPage = 20,
    CancelToken cancelToken,
  }) {
    ApiService.instance.getPhotos(
      success: (beans) {
        List<PhotoBean> datas = beans;
        if (datas.length == 0) {
          _model.loadingFlag = LoadingFlag.empty;
          _model.refreshController.footerMode.value = LoadStatus.noMore;
        } else {
          _model.loadingFlag = LoadingFlag.success;
          _model.photos.addAll(datas);
          _model.refreshController.loadComplete();
        }
        _model.refresh();
      },
      failed: (fail) {
        _model.loadingFlag = LoadingFlag.error;
        _model.refreshController?.footerMode?.value = LoadStatus.failed;
        _model.refresh();
      },
      error: (error) {
        debugPrint("错误:$error");
        _model.loadingFlag = LoadingFlag.error;
        _model.refreshController?.footerMode?.value = LoadStatus.failed;
        _model.refresh();
      },
      params: {
        "client_id":
        "7b77014ee1e5b9a2518420aa190db74fd82f81cd2cc5c6e03ced781b8205b80e",
        "page": "$page",
        "per_page": "$perPage"
      },
      token: cancelToken,
    );
  }


  void loadMorePhoto() {
    getPhotos(
      page: _model.photos.length ~/ 20 + 1,
      cancelToken: _model.cancelToken,
    );
  }

  Widget getRefreshFooter(BuildContext context, LoadStatus mode){
    Widget body;
    if (mode == LoadStatus.idle) {
      body = Text(
          DemoLocalizations.of(context).pullUpToLoadMore);
    } else if (mode == LoadStatus.loading) {
      body = CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(
            Theme.of(context).primaryColor),
      );
    } else if (mode == LoadStatus.failed) {
      body = Text(DemoLocalizations.of(context).loadingError);
    } else {
      body = Text(DemoLocalizations.of(context).loadingEmpty);
    }
    return Container(
      height: 55.0,
      child: Center(child: body),
    );
  }

  void onPictureTap(List<String> urls, int index, GlobalModel globalModel){
    Navigator.of(_model.context)
        .push(new CupertinoPageRoute(builder: (ctx) {
      return ImagePage(
        imageUrls: urls,
        initialPageIndex: index,
        onSelect: (current) {
          final currentUrl =
          _model.photos[current].urls.regular;

          if(_model.useType == NetPicturesUseType.accountBackground){

            SharedUtil.instance.saveString(Keys.currentAccountBackground, currentUrl);
            SharedUtil.instance.saveString(Keys.currentAccountBackgroundType, AccountBGType.netPicture);
            final accountPageModel = _model.accountPageModel;
            accountPageModel.backgroundUrl = currentUrl;
            accountPageModel.backgroundType = AccountBGType.netPicture;
            accountPageModel.refresh();

          } else if(_model.useType == NetPicturesUseType.navigatorHeader){

            SharedUtil.instance.saveString(Keys.currentNetPicUrl, currentUrl);
            SharedUtil.instance.saveString(Keys.currentNavHeader, _model.useType);
            globalModel.currentNetPicUrl = currentUrl;
            globalModel.currentNavHeader = _model.useType;
            globalModel.refresh();

          } else {

            SharedUtil.instance.saveString(Keys.currentMainPageBackgroundUrl, currentUrl);
            SharedUtil.instance.saveBoolean(Keys.enableNetPicBgInMainPage, true);
            globalModel.currentMainPageBgUrl = currentUrl;
            globalModel.enableNetPicBgInMainPage = true;
            globalModel.refresh();

          }
          Navigator.of(_model.context).pop();
        },
      );
    }));
  }
}