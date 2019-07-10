import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/model/global_model.dart';
import 'package:todo_list/utils/shared_util.dart';
import 'package:todo_list/utils/theme_util.dart';

class ThemePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(DemoLocalizations.of(context).changeTheme),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Wrap(
          children: <Widget>[
            getThemeBloc(DemoLocalizations.of(context).pink, MyThemeColor.defaultColor, MyTheme.defaultTheme,context),
            getThemeBloc(DemoLocalizations.of(context).dark, Colors.black,MyTheme.darkTheme,context),
            getThemeBloc(DemoLocalizations.of(context).coffee, MyThemeColor.coffeeColor,MyTheme.coffeeTheme,context),
            getThemeBloc(DemoLocalizations.of(context).green, MyThemeColor.greenColor,MyTheme.greenTheme,context),
            getThemeBloc(DemoLocalizations.of(context).purple, MyThemeColor.purpleColor,MyTheme.purpleTheme,context),
            getThemeBloc(DemoLocalizations.of(context).cyan, MyThemeColor.cyanColor,MyTheme.cyanTheme,context),
            getThemeBloc(DemoLocalizations.of(context).blueGray, MyThemeColor.blueGrayColor,MyTheme.blueGrayTheme,context),

          ],
        ),
      ),
    );
  }

  Widget getThemeBloc(String themeName, Color blockColor, String themeType,BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      onTap: (){
        final model = Provider.of<GlobalModel>(context);
        model.currentThemeType = themeType;
        model.refresh();
        SharedUtil.instance.saveString(Keys.currentThemeType, themeType);
      },
      child: Container(
        height: (size.width - 140) / 3,
        width: (size.width - 140) / 3,
        margin: EdgeInsets.all(20),
        alignment: Alignment.center,
        child: Text(
          themeName,
          style: TextStyle(color: Colors.white,fontSize: 12),
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
