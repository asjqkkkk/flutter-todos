import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/config/provider_config.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/items/feedback_item.dart';
import 'package:todo_list/model/feedback_wall_page_model.dart';

class FeedbackWallPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<FeedbackWallPageModel>(context)
      ..setContext(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(DemoLocalizations.of(context).feedbackWall),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(context, new CupertinoPageRoute(builder: (ctx) {
                  return ProviderConfig.getInstance().getFeedbackPage();
                }));
              })
        ],
      ),
      body: Container(
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            return FeedbackItem();
          },
          itemCount: 10,
        ),
      ),
    );
  }
}
