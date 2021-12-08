
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:todo_list/config/all_types.dart';
import 'package:todo_list/config/custom_image_cache_manager.dart';
import 'package:todo_list/utils/shared_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:todo_list/widgets/loading_widget.dart';
import 'dart:io';

class ImagePage extends StatefulWidget {
  final List<String> imageUrls;
  final int initialPageIndex;
  final Function onSelect;
  final String heroTag;

  const ImagePage(
      {Key key,
      @required this.imageUrls,
      this.initialPageIndex,
      this.onSelect,
      this.heroTag})
      : super(key: key);

  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  int currentPage;
  PageController pageController;

  @override
  void initState() {
    super.initState();
    currentPage = widget.initialPageIndex ?? 0;
    pageController =
        PageController(initialPage: widget.initialPageIndex ?? currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("${currentPage + 1} / ${widget.imageUrls.length}"),
        actions: <Widget>[
          widget.onSelect == null
              ? SizedBox()
              : IconButton(
                  icon: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    final urls = await SharedUtil.instance
                            .getStringList(Keys.allHistoryNetPictureUrls) ??
                        [];
                    final url = widget.imageUrls[currentPage];
                    if (!urls.contains(url)) {
                      urls.add(url);
                      SharedUtil.instance
                          .saveStringList(Keys.allHistoryNetPictureUrls, urls);
                    }
                    Navigator.pop(context);
                    widget.onSelect(currentPage);
                  },
                )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            child: PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: (BuildContext context, int index) {
                final url = widget.imageUrls[index];
                return PhotoViewGalleryPageOptions(
                  imageProvider: CachedNetworkImageProvider(url,
                      cacheManager: url == NavHeadType.DAILY_PIC_URL
                          ? CustomCacheManager()
                          : null),
                  initialScale: PhotoViewComputedScale.contained,
                  heroAttributes: PhotoViewHeroAttributes(tag: widget.heroTag ?? "tag_$index"),
                );
              },
              itemCount: widget.imageUrls.length,
              loadingBuilder: (ctx, event) => LoadingWidget(),
              pageController: pageController,
              onPageChanged: (page) {
                currentPage = page;
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  ImageProvider getProvider(String url) {
    if(url.startsWith('http')){
      File file = File(url);
      if(file.existsSync()) return FileImage(file);
      return AssetImage('images/icon_2.png');
    }

    return CachedNetworkImageProvider(url,
        cacheManager:
            url == NavHeadType.DAILY_PIC_URL ? CustomCacheManager() : null);
  }
}
