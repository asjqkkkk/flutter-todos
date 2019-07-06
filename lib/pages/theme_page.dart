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
        child: Wrap(
          children: <Widget>[
            getThemeBloc(DemoLocalizations.of(context).pink,
                Color.fromRGBO(246, 200, 200, 1), MyTheme.defaultTheme,context),
            getThemeBloc(DemoLocalizations.of(context).dark, Colors.black,MyTheme.darkTheme,context),

          ],
        ),
      ),
    );
  }

  Widget getThemeBloc(String themeName, Color blockColor, String themeType,BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      onTap: (){
        final model = Provider.of<GlobalModel>(context);
        model.currentThemeType = themeType;
        model.refresh();
        SharedUtil.instance.saveString(Keys.currentThemeType, themeType);
      },
      child: Container(
        height: 100,
        width: 100,
        margin: EdgeInsets.all(20),

        alignment: Alignment.center,
        child: Text(
          themeName,
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
