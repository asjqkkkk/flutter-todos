import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/database/database.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/json/task_bean.dart';
import 'package:todo_list/model/global_model.dart';
import 'package:todo_list/model/main_page_model.dart';
import 'package:todo_list/widgets/animated_floating_button.dart';
import 'package:todo_list/widgets/menu_icon.dart';
import 'all_page.dart';

class MainPage extends StatelessWidget {
  Widget build(BuildContext context) {
    final model = Provider.of<MainPageModel>(context);
    final globalModel = Provider.of<GlobalModel>(context);
    model.setContext(context);
    globalModel.setMainPageModel(model);
    return Container(
      decoration: model.logic.getBackground(globalModel),
      child: Scaffold(
        key: model.scaffoldKey,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(DemoLocalizations.of(context).appName),
          leading: FlatButton(
            child: MenuIcon(globalModel.logic.getWhiteInDark()),
            onPressed: () {
              model.scaffoldKey.currentState.openDrawer();
            },
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.search,
                  size: 28,
                  color: globalModel.logic.getWhiteInDark(),
                ),
                onPressed: () => model.logic.queryTask("打"),)
          ],
        ),
        drawer: Drawer(
          child: NavPage(),
        ),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: AnimatedFloatingButton(
          bgColor: globalModel.isBgChangeWithCard ? model.logic.getCurrentCardColor() : null,
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(62, 8, 50, 0),
                  width: 60,
                  height: 60,
                  child: ClipRRect(
                    child: Image.asset("images/avator.jpg"),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: Container(
                    margin: EdgeInsets.only(top: 40, left: 12),
                    child: Text(
                      "${DemoLocalizations.of(context).welcomeWord}Old Li.",
                      style: TextStyle(
                          fontSize: 30,
                          color: globalModel.logic.getWhiteInDark()),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: Container(
                    margin: EdgeInsets.only(top: 8, left: 12),
                    child: Text(
                      "${DemoLocalizations.of(context).taskItems(model.tasks.length)}",
                      style: TextStyle(
                          fontSize: 15,
                          color: globalModel.logic.getWhiteInDark()),
                    ),
                  ),
                ),
                model.tasks.length == 0 ? model.logic.getEmptyWidget() : Container(
                  margin: EdgeInsets.only(top: 40),
                  child: CarouselSlider(
                    items: model.logic.getCards(context),
                    aspectRatio: 1,
                    height: MediaQuery.of(context).size.width - 100,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: model.tasks.length >= 3 && globalModel.enableInfiniteScroll,
                    reverse: false,
                    enlargeCenterPage: true,
                    onPageChanged: (index) {
                      model.currentCardIndex = index;
                      if(globalModel.isBgChangeWithCard) model.refresh();
                    },
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
