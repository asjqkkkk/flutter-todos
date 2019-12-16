import 'package:flutter/material.dart';

class CustomNetImage extends StatefulWidget {

  final String url;
  final String tag;

  const CustomNetImage({Key key, @required this.url, this.tag}) : super(key: key);

  @override
  _CustomNetImageState createState() => _CustomNetImageState();
}

class _CustomNetImageState extends State<CustomNetImage> {

  @override
  void dispose() {
    NetworkImage(widget.url).evict();
//    debugPrint("销毁:${widget.url}");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(tag: widget.tag ,child: FadeInImage.assetNetwork(placeholder: "images/icon.png", image: widget.url));
  }
}
