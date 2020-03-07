
import 'dart:io';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';


import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomCacheImage extends StatelessWidget {
  const CustomCacheImage({Key key, @required this.url, this.fit = BoxFit.cover, this.cacheManager})
      : super(key: key);

  final String url;
  final BoxFit fit;
  final BaseCacheManager cacheManager;

  @override
  Widget build(BuildContext context) {

    if(!url.startsWith('http')){
      final file = File(url);
      if(file.existsSync()){
        return Image.file(file);
      } else return SvgPicture.asset(
        "svgs/bg.svg",
        fit: BoxFit.cover,
      );
    }

    return CachedNetworkImage(
      fit: fit,
      imageUrl: url,
      cacheManager: cacheManager,
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
