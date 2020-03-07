import 'package:flutter/material.dart';

class OverlayUtil{
  static OverlayUtil _instance;

  static OverlayUtil getInstance(){
    if(_instance == null){
        _instance = OverlayUtil._internal();
    }
    return _instance;
  }

  OverlayUtil._internal();

  OverlayEntry _overlayEntry;
//  Timer timeTask;



  void show(BuildContext context, {Widget showWidget, String text = "默认显示内容",Duration duration }){
    if(_overlayEntry == null){
      _showEntry(showWidget, context,text,duration);
    } else{
      _overlayEntry.remove();
      _overlayEntry = null;
      _showEntry(showWidget, context,text,duration);
    }
  }

  void hide(){
    if(_overlayEntry != null){
      _overlayEntry.remove();
      _overlayEntry = null;
    }
  }

  void _showEntry(Widget showWidget, BuildContext context, String text, Duration duration) {
    _overlayEntry = OverlayEntry(builder: (ctx){
      return showWidget??_defaultShow(text);
    });
    Overlay.of(context).insert(_overlayEntry);
//    timeTask?.cancel();
//    timeTask = Timer(duration??Duration(seconds: 3), (){
//      if(_overlayEntry != null){
//        _overlayEntry.remove();
//        _overlayEntry = null;
//      }
//    });
  }

  Widget _defaultShow(String text){
    return Container(
      alignment: Alignment.bottomCenter,
      margin: EdgeInsets.only(bottom: 50),

      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.grey.withOpacity(0.5),
        child: Container(
          margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: Text(
            text,
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }

}