import 'dart:math';

import 'package:flutter/material.dart';
import 'package:todo_list/widgets/radial_drag_gesture_detector.dart';
import 'package:todo_list/widgets/show_widget.dart';

class FloatingButton extends StatefulWidget {
  final double innerRadius;
  final double outRadius;
  final double childrenPadding;
  final double initialAngle;
  final Color outCircleColor;
  final Color innerCircleColor;
  final Offset origin;

  FloatingButton(
      {this.innerRadius,
      this.outRadius,
      this.childrenPadding = 10,
      this.initialAngle = 0,
      this.outCircleColor,
      this.innerCircleColor,
      this.origin});

  @override
  _FloatingButtonState createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButton> {

  DragModel dragModel = DragModel();


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final outCircleDiameter = min(size.width, size.height);
    final double outRadius = widget.outRadius ?? outCircleDiameter / 2;
    final double innerRadius = widget.innerRadius ?? outRadius / 2;
    final double betweenRadius = (outRadius + innerRadius) / 2;
    final Offset origin = widget.origin ?? Offset(0, -outRadius);

    return Stack(
      children: <Widget>[
        Positioned(
          left: origin.dx,
          bottom: origin.dy,
          child: Container(
              width: outRadius * 2,
              height: outRadius * 2,
              decoration: BoxDecoration(
                  color: widget.innerCircleColor ?? Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: widget.outCircleColor ?? Colors.blueAccent,
                      width: outRadius - innerRadius))),
        ),
        Positioned(
          left: origin.dx,
          bottom: origin.dy,
          child: Container(
            width: outRadius * 2,
            height: outRadius * 2,
            color: Colors.transparent,
            child: RadialDragGestureDetector(
              onRadialDragUpdate: (PolarCoord updateCoord) {
                debugPrint("update:${updateCoord.toString()}");
                setState(() {
                  dragModel.getAngleDiff(updateCoord);
                });
              },
              onRadialDragStart: (PolarCoord startCoord) {
                debugPrint("Start:${startCoord.toString()}");
                setState(() {
                  dragModel.start = startCoord;
                });
              },
              onRadialDragEnd: () {
                debugPrint("end");
                dragModel.end = dragModel.start;
                dragModel.end.angle = dragModel.angleDiff;
              },
              child: Transform.rotate(
                angle: dragModel.angleDiff + widget.initialAngle,
                child: Stack(
                  children: List.generate(10, (index) {
//                    debugPrint("当前的角度:${dragModel.dragAngle}");
                    final double childrenDiameter =
                        2 * pi * betweenRadius / 10 - widget.childrenPadding;
                    Offset childPoint = getChildPoint(
                        index, 10, betweenRadius, childrenDiameter);
                    return Positioned(
                      left: outRadius + childPoint.dx,
                      top: outRadius + childPoint.dy,
                      child: Transform.rotate(
                        angle: -(dragModel.angleDiff) + widget.initialAngle,
                        child: Container(
                            width: childrenDiameter,
                            height: childrenDiameter,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.orangeAccent),
                            child: Text("${index}")),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Offset getChildPoint(
      int index, int length, double betweenRadius, double childrenDiameter) {
    double angel = 2 * pi * (index / length);
    double x = cos(angel) * betweenRadius - childrenDiameter / 2;
    double y = sin(angel) * betweenRadius - childrenDiameter / 2;
    return Offset(x, y);
  }
}


class DragModel{
  PolarCoord start;
  PolarCoord end;
  double angleDiff = 0.0;


  double getAngleDiff(PolarCoord updatePolar){
    if(start != null){
      angleDiff = updatePolar.angle - start.angle;
      if(end != null){
        angleDiff += end.angle;
      }
    }
    return angleDiff;
  }
}
