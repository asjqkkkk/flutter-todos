import 'package:flutter/material.dart';
import 'package:todo_list/config/api_service.dart';
import 'package:todo_list/logic/all_logic.dart';
import 'package:todo_list/widgets/net_loading_widget.dart';

class ResetPasswordPageModel extends ChangeNotifier {
  ResetPasswordPageLogic logic;
  BuildContext context;

  ///true表示重新设置密码，false表示忘记密码
  ///前者需要用到[oldPassword],后者需要用到[verifyCode]
  bool isReset;

  String emailAccount = "";
  String newPassword = "";
  String oldPassword = "";
  String rePassword = "";
  String verifyCode = "";


  bool isVerifyCodeOk = false;
  bool isEmailOk = false;
  bool isNewPasswordOk = false;
  bool isRePasswordOk = false;
  bool isOldPasswordOk = false;

  CancelToken cancelToken = CancelToken();
  LoadingController loadingController = LoadingController();
  final formKey = GlobalKey<FormState>();


  ResetPasswordPageModel(bool isReset) {
    logic = ResetPasswordPageLogic(this);
    this.isReset = isReset;
  }

  void setContext(BuildContext context) {
    if (this.context == null) {
      this.context = context;
    }
  }

  @override
  void dispose() {
    cancelToken?.cancel();
    formKey?.currentState?.dispose();
    super.dispose();
    debugPrint("ResetPasswordPageModel销毁了");
  }

  void refresh() {
    notifyListeners();
  }
}
