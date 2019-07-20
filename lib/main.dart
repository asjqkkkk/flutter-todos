import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_list/config/provider_config.dart';
import 'package:todo_list/model/all_model.dart';
import 'package:todo_list/pages/main_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/utils/shared_util.dart';
import 'package:todo_list/utils/theme_util.dart';

import 'i10n/localization_intl.dart';

void main() {
//  SystemChrome.setPreferredOrientations(
//      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
    ProviderConfig.getInstance().getGlobal(MyApp()),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<GlobalModel>(context)..setContext(context);

    return MaterialApp(
        title: model.appName,
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
          debugPrint("app:${model.appName}");
            },
        locale: Locale(model.currentLanguageCode[0], model.currentLanguageCode[1]),
        theme: ThemeUtil.getInstance().getTheme(model.currentThemeBean),
        home: ProviderConfig.getInstance().getMainPage());
  }
}
