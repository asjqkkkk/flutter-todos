import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/config/api_strategy.dart';
import 'package:todo_list/config/provider_config.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/items/feedback_item.dart';
import 'package:todo_list/model/feedback_wall_page_model.dart';
import 'package:todo_list/widgets/loading_widget.dart';

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
                  return ProviderConfig.getInstance().getFeedbackPage(model);
                }));
              })
        ],
      ),
      body: Container(
        child: model.suggestionList.isEmpty ? LoadingWidget(
          flag: model.loadingFlag,
          errorCallBack: (){
            model.loadingFlag = LoadingFlag.loading;
            model.refresh();
            model.logic.getSuggestions();
          },
        ) : ListView.builder(
          itemBuilder: (ctx, index) {
            final bean = model.suggestionList[index];
            final connectWay = bean.connectWay;
            final splitData = connectWay.split("<emoji>");
            String emoji = "4";
            for (var o in splitData) {
              if(o.isNotEmpty){
                emoji = o;
              }
            }
            return FeedbackItem(
              userName: bean.userName,
              avatarUrl: ApiStrategy.baseUrl + bean.avatarUrl ?? "files/default/2019/7/1564207029288.jpg",
              submitTime: bean.time,
              suggestion: bean.suggestion,
              emoji: emoji,
              index: index,
            );
          },
          itemCount: model.suggestionList.length,
        ),
      ),
    );
  }
}
