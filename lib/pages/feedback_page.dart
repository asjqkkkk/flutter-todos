import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/model/global_model.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  int currentSelectSvg = -99;

  final List<String> svgPaths = [
    "svgs/mood_1.svg",
    "svgs/mood_2.svg",
    "svgs/mood_3.svg",
    "svgs/mood_4.svg",
    "svgs/mood_5.svg",
  ];

  String feedbackContent = "";
  String contactWay = "";

  @override
  Widget build(BuildContext context) {
    final globalModel = Provider.of<GlobalModel>(context);
    final primaryColor = globalModel.logic.getPrimaryInDark(context);
    final bgColor = globalModel.logic.getWhiteInDark();
    final whiteInDark = globalModel.logic.getWhiteInDark();
    final size = MediaQuery.of(context).size;
    final feedbackFormHeight =
        (size.height / 2 - 100) > 300.0 ? 300.0 : (size.height / 2 - 100.0);
    final contactFormHeight = feedbackFormHeight / 3;

    return Scaffold(
      appBar: AppBar(
        title: Text(DemoLocalizations.of(context).feedback),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.check), onPressed: (){
            if(feedbackContent.isEmpty){
              showWrongDialog(context,DemoLocalizations.of(context).feedbackCantBeNull);
              return;
            } else if(feedbackContent.length < 10){
              showWrongDialog(context,DemoLocalizations.of(context).feedbackIsTooLittle);
            }
            if(currentSelectSvg == -99){
              showWrongDialog(context,DemoLocalizations.of(context).feedbackNeedEmoji);
            }
          })
        ],
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(svgPaths.length, (index) {
                  return InkWell(
                    child: Transform.scale(
                      scale: currentSelectSvg == index ? 1.5 : 1,
                      child: getSvg(svgPaths[index]),
                    ),
                    onTap: () {
                      if (currentSelectSvg == index) {
                        currentSelectSvg = -99;
                      } else {
                        currentSelectSvg = index;
                      }
                      setState(() {});
                    },
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
              child: Form(
                autovalidate: true,
                child: Theme(
                  //使用下面这个data是因为目前ios上有长按复制奔溃的问题，下面这样可以解决这个问题
                  data: ThemeData(platform: TargetPlatform.android),
                  child: TextFormField(
                    expands: true,
                    maxLines: null,
                    validator: (text) {
                      feedbackContent = text;
                    },
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        border: InputBorder.none,
                        hintText: DemoLocalizations.of(context).writeYourFeedback,
                        hintStyle: TextStyle(color: Colors.grey)),
                    maxLength: 2000,
                  ),
                ),
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
                autovalidate: true,
                child: Theme(
                  data: ThemeData(platform: TargetPlatform.android),
                  child: TextFormField(
                    expands: true,
                    maxLines: null,
                    validator: (text) {
                      contactWay = text;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.contact_mail,
                          color: primaryColor,
                        ),
                        hintText: DemoLocalizations.of(context).writeYourContactInfo,
                        hintStyle: TextStyle(color: Colors.grey),),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showWrongDialog(BuildContext context, String description) {
    showDialog(context: context, builder: (ctx){
      return AlertDialog(
        content: Text(description),
      );
    });
  }

  Widget getSvg(String svgPath) {
    return SvgPicture.asset(
      svgPath,
      width: 50,
      height: 50,
    );
  }
}
