import 'package:flutter/material.dart';
import 'package:todo_list/config/provider_config.dart';
import 'package:todo_list/model/all_model.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/pages/home/splash_page.dart';
import 'package:todo_list/utils/theme_util.dart';

import 'i10n/localization_intl.dart';

void main() {
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
        GlobalCupertinoLocalizations.delegate,
        DemoLocalizationsDelegate()
      ],
      supportedLocales: [
        const Locale('en', 'US'), // 美国英语
        const Locale('zh', 'CN'), // 中文简体
      ],
      localeResolutionCallback:
          (Locale locale, Iterable<Locale> supportedLocales) {
        debugPrint("locale:$locale   sups:$supportedLocales  currentLocale:${model.currentLocale}");
        if (model.currentLocale == locale) return model.currentLocale;
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale == locale) {
            model.currentLocale = locale;
            model.currentLanguageCode = [
              locale.languageCode,
              locale.countryCode
            ];
            locale.countryCode == "CN"
                ? model.currentLanguage = "中文"
                : model.currentLanguage = "English";
            return model.currentLocale;
          }
        }
        if (model.currentLocale == null) {
          model.currentLocale = Locale('zh', "CN");
          return model.currentLocale;
        }
        return model.currentLocale;
      },
      localeListResolutionCallback:
          (List<Locale> locales, Iterable<Locale> supportedLocales) {
        debugPrint("locatassss:$locales  sups:$supportedLocales");
        return model.currentLocale;
      },
      locale: model.currentLocale,
      theme: ThemeUtil.getInstance().getTheme(model.currentThemeBean),
      home: getHomePage(model.goToLogin, model.enableSplashAnimation),
    );
  }

  Widget getHomePage(bool goToLogin, bool enableSplashAnimation){
    if(goToLogin == null) return Container();
    if(enableSplashAnimation) return new SplashPage();
    return goToLogin ? ProviderConfig.getInstance().getLoginPage(isFirst: true)
        : ProviderConfig.getInstance().getMainPage();
  }

}
