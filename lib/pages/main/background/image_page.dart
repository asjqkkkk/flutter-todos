import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:todo_list/config/all_types.dart';
import 'package:todo_list/widgets/loading_widget.dart';

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
                  onPressed: () {
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
                  imageProvider: url == NavHeadType.DAILY_PIC_URL
                      ? NetworkImage(url)
                      : CachedNetworkImageProvider(url),
                  initialScale: PhotoViewComputedScale.contained,
                  heroTag: widget.heroTag ?? "tag_$index",
                );
              },
              itemCount: widget.imageUrls.length,
              loadingChild: LoadingWidget(),
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
}
