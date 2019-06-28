import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/model/global_model.dart';

class ProviderConfig{
  static ProviderConfig _instance;

  static ProviderConfig getInstance(){
    if(_instance == null){
        _instance = ProviderConfig._internal();
    }
    return _instance;
  }

  ProviderConfig._internal();


  ChangeNotifierProvider<GlobalModel> getGlobal(Widget child){
     return ChangeNotifierProvider<GlobalModel>(
       builder:(context) => GlobalModel(),
       child: child,
     );
   }


}