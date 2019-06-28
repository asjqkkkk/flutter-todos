import 'dart:math';

import 'package:flutter/material.dart';
import 'package:todo_list/utils/full_screen_dialog_util.dart';
import 'package:todo_list/widgets/bottom_show_widget.dart';
import 'package:todo_list/widgets/floating_border.dart';

class ScaleFloatingButton extends StatefulWidget {
  @override
  _ScaleFloatingButtonState createState() => _ScaleFloatingButtonState();
}

class _ScaleFloatingButtonState extends State<ScaleFloatingButton>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animation = new Tween(begin: 1.0, end: 2.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (ctx, child) {
        return Transform.rotate(
          angle: (1- _animation.value) * pi * 2,
            child: Transform.scale(
          scale: _animation.value,
          child: child,
        ));
      },
      child: FloatingActionButton(
        onPressed: () {
          FullScreenDialog.getInstance().showDialog(context, BottomShowWidget(
            onExit: () {
              _controller.reverse();
            },
          ));
          _controller.forward();
        },
        child: Icon(
          Icons.menu,
          size: 30,
        ),
        backgroundColor: Theme.of(context).primaryColorDark,
        shape: FloatingBorder(),
      ),
    );
  }
}
