import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/model/all_model.dart';
import 'package:todo_list/pages/all_page.dart';

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

 ChangeNotifierProvider<MainPageModel> getMainPage(){
    return ChangeNotifierProvider<MainPageModel>(
      builder:(context) => MainPageModel(),
      child: MainPage(),
    );
  }
  
  ChangeNotifierProvider<TaskDetailPageModel> getTaskDetailPage(int index){
     return ChangeNotifierProvider<TaskDetailPageModel>(
       builder:(context) => TaskDetailPageModel(),
       child: TaskDetailPage(index),
     );
   }
    
    


}