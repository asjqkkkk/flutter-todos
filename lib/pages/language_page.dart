import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/model/global_model.dart';
import 'package:todo_list/utils/shared_util.dart';

class LanguagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(DemoLocalizations.of(context).languageTitle),
      ),
      body: Container(
        child: Wrap(
          children: <Widget>[
            getLanguageBlock("中文", "zh", "CN", Colors.brown,context),
            getLanguageBlock("English", "en", "US", Colors.red,context),
          ],
        ),
      ),
    );
  }

  Widget getLanguageBlock(String description, String languageCode,
      String countruCode, Color blockColor, BuildContext context) {
    return InkWell(
      onTap: () {
        final model = Provider.of<GlobalModel>(context);
        model.currentLanguage = [languageCode,countruCode];
        model.refresh();
        SharedUtil.instance.saveStringList(Keys.currentLanguage, [languageCode, countruCode]);
      },
      child: Container(
        margin: EdgeInsets.all(20),
        height: 100,
        width: 100,
        alignment: Alignment.center,
        child: Text(
          description,
          style: TextStyle(color: Colors.white),
        ),
        decoration: BoxDecoration(
          color: blockColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }
}
