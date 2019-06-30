import 'package:flutter/material.dart';
import 'package:todo_list/config/provider_config.dart';
import 'package:todo_list/items/task_item.dart';
import 'package:todo_list/model/all_model.dart';
import 'package:todo_list/pages/task_detail_page.dart';

class MainPageLogic{

  final MainPageModel _model;

  MainPageLogic(this._model);


  List<Widget> getCards(context) {
    List<Widget> list = [];
    for (var i = 0; i < 10; i++) {
      list.add(GestureDetector(
        child: TaskItem(i),
        onTap: () {
          Navigator.of(context).push(new PageRouteBuilder(
              pageBuilder: (ctx, anm, anmS) {
                return ProviderConfig.getInstance().getTaskDetailPage(i);
              },
              transitionDuration: Duration(seconds: 1)));
        },
      ));
    }
    return list;
  }
}