import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomCacheImage extends StatelessWidget {
  const CustomCacheImage({Key key, @required this.url, this.fit = BoxFit.cover})
      : super(key: key);

  final String url;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: fit,
      imageUrl: url,
      placeholder: (context, url) => Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          valueColor:
              AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
        ),
      ),
      errorWidget: (context, url, error) => Icon(
        Icons.error,
        color: Colors.redAccent,
      ),
    );
  }
}
