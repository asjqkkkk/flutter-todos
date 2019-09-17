import 'package:flutter/material.dart';
import 'package:todo_list/config/api_service.dart';
import 'package:todo_list/json/theme_bean.dart';
import 'package:todo_list/json/weather_bean.dart';
import 'package:todo_list/model/all_model.dart';
import 'package:todo_list/utils/shared_util.dart';
import 'package:todo_list/utils/theme_util.dart';
import 'dart:convert';

import 'package:todo_list/widgets/net_loading_widget.dart';

class GlobalLogic{

  final GlobalModel _model;

  GlobalLogic(this._model);


  //当为夜间模式时候，白色替换为灰色
  Color getWhiteInDark(){
    final themeType = _model.currentThemeBean.themeType;
    return themeType == MyTheme.darkTheme ? Colors.grey : Colors.white;
  }

  //当为夜间模式时候，白色背景替换为特定灰色
  Color getBgInDark(){
    final themeType = _model.currentThemeBean.themeType;
    return themeType == MyTheme.darkTheme ? Colors.grey[800] : Colors.white;
  }

  //当为夜间模式时候，主题色背景替换为灰色
  Color getPrimaryGreyInDark(BuildContext context){
    final themeType = _model.currentThemeBean.themeType;
    return themeType == MyTheme.darkTheme ? Colors.grey : Theme.of(context).primaryColor;
  }

  //当为夜间模式时候，主题色背景替换为特定灰色
  Color getPrimaryInDark(BuildContext context){
    final themeType = _model.currentThemeBean.themeType;
    return themeType == MyTheme.darkTheme ? Colors.grey[800] : Theme.of(context).primaryColor;
  }

  //当为夜间模式时候，黑色替换为白色
  Color getbwInDark(){
    final themeType = _model.currentThemeBean.themeType;
    return themeType == MyTheme.darkTheme ? Colors.white : Colors.black;
  }

  ///获取当前的语言code
  Future getCurrentLanguageCode() async{
    final list = await SharedUtil.instance.getStringList(Keys.currentLanguageCode);
    if (list == null) return;
    if (list == _model.currentLanguageCode) return;
    _model.currentLanguageCode = list;
  }

  ///获取当前的语言
  Future getCurrentLanguage() async{
    final currentLanguage = await SharedUtil.instance.getString(Keys.currentLanguage);
    if (currentLanguage == null) return;
    if (currentLanguage == _model.currentLanguage) return;
    _model.currentLanguage = currentLanguage;
  }

  ///获取当前的主题数据
  Future getCurrentTheme() async{
    final theme = await SharedUtil.instance.getString(Keys.currentThemeBean);
    if(theme == null) return;
    ThemeBean themeBean = ThemeBean.fromMap(jsonDecode(theme));
    if(themeBean.themeType == _model.currentThemeBean.themeType) return;
    _model.currentThemeBean = themeBean;
  }

  ///获取app的名字
  Future getAppName() async{
    final appName = await SharedUtil.instance.getString(Keys.appName);
    if(appName == null) return;
    if(appName == _model.appName) return;
    _model.appName = appName;
  }


  ///是否开启背景渐变
  Future getIsBgGradient()async{
    final isBgGradient = await SharedUtil.instance.getBoolean(Keys.backgroundGradient);
    if(isBgGradient == null) return;
    if(isBgGradient == _model.isBgGradient) return;
    _model.isBgGradient = isBgGradient;
  }

  ///获取导航栏的类型
  Future getCurrentNavHeader()async{
    final currentNavHeader = await SharedUtil.instance.getString(Keys.currentNavHeader);
    if(currentNavHeader == null) return;
    if(currentNavHeader == _model.currentNavHeader) return;
    _model.currentNavHeader = currentNavHeader;
  }

  ///获取当前导航栏头部选择网络图片时的图片地址
  Future getCurrentNetPicUrl()async{
    final currentNetPicUrl = await SharedUtil.instance.getString(Keys.currentNetPicUrl);
    if(currentNetPicUrl == null) return;
    if(currentNetPicUrl == _model.currentNavHeader) return;
    _model.currentNetPicUrl = currentNetPicUrl;
  }

  ///是否开启主页背景跟随任务卡片颜色
  Future getIsBgChangeWithCard() async {
    final isBgChangeWithCard = await SharedUtil.instance.getBoolean(Keys.backgroundChangeWithCard);
    _model.isBgChangeWithCard = isBgChangeWithCard;
  }

  ///是否开启任务卡片颜色跟随背景
  Future getIsCardChangeWithBg() async {
    final isCardChangeWithBg = await SharedUtil.instance.getBoolean(Keys.cardChangeWithBackground);
    _model.isCardChangeWithBg = isCardChangeWithBg;
  }

  ///是否开启主页的卡片左右无限循环
  Future getEnableInfiniteScroll() async{
    final enableInfiniteScroll = await SharedUtil.instance.getBoolean(Keys.enableInfiniteScroll);
    _model.enableInfiniteScroll = enableInfiniteScroll;
  }

  ///获取当前的位置,拿到天气
  Future getCurrentPosition() async{
    final currentPosition = await SharedUtil.instance.getString(Keys.currentPosition);
    if(currentPosition == null) return;
    if(currentPosition == _model.currentPosition) return;
    _model.currentPosition = currentPosition;
  }

  ///是否开启天气
  Future getEnableWeatherShow() async{
    final enableWeatherShow = await SharedUtil.instance.getBoolean(Keys.enableWeatherShow);
    _model.enableWeatherShow = enableWeatherShow;
  }

  ///用于判断是否进入登录页面
  Future getLoginState() async{
    final hasLogged = await SharedUtil.instance.getBoolean(Keys.hasLogged);
    _model.goToLogin = !hasLogged;
  }

  ///是否开启主页背景为网络图片
  Future getEnableNetPicBgInMainPage() async{
    final enableNetPicBgInMainPage = await SharedUtil.instance.getBoolean(Keys.enableNetPicBgInMainPage);
    _model.enableNetPicBgInMainPage = enableNetPicBgInMainPage;
  }

  ///获取当前主页背景图片的url
  Future getCurrentMainPageBgUrl() async{
    final currentMainPageBgUrl = await SharedUtil.instance.getString(Keys.currentMainPageBackgroundUrl);
    if(currentMainPageBgUrl == null) return;
    if(currentMainPageBgUrl == _model.currentMainPageBgUrl) return;
    _model.currentMainPageBgUrl = currentMainPageBgUrl;
  }

  void getWeatherNow(String position,{BuildContext context, LoadingController controller}){
    ApiService.instance.getWeatherNow(success : (WeatherBean weatherBean){
      _model.weatherBean = weatherBean;
      _model.enableWeatherShow = true;
      SharedUtil.instance.saveString(Keys.currentPosition, position);
      SharedUtil.instance.saveBoolean(Keys.enableWeatherShow, true);
      _model.refresh();
      controller?.setFlag(LoadingFlag.success);

    },failed : (WeatherBean weatherBean){
      controller?.setFlag(LoadingFlag.error);
    }, error : (error){
      controller?.setFlag(LoadingFlag.error);

    }, params : {
      "key": "d381a4276ed349daa3bf63646f12d8ae",
      "location": position,
      "lang":_model.currentLocale.languageCode
    }, token: CancelToken());
  }

  bool isDarkNow(){
    return _model.currentThemeBean.themeType == MyTheme.darkTheme;
  }

}