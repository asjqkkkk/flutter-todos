import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/database/database.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/json/task_bean.dart';
import 'package:todo_list/model/main_page_model.dart';
import 'package:todo_list/widgets/animated_floating_button.dart';
import 'all_page.dart';

class MainPage extends StatelessWidget {
  Widget build(BuildContext context) {
    final model = Provider.of<MainPageModel>(context);
    model.setContext(context);

    return Scaffold(
      key: model.scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(DemoLocalizations.of(context).appName),
        leading: FlatButton(
          child: Image.asset("images/leading.png"),
          onPressed: () {
            model.scaffoldKey.currentState.openDrawer();
          },
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.search,
                size: 28,
                color: Colors.white,
              ),
              onPressed: () {
//                DBProvider.db.createTask(TaskBean.fromMapList(TaskBean.getMockData())[0]);
              DBProvider.db.getTasks();
              })
        ],
      ),
      drawer: Drawer(
        child: NavPage(),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AnimatedFloatingButton(),
      body: Container(
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
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: Container(
                margin: EdgeInsets.only(top: 8, left: 12),
                child: Text(
                  "${DemoLocalizations.of(context).taskItems(3)}",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40),
              child: CarouselSlider(
                items: model.logic.getCards(context),
                aspectRatio: 1,
                height: MediaQuery.of(context).size.width - 100,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                enlargeCenterPage: true,
                onPageChanged: (index) {},
                scrollDirection: Axis.horizontal,
              ),
            )
          ],
        ),
      ),
    );
  }
}
