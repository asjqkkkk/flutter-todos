import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/model/global_model.dart';
import 'package:todo_list/utils/shared_util.dart';

class LanguagePage extends StatelessWidget {
  final List<LanguageData> languageDatas = [
    LanguageData("中文", "zh", "CN", "一日"),
    LanguageData("English", "en", "US", "One Day"),
  ];

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<GlobalModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(DemoLocalizations.of(context).languageTitle),
      ),
      body: Container(
        child: ListView(
          children: List.generate(languageDatas.length, (index) {
            final String languageCode = languageDatas[index].languageCode;
            final String countryCode = languageDatas[index].countryCode;
            final String language = languageDatas[index].language;
            final String appName = languageDatas[index].appName;
            return RadioListTile(
              value: language,
              groupValue: model.currentLanguage,
              onChanged: (value) {
                model.currentLanguageCode = [languageCode, countryCode];
                model.currentLanguage = language;
                model.currentLocale = Locale(languageCode, countryCode);
                model.appName = appName;
                model.refresh();
                SharedUtil.instance.saveStringList(
                    Keys.currentLanguageCode, [languageCode, countryCode]);
                SharedUtil.instance.saveString(Keys.currentLanguage, language);
                SharedUtil.instance.saveString(Keys.appName, appName);
              },
              title: Text(languageDatas[index].language),
            );
          }),
        ),
      ),
    );
  }
}

class LanguageData {
  String language;
  String languageCode;
  String countryCode;
  String appName;

  LanguageData(
      this.language, this.languageCode, this.countryCode, this.appName);
}
