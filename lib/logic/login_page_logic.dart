import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/model/all_model.dart';

class LoginPageLogic{

  final LoginPageModel _model;

  LoginPageLogic(this._model);


  void onExit(){
    _model.currentAnimation = "move_out";
    _model.canShowBackdrop = false;
    _model.refresh();
  }



  String validatorEmail(String email) {
    final context = _model.context;
    _model.isEmailOk = false;
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (email.isEmpty)
      return DemoLocalizations.of(context).emailCantBeEmpty;
    else if (!regex.hasMatch(email))
      return DemoLocalizations.of(context).emailIncorrectFormat;
    else {
      _model.isEmailOk = true;
      return null;
    }
  }

  String validatePassword(String password) {
    final context = _model.context;
    _model.isPasswordOk = false;
    if (password.isEmpty) {
      return DemoLocalizations.of(context).passwordCantBeEmpty;
    } else if (password.length < 8) {
      return DemoLocalizations.of(context).passwordTooShort;
    } else if (password.length > 20) {
      return DemoLocalizations.of(context).passwordTooLong;
    } else {
      _model.isPasswordOk = true;
      return null;
    }
  }


  void onLogin(){

  }

  void onForget(){

  }

  void onRegister(){

  }

}