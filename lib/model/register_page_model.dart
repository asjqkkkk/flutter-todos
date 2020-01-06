import 'package:flutter/material.dart';
import 'package:todo_list/config/api_service.dart';
import 'package:todo_list/logic/all_logic.dart';

class RegisterPageModel extends ChangeNotifier{

  RegisterPageLogic logic;
  BuildContext context;

  String userName = "";
  String email = "";
  String password = "";
  String rePassword = "";
  String verifyCode = "";

  bool isUserNameOk = false;
  bool isVerifyCodeOk = false;
  bool isEmailOk = false;
  bool isPasswordOk = false;
  bool isRePasswordOk = false;


  CancelToken cancelToken = CancelToken();

  final emailKey = GlobalKey<FormState>();
  final userNameKey = GlobalKey<FormState>();
  final passwordKey = GlobalKey<FormState>();
  final rePasswordKey = GlobalKey<FormState>();
  final verifyCodeKey = GlobalKey<FormState>();

  final emailFocusNode = FocusNode();
  final userNameFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final rePasswordFocusNode = FocusNode();
  final verifyCodeFocusNode = FocusNode();



  RegisterPageModel(){
    logic = RegisterPageLogic(this);
  }

  void setContext(BuildContext context){
    if(this.context == null){
        this.context = context;
    }
  }

  @override
  void dispose(){
    cancelToken?.cancel();
//    formKey?.currentState?.dispose();
    disposeNode();
    super.dispose();
    debugPrint("RegisterPageModel销毁了");
  }

  void disposeNode(){
    emailFocusNode.dispose();
    userNameFocusNode.dispose();
    passwordFocusNode.dispose();
    rePasswordFocusNode.dispose();
    verifyCodeFocusNode.dispose();
  }

  void refresh(){
    notifyListeners();
  }
}