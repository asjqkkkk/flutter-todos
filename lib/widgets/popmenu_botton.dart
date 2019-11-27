import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/config/all_types.dart';
import 'package:todo_list/config/provider_config.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/json/task_bean.dart';

class PopMenuBt extends StatelessWidget {
  final Color iconColor;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final TaskBean taskBean;

  const PopMenuBt({
    Key key,
    this.iconColor,
    this.onDelete,
    this.onEdit, this.taskBean,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (a) {
        switch (a) {
          case "edit":
            if (onEdit != null) onEdit();
            break;
          case "delete":
            if (onDelete != null) onDelete();
            break;
          case "background":
            Navigator.of(context).push(new CupertinoPageRoute(builder: (ctx) {
              return ProviderConfig.getInstance().getNetPicturesPage(
                useType: NetPicturesUseType.taskCardBackground,
                taskBean: taskBean,
              );
            }));
            break;
        }
      },
      itemBuilder: (ctx) {
        return [
          PopupMenuItem(
            value: "edit",
            child: ListTile(
                title: Text(DemoLocalizations.of(context).editTask),
                leading: Icon(Icons.edit,color: iconColor,),),
          ),
          PopupMenuItem(
              value: "delete",
              child: ListTile(
                title: Text(DemoLocalizations.of(context).deleteTask),
                leading: Icon(Icons.delete,color: iconColor),
              )),
          PopupMenuItem(
              value: "background",
              child: ListTile(
                  title: Text(DemoLocalizations.of(context).background),
                  leading: Icon(Icons.image,color: iconColor),)),
        ];
      },
      icon: Icon(
        Icons.more_vert,
        color: iconColor ?? Theme.of(context).primaryColor,
      ),
    );
  }
}
