import 'package:flutter/material.dart';

class TaskDetailItem extends StatefulWidget {
  final double itemProgress;
  final Function onChecked;
  final String itemName;
  final int index;

  TaskDetailItem(
      {this.itemProgress = 0.0, this.onChecked, @required this.itemName, this.index = 0});

  @override
  _TaskDetailItemState createState() => _TaskDetailItemState();
}

class _TaskDetailItemState extends State<TaskDetailItem> with SingleTickerProviderStateMixin{
  double currentProgress = 0.0;
  bool progressShow = false;

  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    currentProgress = widget.itemProgress;
    _controller = AnimationController(vsync: this,duration: Duration(milliseconds: 1000));
    _animation = Tween(begin: 0.0,end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
    Future.delayed(Duration(seconds: 1,), (){
      _controller.forward();
    });
  }


  @override
  void dispose() {
    super.dispose();
    debugPrint("taskDetailItem销毁");
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return AnimatedBuilder(
      animation: _animation,
      builder: (ctx, child){
        return Transform.translate(offset: Offset((size.width + widget.index * 100) * (_animation.value - 1), 0), child: child,);
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
                      if (widget.onChecked != null) {
                        widget.onChecked(value, currentProgress);
                      }
                      setState(() {
                        if (value == true) {
                          currentProgress = 1.0;
                        } else {
                          currentProgress = widget.itemProgress;
                        }
                      });
                    },
                    activeColor: Theme.of(context).primaryColor,
                  ),
                ),
                Expanded(
                    flex: 8,
                    child: Container(
                        margin: EdgeInsets.only(left: 5),
                        child: Text("${widget.itemName}"))),
                Expanded(
                    flex: 1,
                    child: IconButton(
                        icon: Icon(progressShow?Icons.arrow_drop_up:Icons.arrow_drop_down,color: Colors.grey,), onPressed: (){
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
                margin: EdgeInsets.only(left: 40),
                height: 5,
                child: LinearProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(
                      Theme.of(context).primaryColor),
                  value: currentProgress,
                  backgroundColor: Color.fromRGBO(224, 224, 224, 1),
                ),
              ),
            ),
            SizedBox(width: 20,),
            Expanded(flex: 2,child: Text("${(currentProgress * 100).toInt()}%",style: TextStyle(fontSize: 8),),),
          ],
        );
  }
}
