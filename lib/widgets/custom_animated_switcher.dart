import 'package:flutter/material.dart';

class CustomAnimatedSwitcher extends StatefulWidget {
  final Duration duration;
  final Widget firstChild;
  final Widget secondChild;
  final bool hasChanged;
  final VoidCallback onTap;

  const CustomAnimatedSwitcher({
    Key key,
    this.duration,
    @required this.firstChild,
    @required this.secondChild,
    this.hasChanged = false, this.onTap,
  }) : super(key: key);

  @override
  _CustomAnimatedSwitcherState createState() => _CustomAnimatedSwitcherState();
}

class _CustomAnimatedSwitcherState extends State<CustomAnimatedSwitcher> {

  bool hasChanged;
  Widget theChild;

  @override
  void initState() {
    hasChanged = widget.hasChanged;
    theChild = Container(key: ValueKey(0),child: widget.firstChild,);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(widget.onTap != null){
          widget.onTap();
        }
        setState(() {
          hasChanged = !hasChanged;
          if(hasChanged){
            theChild = Container(key: ValueKey(1),child: widget.secondChild,);
          } else{
            theChild = Container(key: ValueKey(0),child: widget.firstChild,);
          }
        });
      },
      child: AnimatedSwitcher(
        duration: widget.duration ?? const Duration(milliseconds : 300),
        child: theChild,
        transitionBuilder: (child,animation){
          return ScaleTransition(scale: animation, child: child,);
        },
      ),
    );
  }
}
