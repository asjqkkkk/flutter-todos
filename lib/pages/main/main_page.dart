import 'dart:math';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/model/global_model.dart';
import 'package:todo_list/model/main_page_model.dart';
import 'package:todo_list/pages/navigator/nav_page.dart';
import 'package:todo_list/widgets/animated_floating_button.dart';
import 'package:todo_list/widgets/menu_icon.dart';
import 'package:todo_list/widgets/synchronize_widget.dart';

class MainPage extends StatelessWidget {
  Widget build(BuildContext context) {
    final model = Provider.of<MainPageModel>(context);
    final globalModel = Provider.of<GlobalModel>(context);
    final size = MediaQuery.of(context).size;
    model.setContext(context,globalModel: globalModel);
    globalModel.setMainPageModel(model);
    return GestureDetector(
      onTap:  () => model.logic.onBackGroundTap(globalModel),
      child: Container(
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
                onPressed: () => model.logic.onSearchTap(),
              )
            ],
          ),
          drawer: Drawer(
            child: NavPage(),
          ),
          floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: AnimatedFloatingButton(
            bgColor: globalModel.isBgChangeWithCard
                ? model.logic.getCurrentCardColor()
                : null,
          ),
          body: Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(62, 8, 50, 0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                              onTap: model.logic.onAvatarTap,
                              child: Hero(
                                tag: 'avatar',
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  child: ClipRRect(
                                    child: model.logic.getAvatarWidget(),
                                    borderRadius: BorderRadius.all(Radius.circular(30)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: model.needSyn ? SynchronizeWidget(mainPageModel: model,) : Container(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
                    child: Container(
                      margin: EdgeInsets.only(top: 20, left: 12),
                      child: SingleChildScrollView(
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              child: InkWell(
                                onTap: model.currentUserName.isEmpty ? null : model.logic.onUserNameTap,
                                child: Text(
                                  "${DemoLocalizations.of(context).welcomeWord}${model.currentUserName}",
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: globalModel.logic.getWhiteInDark()),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            model.currentUserName.isEmpty
                                ? IconButton(
                                    icon: Icon(Icons.account_circle, color: globalModel.logic.getWhiteInDark(),),
                                    onPressed: model.logic.onUserNameTap,
                                  )
                                : SizedBox()
                          ],
                        ),
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
                  model.tasks.length == 0
                      ? model.logic.getEmptyWidget(globalModel)
                      : Container(
                          margin: EdgeInsets.only(top: 40, bottom: 40),
                          child: CarouselSlider(
                            items: model.logic.getCards(context),
                            aspectRatio: 16 / 9,
                            height: min(size.width, size.height) - 100,
                            viewportFraction:
                                size.height >= size.width ? 0.8 : 0.5,
                            initialPage: 0,
                            enableInfiniteScroll: model.tasks.length >= 3 &&
                                globalModel.enableInfiniteScroll,
                            reverse: false,
                            enlargeCenterPage: true,
                            onPageChanged: (index) {
                              model.currentCardIndex = index;
                              if (globalModel.isBgChangeWithCard) model.refresh();
                            },
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
