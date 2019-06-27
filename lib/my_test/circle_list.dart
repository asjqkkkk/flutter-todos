library circle_list;

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:todo_list/my_test/radial_drag_gesture_detector.dart';

class CircleList extends StatefulWidget {
  final double innerRadius;
  final double outerRadius;
  final double childrenPadding;
  final double initialAngle;
  final Color outerCircleColor;
  final Color innerCircleColor;
  final Gradient gradient;
  final Offset origin;
  final List<Widget> children;
  final bool isChildrenVertical;
  final bool outerCircleRotateWithChildren;
  final bool innerCircleRotateWithChildren;
  final bool showInitialAnimation;
  final Widget centerWidget;
  final RadialDragStart onDragStart;
  final RadialDragUpdate onDragUpdate;
  final RadialDragEnd onDragEnd;
  final AnimationSetting animationSetting;

  CircleList(
      {this.innerRadius,
      this.outerRadius,
      this.childrenPadding = 10,
      this.initialAngle = 0,
      this.outerCircleColor,
      this.innerCircleColor,
      this.origin,
      @required this.children,
      this.onDragStart,
      this.onDragUpdate,
      this.onDragEnd,
      this.gradient,
      this.centerWidget,
      this.isChildrenVertical = true,
      this.outerCircleRotateWithChildren = false,
      this.innerCircleRotateWithChildren = false,
      this.showInitialAnimation = false, this.animationSetting})
      : assert(children != null);

  @override
  _CircleListState createState() => _CircleListState();
}

class _CircleListState extends State<CircleList>
    with SingleTickerProviderStateMixin {
  DragModel dragModel = DragModel();
  AnimationController _controller;
  Animation<double> _animationRotate;
  bool isAnimationStop = true;

  @override
  void initState() {
    if(widget.showInitialAnimation){
      _controller =
          AnimationController(vsync: this, duration: widget?.animationSetting?.duration??Duration(seconds: 1));
      _animationRotate =widget?.animationSetting?.rotateAnimation?? Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
      _controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            isAnimationStop = true;
          });
        }
      });
      _controller.addListener(() {
        setState(() {
          isAnimationStop = false;
        });
      });
      _controller.forward();
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final outCircleDiameter = min(size.width, size.height);
    final double outerRadius = widget.outerRadius ?? outCircleDiameter / 2;
    final double innerRadius = widget.innerRadius ?? outerRadius / 2;
    final double betweenRadius = (outerRadius + innerRadius) / 2;

    //the origin is the point to left and bottom
    final Offset origin = widget.origin ?? Offset(0, -outerRadius);

    return Container(
      width: outerRadius * 2,
      height: outerRadius * 2,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: origin.dx,
            bottom: origin.dy,
            child: Transform.rotate(
              angle: widget.outerCircleRotateWithChildren
                  ? (dragModel.angleDiff + widget.initialAngle)
                  : 0,
              child: Container(
                  width: outerRadius * 2,
                  height: outerRadius * 2,
                  decoration: BoxDecoration(
                      gradient: widget.gradient,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: widget.outerCircleColor ?? Colors.transparent,
                        width: outerRadius - innerRadius,
                      ))),
            ),
          ),
          Positioned(
            left: origin.dx,
            bottom: origin.dy,
            child: Container(
              width: outerRadius * 2,
              height: outerRadius * 2,
              color: Colors.transparent,
              child: RadialDragGestureDetector(
                onRadialDragUpdate: (PolarCoord updateCoord) {
                  if (widget.onDragUpdate != null) {
                    widget.onDragUpdate(updateCoord);
                  }
                  setState(() {
                    dragModel.getAngleDiff(updateCoord);
                  });
                },
                onRadialDragStart: (PolarCoord startCoord) {
                  if (widget.onDragStart != null) {
                    widget.onDragStart(startCoord);
                  }
                  setState(() {
                    dragModel.start = startCoord;
                  });
                },
                onRadialDragEnd: () {
                  if (widget.onDragEnd != null) {
                    widget.onDragEnd();
                  }
                  dragModel.end = dragModel.start;
                  dragModel.end.angle = dragModel.angleDiff;
                },
                child: Transform.rotate(
                  angle: isAnimationStop
                      ? (dragModel.angleDiff + widget.initialAngle)
                      : (-_animationRotate.value * pi * 2),
                  child: Stack(
                    children: List.generate(widget.children.length, (index) {
                      final double childrenDiameter =
                          2 * pi * betweenRadius / 10 - widget.childrenPadding;
                      Offset childPoint = getChildPoint(
                          index, 10, betweenRadius, childrenDiameter);
                      return Positioned(
                        left: outerRadius + childPoint.dx,
                        top: outerRadius + childPoint.dy,
                        child: Transform.rotate(
                          angle: widget.isChildrenVertical
                              ? (-(dragModel.angleDiff) + widget.initialAngle)
                              : ((dragModel.angleDiff) - widget.initialAngle),
                          child: Container(
                              width: childrenDiameter,
                              height: childrenDiameter,
                              alignment: Alignment.center,
                              child: widget.children[index]),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              left: origin.dx + innerRadius,
              bottom: origin.dy + innerRadius,
              child: Transform.rotate(
                angle: widget.innerCircleRotateWithChildren
                    ? dragModel.angleDiff + widget.initialAngle
                    : 0,
                child: Container(
                  width: innerRadius * 2,
                  height: innerRadius * 2,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.innerCircleColor ?? Colors.transparent,
                  ),
                  child: widget.centerWidget ?? SizedBox(),
                ),
              ))
        ],
      ),
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

class DragModel {
  PolarCoord start;
  PolarCoord end;
  double angleDiff = 0.0;

  double getAngleDiff(PolarCoord updatePolar) {
    if (start != null) {
      angleDiff = updatePolar.angle - start.angle;
      if (end != null) {
        angleDiff += end.angle;
      }
    }
    return angleDiff;
  }
}

class AnimationSetting{
  final Duration duration;
  final Animation rotateAnimation;

  AnimationSetting({this.duration, this.rotateAnimation});


}
