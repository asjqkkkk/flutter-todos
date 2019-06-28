import 'package:flutter/material.dart';
import 'package:todo_list/i10n/localization_intl.dart';

class LanguagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(DemoLocalizations.of(context).languageTitle),),
      body: Container(
        child: Wrap(
          children: <Widget>[
            getLanguageBlock("中文",Colors.brown),
            getLanguageBlock("English",Colors.red),
          ],
        ),
      ),
    );
  }

  Container getLanguageBlock(String description, Color blockColor) {
    return Container(
            margin: EdgeInsets.all(20),
            height: 100,
            width: 100,
            alignment: Alignment.center,
            child: Text(description,style: TextStyle(color: Colors.white),),
            decoration: BoxDecoration(
              color: blockColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          );
  }
}
