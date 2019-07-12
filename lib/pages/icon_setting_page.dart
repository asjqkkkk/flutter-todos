import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/json/task_icon_bean.dart';
import 'package:todo_list/model/icon_setting_page_model.dart';

class IconSettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<IconSettingPageModel>(context);
    model.setContext(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(DemoLocalizations.of(context).iconSetting),
      ),
      body: Container(
          child: Column(
        children: <Widget>[
          Container(
            child: Text(DemoLocalizations.of(context).currentIcons),
            margin: EdgeInsets.only(top: 20, left: 25),
            alignment: Alignment.topLeft,
          ),
          Container(
            height: 150,
            alignment: Alignment.center,
            child: GridView.count(
              crossAxisCount: 2,
              scrollDirection: Axis.horizontal,
              children: List.generate(
                model.taskIcons.length,
                (index) {
                  final taskIcon = model.taskIcons[index];
                  return IconButton(
                      icon: Icon(
                        IconBean.fromBean(taskIcon.iconBean),
                        color: ColorBean.fromBean(taskIcon.colorBean),
                        size: 40,
                      ),
                      tooltip: taskIcon.taskName,
                      onPressed: () {});
                },
              ),
            ),
          ),
          Container(
            height: 1,
            color: Theme.of(context).dividerColor,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                alignment: Alignment.center,
                child: FutureBuilder(
                    future: IconBean.loadAsset(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container(
                          width: 100,
                          height: 100,
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).primaryColor),
                          ),
                        );
                      }
                      List<IconBean> icons = snapshot.data;
                      return Wrap(
                        children: List.generate(icons.length, (index) {
                          final icon = icons[index];
                          return Container(
                            margin: EdgeInsets.all(10),
                            child: Icon(
                              IconBean.fromBean(icon),
                              size: 30,
                            ),
                          );
                        }),
                      );
                    }),
              ),
            ),
          )
        ],
      )),
    );
  }
}
