import 'package:flutter/material.dart';
import 'package:todo_list/model/all_model.dart';
import 'package:todo_list/utils/shared_util.dart';
import 'package:todo_list/utils/theme_util.dart';

class EditTaskPageLogic{

  final EditTaskPageModel _model;

  EditTaskPageLogic(this._model);

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

  //当为夜间模式时候，白色背景替换为特定灰色
  void getBgInDark() async{
    String currentThemeType = await SharedUtil.instance.getString(Keys.currentThemeType) ?? MyTheme.defaultTheme;
    Color color = currentThemeType == MyTheme.darkTheme ? Colors.grey[800] : Colors.white;
    _model.bgColor = color;
    _model.refresh();
  }

}