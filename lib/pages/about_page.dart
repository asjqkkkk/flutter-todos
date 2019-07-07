import 'package:flutter/material.dart';
import 'package:todo_list/i10n/localization_intl.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(DemoLocalizations.of(context).aboutApp),),
      body: Container(

      ),
    );
  }
}
