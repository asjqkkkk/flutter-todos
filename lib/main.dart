import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_list/config/provider_config.dart';
import 'package:todo_list/model/all_model.dart';
import 'package:todo_list/pages/main_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/utils/shared_util.dart';

import 'i10n/localization_intl.dart';

void main() {
  
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(

    ProviderConfig.getInstance().getGlobal(MyApp()),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<GlobalModel>(context);
    SharedUtil.instance.getStringList(Keys.currentLanguage).then((list){
      if(list == null) return;
      if(list == model.currentLanguage) return;
      model.currentLanguage = list;
      model.refresh();
    });

    return MaterialApp(
        title: 'ToDo List',
        localizationsDelegates: [
          // ... app-specific localization delegate[s] here
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          DemoLocalizationsDelegate()
        ],
        supportedLocales: [
          const Locale('en', 'US'), // 美国英语
          const Locale('zh', 'CN'), // 中文简体
        ],
        localeResolutionCallback:
            (Locale locale, Iterable<Locale> supportedLocales) {},
        localeListResolutionCallback:
            (List<Locale> locales, Iterable<Locale> supportedLocales) {
          debugPrint(
              "locales:${locales}   supportedLocales${supportedLocales} ");
        },
        locale: Locale(model.currentLanguage[0], model.currentLanguage[1]),
        theme: ThemeData(
            primaryColor: Color.fromRGBO(246, 200, 200, 1),
            primaryColorDark: Color.fromRGBO(255, 180, 180, 1),
            appBarTheme: AppBarTheme(
                textTheme: TextTheme(
                    title: TextStyle(color: Colors.white, fontSize: 20)))),
        home: ProviderConfig.getInstance().getMainPage());
  }
}
