import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/config/all_types.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/model/global_model.dart';
import 'package:todo_list/model/net_pictures_page_model.dart';
import 'package:todo_list/widgets/custom_net_image.dart';
import 'package:todo_list/widgets/loading_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NetPicturesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final globalModel = Provider.of<GlobalModel>(context);
    final model = Provider.of<NetPicturesPageModel>(context)
      ..setContext(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(model.useType == NetPicturesUseType.navigatorHeader
            ? IntlLocalizations.of(context).netPicture
            : IntlLocalizations.of(context).accountBackgroundSetting),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.history),
            onPressed: model.logic.onHistoryTap,
          )
        ],
      ),
      body: Container(
          child: model.loadingFlag == LoadingFlag.success ||
                  model.photos.isNotEmpty
              ? SmartRefresher(
                  controller: model.refreshController,
                  enablePullDown: false,
                  enablePullUp: true,
                  onLoading: model.logic.loadMorePhoto,
                  footer: CustomFooter(
                    builder: (BuildContext context, LoadStatus mode) =>
                        model.logic.getRefreshFooter(context, mode),
                  ),
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: List.generate(model.photos.length, (index) {
                      final url = model.photos[index].urls.regular;
                      final urls = model.photos
                          .map((photoBean) => photoBean.urls.regular)
                          .toList();
                      return InkWell(
                        onTap: () =>
                            model.logic.onPictureTap(urls, index, globalModel),
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: CustomNetImage(url: url,tag: "tag_$index",),
                        ),
                      );
                    }),
                  ),
                )
              : LoadingWidget(
                  errorText: model.loadingErrorText,
                  flag: model.loadingFlag,
                  errorCallBack: () {
                    model.loadingFlag = LoadingFlag.loading;
                    model.refresh();
                    model.logic.getPhotos(cancelToken: model.cancelToken);
                  },
                )),
    );
  }
}
