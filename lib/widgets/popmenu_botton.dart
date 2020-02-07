import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/json/color_bean.dart';
import 'package:todo_list/json/task_bean.dart';
import 'package:todo_list/config/all_types.dart';
import 'package:todo_list/database/database.dart';
import 'package:todo_list/model/global_model.dart';
import 'package:todo_list/config/provider_config.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/widgets/text_color_picker.dart';

class PopMenuBt extends StatelessWidget {
  final Color iconColor;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final TaskBean taskBean;

  const PopMenuBt({
    Key key,
    this.iconColor,
    this.onDelete,
    this.onEdit,
    this.taskBean,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final globalModel = Provider.of<GlobalModel>(context);

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
          case "clearBackground":
            taskBean.backgroundUrl = null;
            refreshTaskCard(globalModel);
            break;
          case "textColor":
            _showColorPicker(context,globalModel,ColorBean.fromBean(taskBean.taskIconBean.colorBean));
            break;
        }
      },
      itemBuilder: (ctx) {
        return [
          PopupMenuItem(
            value: "edit",
            child: ListTile(
              title: Text(IntlLocalizations.of(context).editTask),
              leading: Icon(
                Icons.edit,
                color: iconColor,
              ),
            ),
          ),
          PopupMenuItem(
              value: "delete",
              child: ListTile(
                title: Text(IntlLocalizations.of(context).deleteTask),
                leading: Icon(Icons.delete, color: iconColor),
              )),
          PopupMenuItem(
            value: "background",
            child: ListTile(
              title: Text(IntlLocalizations.of(context).setBackground),
              leading: Icon(Icons.image, color: iconColor),
            ),
          ),
          taskBean.backgroundUrl == null
              ? null
              : PopupMenuItem(
                  value: "clearBackground",
                  child: ListTile(
                    title: Text(IntlLocalizations.of(context).clearBackground),
                    leading: Icon(Icons.clear, color: iconColor),
                  ),
                ),
          PopupMenuItem(
            value: "textColor",
            child: ListTile(
              title: Text(IntlLocalizations.of(context).textColor),
              leading: Icon(Icons.format_color_text, color: iconColor),
            ),
          ),
        ];
      },
      icon: Icon(
        Icons.more_vert,
        color: iconColor ?? Theme.of(context).primaryColor,
      ),
    );
  }

  void refreshTaskCard(GlobalModel globalModel) {
     DBProvider.db.updateTask(taskBean);
    final searchModel = globalModel.searchPageModel;
    final taskDetailPageModel = globalModel.taskDetailPageModel;
    taskDetailPageModel?.refresh();
    final mainPageModel = globalModel.mainPageModel;
     if(searchModel != null){
       searchModel.refresh();
       mainPageModel?.logic?.getTasks()?.then((v){
         mainPageModel?.refresh();
         return;
       });
     } else {
       mainPageModel?.refresh();
     }
  }

  void _showColorPicker(BuildContext context, GlobalModel globalModel, Color initialColor) {
    showDialog(
        context: context,
        builder: (ctx) {
          return TextColorPicker(
            initialColor: initialColor,
            onColorChanged: (Color color) {
              final colorBean = ColorBean.fromColor(color);
              taskBean.textColor = colorBean;
              refreshTaskCard(globalModel);
            },
          );
        });
  }
}
