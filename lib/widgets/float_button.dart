import 'dart:math';

import 'package:flutter/material.dart';
import 'package:todo_list/widgets/show_widget.dart';

class FloatingButton extends StatefulWidget {
  final double innerRadius;
  final double outRadius;
  final double childrenPadding;
  final double initialAngle;
  final Color outCircleColor;
  final Color innerCircleColor;

  FloatingButton({this.innerRadius, this.outRadius, this.childrenPadding = 10, this.initialAngle = 0, this.outCircleColor, this.innerCircleColor});

  @override
  _FloatingButtonState createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButton> {


  bool isDragging = false;
  Offset dragStart;
  double dragPercent = 0.0;
  double dragAngle = 0;
  double endAngle = 0;


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final outCircleDiameter = min(size.width, size.height);
    final double outRadius = widget.outRadius ?? outCircleDiameter / 2;
    final double innerRadius = widget.innerRadius ?? outRadius / 2;
    final double betweenRadius = (outRadius + innerRadius) / 2;

    return Stack(
      children: <Widget>[
        Positioned(
          left: 0,
          bottom: -outRadius,
          child: Container(
            width: outRadius * 2,
            height: outRadius * 2,
              decoration: BoxDecoration(
                  color: widget.innerCircleColor ?? Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: widget.outCircleColor ?? Colors.blueAccent, width: outRadius - innerRadius))
          ),
        ),
        Positioned(
          left: 0,
          bottom: -outRadius,
          child: Container(
            width: outRadius * 2,
            height: outRadius * 2,
            color: Colors.transparent,
            child: GestureDetector(
              onHorizontalDragUpdate: (DragUpdateDetails details){
                debugPrint("Hor DragUpdate:${details}");
                setState(() {
                  dragPercent = (details.globalPosition.dx - dragStart.dx) / outRadius / 2;
                  dragAngle = dragPercent * pi + endAngle;
                });
              },
              onHorizontalDragStart: (DragStartDetails details){
                debugPrint("Hor DragStart:${details}");
                setState(() {
                  dragStart = details.globalPosition;
                  isDragging = true;
                });
              },
              onHorizontalDragEnd: (DragEndDetails details){
                debugPrint("Hor DragEnd:${details.velocity}");
                setState(() {
                  endAngle = dragAngle;
                  isDragging = false;
                });
              },
              child: Transform.rotate(
                angle:dragAngle+ widget.initialAngle,
                child: Stack(
                  children: List.generate(10, (index){
                    debugPrint("当前的角度:${dragAngle}");
                    final double childrenDiameter = 2 * pi * betweenRadius / 10 - widget.childrenPadding;
                    Offset childPoint = getChildPoint(index, 10, betweenRadius, childrenDiameter);
                    return Positioned(
                      left: outRadius + childPoint.dx,
                      top: outRadius+  childPoint.dy,
                      child: Transform.rotate(
                        angle: -(dragAngle + widget.initialAngle),
                        child: Container(
                            width: childrenDiameter ,
                            height: childrenDiameter,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.orangeAccent),
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


  Offset getChildPoint(int index, int length, double betweenRadius, double childrenDiameter){
    double angel = 2 * pi * (index / length);
    double x = cos(angel) * betweenRadius - childrenDiameter / 2;
    double y = sin(angel) * betweenRadius - childrenDiameter / 2;
    return Offset(x,y);
  }
}
