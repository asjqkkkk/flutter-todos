import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/logic/all_logic.dart';
import 'package:todo_list/widgets/net_loading_widget.dart';

class FeedbackPageModel extends ChangeNotifier{

  FeedbackPageLogic logic;
  BuildContext context;
  final LoadingController loadingController = LoadingController();

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
  final CancelToken cancelToken = CancelToken();

  FeedbackPageModel(){
    logic = FeedbackPageLogic(this);
  }

  void setContext(BuildContext context){
    if(this.context == null){
        this.context = context;
    }
  }

  @override
  void dispose(){
    cancelToken?.cancel();
    super.dispose();
    debugPrint("FeedbackPageModel销毁了");
  }

  void refresh(){
    notifyListeners();
  }
}