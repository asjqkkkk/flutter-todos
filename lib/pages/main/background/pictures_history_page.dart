import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/config/all_types.dart';
import 'package:todo_list/model/account_page_model.dart';
import 'package:todo_list/model/global_model.dart';
import 'package:todo_list/utils/shared_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:todo_list/widgets/custom_animated_switcher.dart';

class PicturesHistoryPage extends StatefulWidget {
  final String useType;
  final AccountPageModel accountPageModel;

  const PicturesHistoryPage({Key key, @required this.useType, this.accountPageModel, })
      : super(key: key);

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
  Widget build(BuildContext context) {
    final globalModel = Provider.of<GlobalModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("历史图片"),
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
                      color: Colors.greenAccent,
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
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          padding: EdgeInsets.all(10),
          children: List.generate(pictureUrls.length, (index) {
            final imageUrl = pictureUrls[index];

            return Stack(
              children: <Widget>[
                InkWell(
                  onTap: () => onPictureTap(pictureUrls, index, globalModel),
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        child: CachedNetworkImage(
                          imageUrl: imageUrl,
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
                ),
                isDeleting
                    ? ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: Container(
                      color: Colors.grey.withOpacity(0.5),
                    ))
                    : SizedBox(),
                isDeleting ? Container(
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
          }),
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

    if (widget.useType == NetPicturesUseType.accountBackground) {
      SharedUtil.instance.saveString(Keys.currentAccountBackground, currentUrl);
      SharedUtil.instance.saveString(Keys.currentAccountBackgroundType, AccountBGType.netPicture);
      final accountPageModel = widget.accountPageModel;
      accountPageModel.backgroundUrl = currentUrl;
      accountPageModel.backgroundType = AccountBGType.netPicture;
      accountPageModel.refresh();
    } else if (widget.useType == NetPicturesUseType.navigatorHeader) {

      SharedUtil.instance.saveString(Keys.currentNetPicUrl, currentUrl);
      SharedUtil.instance.saveString(Keys.currentNavHeader, widget.useType);
      globalModel.currentNetPicUrl = currentUrl;
      globalModel.currentNavHeader = widget.useType;
      globalModel.refresh();

    } else {

      SharedUtil.instance.saveString(Keys.currentMainPageBackgroundUrl, currentUrl);
      SharedUtil.instance.saveBoolean(Keys.enableNetPicBgInMainPage, true);
      globalModel.currentMainPageBgUrl = currentUrl;
      globalModel.enableNetPicBgInMainPage = true;
      globalModel.refresh();
    }
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }


  void onPictureDelete(String url){
    pictureUrls.remove(url);
    SharedUtil.instance.saveStringList(Keys.allHistoryNetPictureUrls, pictureUrls);
    setState(() {});
  }
}
