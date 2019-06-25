import 'package:flutter/material.dart';

class ShowWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Icon(
            Icons.laptop_chromebook,
            color: Colors.redAccent,
          ),
          Icon(
            Icons.chrome_reader_mode,
            color: Colors.lightBlueAccent,
          ),
          Icon(
            Icons.videogame_asset,
            color: Colors.orangeAccent,
          ),
          Icon(
            Icons.local_drink,
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}

class ShowAnimateWidget extends StatefulWidget {
  @override
  _ShowAnimateWidgetState createState() => _ShowAnimateWidgetState();
}

class _ShowAnimateWidgetState extends State<ShowAnimateWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1500));
    _animation = new Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Icon> icons = [
    Icon(
      Icons.laptop_chromebook,
      color: Colors.redAccent,
    ),
    Icon(
      Icons.chrome_reader_mode,
      color: Colors.lightBlueAccent,
    ),
    Icon(
      Icons.videogame_asset,
      color: Colors.orangeAccent,
    ),
    Icon(
      Icons.local_drink,
      color: Colors.green,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (ctx, index){
          return _getAnimate(icons[index], _animation,context,4);
        },
      ),
    );
  }

  Widget _getAnimate(Widget child, Animation animation, BuildContext context, int length) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: length >= 4 ? (size.width / 4) : (size.width / length),
      alignment: Alignment.center,
      child: AnimatedBuilder(
        animation: animation,
        child: child,
        builder: (ctx, child){
          return Transform.scale(
            scale: animation.value,
            child: child,
          );
        },
      ),
    );
  }
}
