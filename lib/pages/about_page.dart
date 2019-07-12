import 'package:flutter/material.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/json/icon_json_bean.dart';
import 'package:todo_list/utils/icon_list_util.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(DemoLocalizations.of(context).aboutApp),
      ),
      body: Container(
        alignment: Alignment.center,
        child: FutureBuilder(
            future: IconJsonBean.loadAsset(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor),
                );
              }
              List<IconJsonBean> icons = snapshot.data;
              return SingleChildScrollView(
                child: Wrap(
                  children: List.generate(icons.length, (index) {
                    final icon = icons[index];
                    return Container(
                      margin: EdgeInsets.all(10),
                      child: Icon(
                        IconData(
                          icon.codePoint,
                          fontFamily: icon.fontFamily,
                          matchTextDirection: icon.matchTextDirection,
                        ),
                        size: 40,
                      ),
                    );
                  }),
                ),
              );
            }),
      ),
    );
  }
}
