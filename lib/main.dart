import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_list/pages/main_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'i10n/localization_intl.dart';

void main(){
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
        localeResolutionCallback: (Locale locale, Iterable<Locale> supportedLocales){
        },
        localeListResolutionCallback: (List<Locale> locales, Iterable<Locale> supportedLocales){
          debugPrint("locales:${locales}   supportedLocales${supportedLocales} ");

        },
        locale: Locale('zh', 'CN'),
      theme: ThemeData(
        primaryColor: Color.fromRGBO(246,200,200,1),
        primaryColorDark: Color.fromRGBO(255,180,180,1),
        appBarTheme: AppBarTheme(
          textTheme: TextTheme(
            title: TextStyle(color: Colors.white, fontSize: 20)
          )
        )
      ),
      home: MainPage()
    );
  }
}


