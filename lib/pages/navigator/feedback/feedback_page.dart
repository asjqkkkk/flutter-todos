import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/model/feedback_page_model.dart';
import 'package:todo_list/model/feedback_wall_page_model.dart';
import 'package:todo_list/model/global_model.dart';

class FeedbackPage extends StatelessWidget {
  final FeedbackWallPageModel feedbackWallPageModel;

  FeedbackPage(this.feedbackWallPageModel);

  @override
  Widget build(BuildContext context) {
    final globalModel = Provider.of<GlobalModel>(context);
    final model = Provider.of<FeedbackPageModel>(context)..setContext(context);
    final primaryColor = globalModel.logic.getPrimaryInDark(context);
    final bool isDarkNow = globalModel.logic.isDarkNow();
    final size = MediaQuery.of(context).size;
    final feedbackFormHeight =
        (size.height / 2 - 100) < 300.0 ? 300.0 : (size.height / 2 - 100.0);
    final contactFormHeight =
        feedbackFormHeight / 3 < 100.0 ? 100.0 : feedbackFormHeight / 3;

    return Scaffold(
      appBar: AppBar(
        title: Text(IntlLocalizations.of(context).feedback),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () =>
                model.logic.onFeedbackSubmit(feedbackWallPageModel),
          )
        ],
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(model.svgPaths.length, (index) {
                  return InkWell(
                    child: Transform.scale(
                      scale: model.currentSelectSvg == index ? 1.5 : 1,
                      child: model.logic.getSvg(model.svgPaths[index]),
                    ),
                    onTap: () => model.logic.onSvgTap(index),
                  );
                }),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(5),
              height: feedbackFormHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                border: Border.all(
                  color: primaryColor,
                  width: 3,
                ),
              ),
              child: TextFormField(
                expands: true,
                maxLines: null,
                  textInputAction: TextInputAction.newline,
                onChanged: (text){
                  model.feedbackContent = text;
                },
                style: TextStyle(
                    color: isDarkNow ? Colors.grey : Colors.black,
                    textBaseline: TextBaseline.alphabetic),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    border: InputBorder.none,
                    hintText:
                        IntlLocalizations.of(context).writeYourFeedback,
                    hintStyle: TextStyle(color: Colors.grey)),
                maxLength: 2000,
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(5),
              height: contactFormHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                border: Border.all(
                  color: primaryColor,
                  width: 3,
                ),
              ),
              child: Form(
                autovalidateMode: AutovalidateMode.always,
                child: TextFormField(
                  expands: true,
                  maxLines: null,
                  validator: (text) {
                    model.contactWay = text;
                    return null;
                  },
                  style: TextStyle(
                      color: isDarkNow ? Colors.grey : Colors.black),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.contact_mail,
                      color: primaryColor,
                    ),
                    hintText:
                        IntlLocalizations.of(context).writeYourContactInfo,
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
