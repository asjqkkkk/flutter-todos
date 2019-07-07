import 'package:flutter/material.dart';

class MenuIcon extends StatelessWidget {

  final Color color;


  MenuIcon(this.color);

  @override
  Widget build(BuildContext context) {


    return Container(
      width: 25,
      height: 17,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 16,height: 3,
            decoration: buildBoxDecoration(),
          ),
          SizedBox(height: 4,),
          Container(
            width: 25,height: 3,
            decoration: buildBoxDecoration(),
          ),
          SizedBox(height: 4,),
          Container(
            width: 14,height: 3,
            decoration: buildBoxDecoration(),
          ),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() {
    return BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(3)),
            color: color
          );
  }
}
