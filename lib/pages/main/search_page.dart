import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/items/task_item.dart';
import 'package:todo_list/model/global_model.dart';
import 'package:todo_list/model/search_page_model.dart';
import 'package:todo_list/widgets/loading_widget.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final globalModel = Provider.of<GlobalModel>(context);
    final model = Provider.of<SearchPageModel>(context)..setContext(context,globalModel);
    globalModel.setSearchPageModel(model);
    final primaryColor = globalModel.logic.getPrimaryInDark(context);
    final bgColor = globalModel.logic.getWhiteInDark();

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        elevation: 0.0,
        title: TextField(
          style: TextStyle(
            color: bgColor,
              textBaseline: TextBaseline.alphabetic
          ),
          textInputAction: TextInputAction.search,
          autofocus: true,
          controller: model.textEditingController,
          onEditingComplete: model.logic.onEditingComplete,
          decoration: new InputDecoration(
            hintText: IntlLocalizations.of(context).tryToSearch,
            hintStyle: new TextStyle(color: bgColor),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.clear,
                color: bgColor,
              ),
              onPressed: () => Future.delayed(Duration(milliseconds: 100), () {
                model.textEditingController?.clear();
              }),
            ),
            border: InputBorder.none,
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: bgColor, width: 1),
            ),
          ),
        ),
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(
          color: bgColor,
        ),
      ),
      body: Container(
          child: model.loadingFlag != LoadingFlag.success
              ? Center(
            child: SingleChildScrollView(
              child: LoadingWidget(
                flag: model.loadingFlag,
                progressColor: bgColor,
                textColor: globalModel.logic.getWhiteInDark(),
              ),
            ),
          )
              : GridView.count(
            crossAxisCount: 2,
                children: List.generate(model.searchTasks.length, (index) {
                  final task = model.searchTasks[index];
                  return GestureDetector(
                    onTap: () => model.logic.onTaskTap(index, task, globalModel),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: TaskItem(
                        task.id,
                        task,
                        onDelete: () => model.logic.onDelete(globalModel, task),
                        onEdit: () => model.logic.onEdit(task, globalModel.mainPageModel),
                      ),
                    ),
                  );
                }),
              ),),
    );
  }
}
