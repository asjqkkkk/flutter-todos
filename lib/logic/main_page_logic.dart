import 'package:flutter/material.dart';
import 'package:todo_list/config/provider_config.dart';
import 'package:todo_list/items/task_item.dart';
import 'package:todo_list/model/all_model.dart';
import 'package:todo_list/pages/task_detail_page.dart';

class MainPageLogic{

  final MainPageModel _model;

  MainPageLogic(this._model);


  List<Widget> getCards(context) {

    return List.generate(_model.tasks.length, (index){
      final taskBean = _model.tasks[index];
      return GestureDetector(
        child: TaskItem(index,taskBean),
        onTap: () {
          Navigator.of(context).push(new PageRouteBuilder(
              pageBuilder: (ctx, anm, anmS) {
                return ProviderConfig.getInstance().getTaskDetailPage(index,taskBean,mainPageModel: _model);
              },
              transitionDuration: Duration(milliseconds: 800)));
        },
      );
    });
  }

  Widget getIconText({Icon icon, String text, VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.grey.withOpacity(0.2)),
        child: Row(
          children: <Widget>[
            icon,
            SizedBox(
              width: 4,
            ),
            Text(text),
          ],
        ),
      ),
    );
  }
}