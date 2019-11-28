import 'dart:math';

import 'package:flutter/material.dart';
import 'package:todo_list/utils/size_util.dart';

///正六边形实现
class FloatingBorder extends ShapeBorder {
  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.only();

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    return getOuterPath(rect, textDirection: textDirection);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    ///正六边形中心
    Offset center = rect.center;
    ///正六边形边长
    double length = rect.width / 2;
    ///正六边形以最左为起点，顺时针六个点的坐标
    Point one = Point(center.dx - length, center.dy);
    Point two = Point(length / 2 + one.x, center.dy - ((sqrt(3) / 2) * length));
    Point three = Point(two.x + length, two.y);
    Point four = Point(one.x + length * 2, one.y);
    Point five = Point(three.x, center.dy + ((sqrt(3) / 2) * length));
    Point six = Point(two.x, five.y);

    return _drawRoundPolygon([one, two, three, four, five, six], 3);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {
  }

  @override
  ShapeBorder scale(double t) {
    return null;
  }

  Path _drawRoundPolygon(List<Point> ps, double distance) {
    var path = Path();
    ps.add(ps[0]);
    ps.add(ps[1]);
    var p0 = LineInterCircle.intersectionPoint(ps[1], ps[0], distance);
    path.moveTo(p0.x, p0.y);
    for (int i = 0; i < ps.length - 2; i++) {
      var p1 = ps[i];
      var p2 = ps[i + 1];
      var p3 = ps[i + 2];
      var interP1 = LineInterCircle.intersectionPoint(p1, p2, distance);
      var interP2 = LineInterCircle.intersectionPoint(p3, p2, distance);
      path.lineTo(interP1.x, interP1.y);
      path.arcToPoint(
        Offset(interP2.x, interP2.y),
        radius: Radius.circular(distance * 6),
      );
    }
    return path;
  }
}
