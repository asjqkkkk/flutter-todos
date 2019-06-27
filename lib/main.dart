import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_list/pages/main_page.dart';

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


