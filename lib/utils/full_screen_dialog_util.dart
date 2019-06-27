import 'package:flutter/material.dart';

class FullScreenDialog{
  static FullScreenDialog _instance;

  static FullScreenDialog getInstance(){
    if(_instance == null){
        _instance = FullScreenDialog._internal();
    }
    return _instance;
  }

  FullScreenDialog._internal();

  void showDialog(BuildContext context,Widget child){
    Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (ctx,anm1,anm2){
          return child;
        }
    )
    );
  }
}