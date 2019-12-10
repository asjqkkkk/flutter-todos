import 'package:flutter/material.dart';

class NetImage extends StatelessWidget {

  final String url;


  NetImage(this.url);

  @override
  Widget build(BuildContext context) {

    final color = Theme.of(context).primaryColor;

    return Image.network(
      url,
        fit: BoxFit.cover,
      loadingBuilder: (BuildContext context,
          Widget child,
          ImageChunkEvent loadingProgress) {
        print("$url      loadingProgress:${loadingProgress?.cumulativeBytesLoaded}  ${loadingProgress?.expectedTotalBytes}   child:$child");
        if (loadingProgress == null)
          return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                : null,
          ),
        );
      },
    );
  }
}
