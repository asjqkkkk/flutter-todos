import 'package:flutter_test/flutter_test.dart';
import 'dart:math';
import 'package:flutter/material.dart';

void main(){



  //求三角形a边对应的角度
  double getAngle(double a,double b, double c){
    double numerator = pow(b,2) + pow(c,2) - pow(a,2);
    double denominator = 2 * b * c;
    double angle = acos(numerator / denominator);
    return angle;
  }

  //求两坐标之间的距离
  double getDistance(Offset one, Offset two){
    double deltaX = one.dx - two.dx;
    double deltaY = one.dy - two.dy;
    double num = pow(deltaX, 2) + pow(deltaY, 2);
    double distance = sqrt(num);
    return distance;
  }

  test("\n测试圆求角度\n", (){


    double angle = getAngle(sqrt(2), sqrt(2), 2);
    print("角度:$angle");

    double distance = getDistance(Offset(0, sqrt(2)), Offset(sqrt(2), 0));
    print("长度:$distance");



  });


  test(("测试"), (){

    final a = 20 / 20;
    final b = 40 / 20;
    final c = 44 / 20;

    print("a:$a  b:$b  c:${c.toInt()}");

  });
}