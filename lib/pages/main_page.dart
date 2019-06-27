import 'dart:math';

import 'package:circle_list/circle_list.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:todo_list/items/task_item.dart';
import 'package:todo_list/pages/show_demo_page.dart';
import 'package:todo_list/pages/task_detail_page.dart';
import 'package:todo_list/widgets/floating_border.dart';
import 'package:todo_list/widgets/show_widget.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool isFloatShow = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        title: Text("ToDo List"),
        leading: Image.asset("images/leading.png"),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.search,
                size: 28,
                color: Colors.white,
              ),
              onPressed: () {})
        ],
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(PageRouteBuilder(
              opaque: false,
              pageBuilder: (ctx,anm1,anm2){
                return Scaffold(
                  backgroundColor: Colors.black.withOpacity(0.2),
                  body: CircleList(
                    children: List.generate(10, (index) {
                      return Icon(
                        Icons.details,
                        color: index % 2 == 0 ? Colors.blue : Colors.orange,
                        size: 30,
                      );
                    }),
                    innerCircleColor: Colors.grey,
                    outerCircleColor: Colors.white,
                    centerWidget: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                          debugPrint("点击");
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 3,
                          height: MediaQuery.of(context).size.width / 3,
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            shape: BoxShape.circle,
                          ),
                          child: Container(
                            color: Colors.transparent,
                            margin: EdgeInsets.only(bottom: 40),
                            child: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        )),
                  ),
                );
              }
          )
          );
        },
        child: Icon(Icons.menu),
        backgroundColor: Theme.of(context).primaryColorDark,
        shape: FloatingBorder(),
      ),
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
                  "Hello, Old Li.",
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: Container(
                margin: EdgeInsets.only(top: 8, left: 12),
                child: Text(
                  "This is your todo-list,\nToday,You have 3 task to complete.",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40),
              child: CarouselSlider(
                items: _getCards(context),
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

  List<Widget> _getCards(context) {
    List<Widget> list = [];
    for (var i = 0; i < 10; i++) {
      list.add(GestureDetector(
        child: TaskItem(i),
        onTap: () {
          Navigator.of(context).push(new PageRouteBuilder(
              pageBuilder: (ctx, anm, anmS) {
                return TaskDetailPage(i);
              },
              transitionDuration: Duration(seconds: 1)));
        },
      ));
    }
    return list;
  }
}
