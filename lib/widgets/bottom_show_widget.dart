import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/model/global_model.dart';
import 'package:circle_list/circle_list.dart';

class BottomShowWidget extends StatefulWidget {
  final VoidCallback onExit;

  BottomShowWidget({this.onExit});

  @override
  _BottomShowWidgetState createState() => _BottomShowWidgetState();
}

class _BottomShowWidgetState extends State<BottomShowWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animation = new Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine));
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    debugPrint("top_show销毁");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final globalModel = Provider.of<GlobalModel>(context);

    return GestureDetector(
      onTap: () {
        doExit(context, _controller);
      },
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0),
        body: Container(
          width: size.width,
          height: size.height,
          child: Stack(
            children: <Widget>[
              Positioned(
                bottom: 20,
                left: size.width / 2 - 28,
                child: AnimatedBuilder(
                    animation: _animation,
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          shape: BoxShape.circle),
                    ),
                    builder: (ctx, child) {
                      return Transform.scale(
                        scale: (size.height / 28) * (_animation.value),
                        child: child,
                      );
                    }),
              ),
              AnimatedBuilder(
                animation: _animation,
                child: CircleList(
                  origin: Offset(0, -size.width / 2 + 20),
                  showInitialAnimation: true,
                  children: [
                    Icon(
                      Icons.laptop_chromebook,
                      color: Colors.redAccent,
                      size: 40,
                    ),
                    Icon(
                      Icons.chrome_reader_mode,
                      color: Colors.lightBlueAccent,
                      size: 40,
                    ),
                    Icon(
                      Icons.videogame_asset,
                      color: Colors.orangeAccent,
                      size: 40,
                    ),
                    Icon(
                      Icons.local_drink,
                      color: Colors.green,
                      size: 40,
                    ),
                    Icon(
                      Icons.landscape,
                      color: Colors.pinkAccent,
                      size: 40,
                    ),
                    Icon(
                      Icons.drive_eta,
                      color: Colors.cyanAccent,
                      size: 40,
                    ),
                    Icon(
                      Icons.directions_run,
                      color: Colors.brown,
                      size: 40,
                    ),
                  ],
                  innerCircleColor: Theme.of(context).primaryColor,
                  outerCircleColor: globalModel.logic.getBgInDark(),
                  centerWidget: GestureDetector(
                      onTap: () {
                        doExit(context, _controller);
                        debugPrint("点击");
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3,
                        height: MediaQuery.of(context).size.width / 3,
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          shape: BoxShape.circle,
                        ),
                        child: Container(
                          color: Colors.transparent,
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                      )),
                ),
                builder: (ctx, child) {
                  return Transform.translate(
                      offset: Offset(
                          0,
                          MediaQuery.of(context).size.height -
                              (_animation.value) * size.width),
                      child: Transform.scale(
                          scale: _animation.value, child: child));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void doExit(BuildContext context, AnimationController controller) {
    widget?.onExit();
    controller.reverse().then((r) {
      Navigator.of(context).pop();
    });
  }
}
