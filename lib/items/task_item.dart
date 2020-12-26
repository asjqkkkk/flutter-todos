import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/json/task_bean.dart';
import 'package:todo_list/model/global_model.dart';
import 'package:todo_list/widgets/custom_cache_provider.dart';
import 'package:todo_list/widgets/task_info_widget.dart';

class TaskItem extends StatelessWidget {
  final int index;
  final TaskBean taskBean;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  TaskItem(this.index, this.taskBean, {this.onDelete, this.onEdit});

  @override
  Widget build(BuildContext context) {
    final globalModel = Provider.of<GlobalModel>(context);

    final widget = TaskInfoWidget(
      index,
      space: 0,
      taskBean: taskBean,
      onDelete: onDelete,
      onEdit: onEdit,
      isCardChangeWithBg: globalModel.isCardChangeWithBg,
    );

    final bgUrl = taskBean.backgroundUrl;
    final opacity = globalModel.mainPageModel.currentTransparency;

    return Container(
      margin: EdgeInsets.all(10),
      child: Stack(
        children: <Widget>[
          Hero(
            tag: "task_bg$index",
            child: Container(
              decoration: BoxDecoration(
                color: globalModel.logic.getBgInDark().withOpacity(opacity),
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(color: Theme.of(context).cardColor),
                image: bgUrl == null
                    ? null
                    : DecorationImage(
                        image: getProvider(bgUrl),
                        colorFilter: new ColorFilter.mode(
                            Colors.black.withOpacity(opacity), BlendMode.dstATop),
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),
          Container(
            child: Container(
              margin: EdgeInsets.all(0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                child: widget,
              ),
            )
          ),
        ],
      ),
    );
  }
}
