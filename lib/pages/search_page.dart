import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/database/database.dart';
import 'package:todo_list/items/task_item.dart';
import 'package:todo_list/json/color_bean.dart';
import 'package:todo_list/json/task_bean.dart';
import 'package:todo_list/model/global_model.dart';
import 'package:todo_list/model/search_page_model.dart';
import 'package:todo_list/utils/theme_util.dart';
import 'package:todo_list/widgets/loading_widget.dart';

class SearchPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final globalModel = Provider.of<GlobalModel>(context);
    final model = Provider.of<SearchPageModel>(context)..setContext(context);
    final primaryColor = globalModel.logic.getPrimaryInDark(context);
    final bgColor = globalModel.logic.getBgInDark();

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0.0,
        title: TextField(
          style: TextStyle(
            color: primaryColor,
          ),
          textInputAction: TextInputAction.search,
          autofocus: true,
          controller: model.textEditingController,
          onEditingComplete: model.logic.onEditingComplete,
          decoration: new InputDecoration(
            hintText: "Search...",
            hintStyle: new TextStyle(color: primaryColor),
            suffixIcon: IconButton(
                icon: Icon(
                  Icons.clear,
                  color: primaryColor,
                ),
                onPressed:() => model.textEditingController?.clear(),),
            border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              borderSide: BorderSide(color: primaryColor, width: 1),
            ),
          ),
        ),
        backgroundColor: bgColor,
        iconTheme: IconThemeData(
          color: primaryColor,
        ),
      ),
      body: Container(
          child: model.loadingFlag != LoadingFlag.success
              ? LoadingWidget(
                  flag: model.loadingFlag,
                )
              : GridView.count(
                  crossAxisCount: 2,
                  children: List.generate(model.searchTasks.length, (index) {
                    final task = model.searchTasks[index];
                    return GestureDetector(
                      onTap:() => model.logic.onTaskTap(index, task),
                      child: TaskItem(
                        task.id,
                        task,
                        onDelete: () => model.logic.onDelete(globalModel, task),
                        onEdit: () => model.logic.onEdit(task, globalModel.mainPageModel),
                      ),
                    );
                  }),
                )),
    );
  }
}
