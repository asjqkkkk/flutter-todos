import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/config/provider_config.dart';
import 'package:todo_list/config/task_icon_config.dart';
import 'package:todo_list/model/global_model.dart';
import 'package:circle_list/circle_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_list/pages/edit_task_page.dart';

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
  List<TaskIcon> _children = [
    TaskIcon(Colors.blueGrey, "default", Icons.add),
    TaskIcon(Colors.teal, "radio", Icons.chrome_reader_mode),
    TaskIcon(Colors.orangeAccent, "game", Icons.videogame_asset),
    TaskIcon(Colors.green, "read", Icons.book),
    TaskIcon(Colors.brown, "sports", Icons.directions_run),
    TaskIcon(Colors.cyanAccent, "drive", Icons.drive_eta),
    TaskIcon(Colors.pink, "work", Icons.work),
  ];

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
                  initialAngle: -pi / 2,
                  origin: Offset(0, -size.width / 2 + 20),
                  showInitialAnimation: true,
                  children: List.generate(_children.length, (index) {
                    return GestureDetector(
                      onTap: (){
                        debugPrint("点击：${_children[index].taskName}");
                        doExit(context, _controller);
                        Navigator.of(context).push(new CupertinoPageRoute(builder: (ctx){
                         return ProviderConfig.getInstance().getEditTaskPage(_children[index],mainPageModel: globalModel.mainPageModel,);
                        }));

                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: _children[index].color, width: 1)),
                        child: Icon(
                          _children[index].iconData,
                          size: 40,
                          color: _children[index].color,
                        ),
                      ),
                    );
                  }),
                  innerCircleColor: Theme.of(context).primaryColorLight,
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
