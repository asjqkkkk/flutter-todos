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
  final formKey = GlobalKey<FormState>();



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
    formKey?.currentState?.dispose();
    super.dispose();
    debugPrint("RegisterPageModel销毁了");
  }

  void refresh(){
    notifyListeners();
  }
}