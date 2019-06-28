import 'package:flutter/material.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/pages/language_page.dart';

class NavPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text("name"),
          accountEmail: Text("email"),
          margin: EdgeInsets.all(0),
        ),
        ListTile(
          title: Text(DemoLocalizations.of(context).languageTitle),
          leading: Icon(Icons.language),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: (){
            Navigator.push(context, new MaterialPageRoute(builder: (ctx){
              return LanguagePage();
            }));
          },
        )
      ],
    );
  }
}
