import 'package:flutter/material.dart';
import 'package:todo_list/config/api_service.dart';
import 'package:todo_list/logic/all_logic.dart';

class LoginPageModel extends ChangeNotifier{

  LoginPageLogic logic;
  BuildContext context;


  String currentAnimation = "move";
  bool showLoginWidget = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isEmailOk = false;
  bool isPasswordOk = false;
  bool isLoginNow = false;

  ///表示登录页面是不是第一个页面
  bool isFirst;

  final formKey = GlobalKey<FormState>();

  CancelToken cancelToken = CancelToken();

  LoginPageModel({bool isFirst = false}){
    logic = LoginPageLogic(this);
    this.isFirst = isFirst;
  }

  void setContext(BuildContext context){
    if(this.context == null){
        this.context = context;
    }
  }

  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    cancelToken?.cancel();
    formKey?.currentState?.dispose();
    super.dispose();
    debugPrint("LoginPageModel销毁了");
  }

  void refresh(){
    notifyListeners();
  }
}