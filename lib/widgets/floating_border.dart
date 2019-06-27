import 'dart:math';

import 'package:flutter/material.dart';

class FloatingBorder extends ShapeBorder{
  @override
  // TODO: implement dimensions
  EdgeInsetsGeometry get dimensions => EdgeInsets.only();

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    // TODO: implement getInnerPath
    return getOuterPath(rect, textDirection: textDirection);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    //正六边形中心
    Offset center = rect.center;
    //正六边形边长
    double length = rect.width / 2;
    //正六边形以最左为起点，顺时针六个点的坐标
    Offset one = Offset(center.dx - length, center.dy);
    Offset two = Offset(length / 2 + one.dx, center.dy - ((sqrt(3) / 2) * length));
    Offset three = Offset(two.dx + length, two.dy);
    Offset four = Offset(one.dx + length * 2, one.dy);
    Offset five = Offset(three.dx, center.dy + ((sqrt(3) / 2) * length));
    Offset six = Offset(two.dx, five.dy);

    Path path = Path()
    ..moveTo(one.dx, one.dy)
    ..lineTo(two.dx, two.dy)
    ..lineTo(three.dx, three.dy)
    ..lineTo(four.dx, four.dy)
    ..lineTo(five.dx, five.dy)
    ..lineTo(six.dx, six.dy)
    ..close();

    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {
    // TODO: implement paint
  }

  @override
  ShapeBorder scale(double t) {
    // TODO: implement scale
    return null;
  }

}