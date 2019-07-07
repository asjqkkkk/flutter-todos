import 'package:flutter/material.dart';
import 'package:todo_list/i10n/localization_intl.dart';

class PopMenuBt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (ctx) {
        return [
          PopupMenuItem(
              child: Container(
            child: Text(DemoLocalizations.of(context).editTask),
            alignment: Alignment.centerLeft,
          )),
          PopupMenuItem(
              child: Container(
            child: Text(DemoLocalizations.of(context).deleteTask),
            alignment: Alignment.centerLeft,
          )),
        ];
      },
      icon: Icon(
        Icons.more_vert,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
