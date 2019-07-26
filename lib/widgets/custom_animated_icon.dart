import 'package:flutter/material.dart';

class CustomAnimatedIcon extends StatefulWidget {
  final Color color;
  final double size;
  final AnimatedIconData firstIcon;
  final AnimatedIconData secondIcon;
  final Duration duration;
  final VoidCallback onTap;
  final bool hasTapped;

  const CustomAnimatedIcon(
      {Key key,
      this.color,
      this.size,
      @required this.firstIcon,
      @required this.secondIcon,
      this.duration,
      this.onTap, this.hasTapped = false})
      : super(key: key);

  @override
  _CustomAnimatedIconState createState() => _CustomAnimatedIconState();
}

class _CustomAnimatedIconState extends State<CustomAnimatedIcon>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;
  bool hasTapped;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: widget.duration ?? Duration(milliseconds: 300));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    hasTapped = widget.hasTapped;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);


    return InkWell(
      child: AnimatedIcon(
        icon: hasTapped ? widget.secondIcon : widget.firstIcon,
        progress: _animation,
        color: widget.color ?? iconTheme,
        size: widget.size ?? iconTheme.size,
      ),
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap();
        }
        if(mounted){
          setState(() {
            hasTapped = !hasTapped;
          });
        }
      },
    );
  }
}
