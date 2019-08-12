import 'dart:async';

import 'package:flutter/material.dart';

class TaskDetailItem extends StatefulWidget {
  final double itemProgress;
  final Function onChecked;
  final TheProgress onProgressChanged;
  final String itemName;
  final int index;
  final Color iconColor;
  final bool showAnimation;

  TaskDetailItem({
    this.itemProgress = 0.0,
    this.onChecked,
    @required this.itemName,
    this.index = 0,
    this.onProgressChanged,
    this.iconColor,
    this.showAnimation = true,
  });

  @override
  _TaskDetailItemState createState() => _TaskDetailItemState();
}

class _TaskDetailItemState extends State<TaskDetailItem>
    with SingleTickerProviderStateMixin {
  double currentProgress = 0.0;
  bool progressShow = false;

  AnimationController _controller;
  Animation _animation;

  ///这个定时器是因为hero动画大概时间是1秒，等动画结束后再执行列表划出动画
  ///不过如果任务详情页是从"完成列表"页面过来的，就没有hero动画了，自然不需要这个timer
  Timer timer;

  @override
  void initState() {
    currentProgress = widget.itemProgress;
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
    if(!widget.showAnimation) {
      _controller?.forward();
      return;
    }
      timer = Timer(Duration(milliseconds: 600), () {
      _controller?.forward();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    _controller?.dispose();
    debugPrint("taskDetailItem ${widget.index} 销毁");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedBuilder(
      animation: _animation,
      builder: (ctx, child) {
        return Transform.translate(
          offset: Offset(
              (size.width + widget.index * 100) * (_animation.value - 1), 0),
          child: child,
        );
      },
      child: Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Checkbox(
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    value: currentProgress == 1.0,
                    onChanged: (value) {
                      setState(() {
                        if (value) {
                          currentProgress = 1.0;
                        } else {
                          currentProgress = 0.0;
                        }
                      });
                      if (widget.onChecked != null) {
                        widget.onChecked(currentProgress);
                      }
                    },
                    activeColor:
                        widget.iconColor ?? Theme.of(context).primaryColor,
                  ),
                ),
                Expanded(
                    flex: 8,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          if (currentProgress == 1.0) {
                            currentProgress = 0.0;
                          } else {
                            currentProgress = 1.0;
                          }
                          if (widget.onChecked != null) {
                            widget.onChecked(currentProgress);
                          }
                        });
                      },
                      child: Container(
                          margin: EdgeInsets.only(
                            left: 5,
                          ),
                          child: Text("${widget.itemName}")),
                    )),
                Expanded(
                    flex: 1,
                    child: progressShow
                        ? SizedBox()
                        : Text(
                            "${(currentProgress * 100).toInt()}%",
                            style: TextStyle(fontSize: 8),
                          )),
                Expanded(
                    flex: 1,
                    child: IconButton(
                        icon: Icon(
                          progressShow
                              ? Icons.arrow_drop_up
                              : Icons.arrow_drop_down,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            progressShow = !progressShow;
                          });
                        }))
              ],
            ),
            progressShow ? getProgressWidget(context) : SizedBox(),
          ],
        ),
      ),
    );
  }

  Row getProgressWidget(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 6,
          child: Container(
            margin: EdgeInsets.only(left: 22),
            height: 5,
            child: Slider(
                activeColor: widget.iconColor ?? Theme.of(context).primaryColor,
                value: currentProgress,
                onChanged: (value) {
                  setState(() {
                    currentProgress = value;
                  });
                  if (widget.onProgressChanged != null) {
                    widget.onProgressChanged(value);
                  }
                }),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          flex: 2,
          child: Text(
            "${(currentProgress * 100).toInt()}%",
            style: TextStyle(fontSize: 8),
          ),
        ),
      ],
    );
  }
}

typedef TheProgress = void Function(double value);
