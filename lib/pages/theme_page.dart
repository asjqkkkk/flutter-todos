import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/json/theme_bean.dart';
import 'package:todo_list/model/global_model.dart';
import 'package:todo_list/model/theme_page_model.dart';
import 'package:todo_list/utils/shared_util.dart';
import 'package:todo_list/utils/theme_util.dart';
import 'dart:convert';

import 'package:todo_list/widgets/custom_animated_switcher.dart';

class ThemePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ThemePageModel>(context)..setContext(context);
    final globalModel = Provider.of<GlobalModel>(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(DemoLocalizations.of(context).changeTheme),
        actions: <Widget>[
          model.themes.length > 7 ? CustomAnimatedSwitcher(
            firstChild: IconButton(
              icon: Icon(
                Icons.border_color,
                size: 18,
                color: globalModel.logic.getWhiteInDark(),
              ),
              onPressed: null,
            ),
            secondChild: IconButton(
              icon: Icon(
                Icons.check,
                color: globalModel.logic.getWhiteInDark(),
              ),
              onPressed: null,
            ),
            hasChanged: model.isDeleting,
            onTap: () {
              model.isDeleting = !model.isDeleting;
              model.refresh();
            },
          ) : SizedBox(),
        ],
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Wrap(
            children: List.generate(model.themes.length + 1, (index) {
              if (index == model.themes.length) {
                return AbsorbPointer(
                  absorbing: model.isDeleting,
                  child: Opacity(
                    opacity: model.isDeleting ? 0 : 1,
                    child: InkWell(
                      onTap: model.logic.createCustomTheme,
                      child: Container(
                        height: (size.width - 140) / 3,
                        width: (size.width - 140) / 3,
                        margin: EdgeInsets.all(20),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 40,
                        ),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            gradient: LinearGradient(
                                colors: [
                                  Colors.redAccent,
                                  Colors.greenAccent,
                                  Colors.blueAccent,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight)),
                      ),
                    ),
                  ),
                );
              }
              final themeBean = model.themes[index];
              return Stack(
                children: <Widget>[
                  AbsorbPointer(
                    absorbing: model.isDeleting,
                    child: getThemeBloc(
                      themeBean,
                      size,
                      globalModel,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: AbsorbPointer(
                      absorbing: model.isDeleting ? false : true,
                      child: Opacity(
                        opacity: model.isDeleting ? 1.0 : 0.0,
                        child: IconButton(
                          icon: Icon(
                            Icons.cancel,
                            color: Colors.redAccent,
                          ),
                          onPressed: () => model.logic.removeIcon(index),
                        ),
                      ),
                    ),
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget getThemeBloc(ThemeBean themeBean, Size size, GlobalModel globalModel) {
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      onTap: () {
        globalModel.currentThemeBean = themeBean;
        globalModel.refresh();
        SharedUtil.instance
            .saveString(Keys.currentThemeBean, jsonEncode(themeBean.toMap()));
      },
      child: Container(
        height: (size.width - 140) / 3,
        width: (size.width - 140) / 3,
        margin: EdgeInsets.all(20),
        alignment: Alignment.center,
        child: Text(
          themeBean.themeName,
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
        decoration: BoxDecoration(
          color: themeBean.themeType == MyTheme.darkTheme
              ? Colors.black
              : ColorBean.fromBean(themeBean.colorBean),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }
}
