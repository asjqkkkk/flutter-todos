import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/config/api_service.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/json/photo_bean.dart';
import 'package:todo_list/model/global_model.dart';
import 'package:todo_list/utils/shared_util.dart';
import 'package:todo_list/widgets/loading_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'image_page.dart';

class PhotoPage extends StatefulWidget {
  final String selectValue;

  const PhotoPage({Key key, @required this.selectValue}) : super(key: key);

  @override
  _PhotoPageState createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  List<PhotoBean> photos = [];
  String loadingErrorText = "";

  LoadingFlag loadingFlag = LoadingFlag.loading;
  RefreshController _refreshController;

  @override
  Widget build(BuildContext context) {
    final globalModel = Provider.of<GlobalModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(DemoLocalizations.of(context).netPicture),
      ),
      body: Container(
          child: loadingFlag == LoadingFlag.success || photos.length > 0
              ? SmartRefresher(
                  controller: _refreshController,
                  enablePullDown: false,
                  enablePullUp: true,
                  onLoading: loadMorePhoto,
                  footer: CustomFooter(
                    builder: (BuildContext context, LoadStatus mode) {
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
                    },
                  ),
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: List.generate(photos.length, (index) {
                      final url = photos[index].urls.small;
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(new CupertinoPageRoute(builder: (ctx) {
                              return ImagePage(
                                imageUrls: List.generate(photos.length, (index){
                                  return photos[index].urls.regular;
                                }),
                                initialPageIndex: index,
                                onSelect: (current){
                                  final currentUrl = photos[current].urls.small;
                                  SharedUtil.instance
                                      .saveString(Keys.currentNetPicUrl, currentUrl);
                                  SharedUtil.instance.saveString(
                                      Keys.currentNavHeader, widget.selectValue);
                                  globalModel.currentNetPicUrl = currentUrl;
                                  globalModel.currentNavHeader = widget.selectValue;
                                  globalModel.refresh();
                                  Navigator.of(context).pop();
                                },
                              );
                          }));
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            child: Hero(
                              tag: "tag_${index}",
                              child: CachedNetworkImage(
                                imageUrl: url,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => new Container(
                                      alignment: Alignment.center,
                                      child: CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation<Color>(
                                            Theme.of(context).primaryColor),
                                      ),
                                    ),
                                errorWidget: (context, url, error) => new Icon(
                                      Icons.error,
                                      color: Colors.redAccent,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                )
              : LoadingWidget(
                  errorText: loadingErrorText,
                  errorCallBack: () {
                    getPhotos();
                  },
                )),
    );
  }

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController(initialRefresh: true);
    getPhotos();
  }

  @override
  void dispose() {
    _refreshController?.dispose();
    super.dispose();
  }

  void loadMorePhoto() {
    getPhotos(
      page: (photos.length / 20).toInt() + 1,
    );
  }

  void getPhotos({int page = 1, int perPage = 20}) {
    ApiService.instance.getPhotos(
      success: (beans) {
        List<PhotoBean> datas = beans;
        if (datas.length == 0) {
          loadingFlag = LoadingFlag.empty;
          _refreshController.footerMode.value = LoadStatus.noMore;
        } else {
          loadingFlag = LoadingFlag.success;
          photos.addAll(datas);
          _refreshController.loadComplete();
        }
        refresh();

      },
      failed: (fail) {
        loadingFlag = LoadingFlag.error;
        _refreshController?.footerMode?.value = LoadStatus.failed;
        refresh();

      },
      error: (error) {
        loadingFlag = LoadingFlag.error;
        _refreshController?.footerMode?.value = LoadStatus.failed;
        refresh();
      },
      params: {
        "client_id":
            "7b77014ee1e5b9a2518420aa190db74fd82f81cd2cc5c6e03ced781b8205b80e",
        "page": "${page}",
        "per_page": "${perPage}"
      },
    );
  }

  void refresh(){
    if(mounted){
      setState(() {});
    }
  }
}
