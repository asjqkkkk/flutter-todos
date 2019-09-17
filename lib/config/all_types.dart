


///侧滑栏头部类型:天体流星、每日壁纸、网络图片
class NavHeadType{
  static const String meteorShower = "MeteorShower";
  static const String dailyPic = "DailyPic";
  static const String netPicture = "NetPicture";


  ///每日壁纸的图片地址
  static const String DAILY_PIC_URL =  "https://api.dujin.org/bing/1366.php";
}


///网络图片页面的图片用途
class NetPicturesUseType{
  ///用作"我的账号"页面的背景
  static const String accountBackground = "account_background";

  ///用作测滑栏的头部
  static const String navigatorHeader = NavHeadType.netPicture;

  ///用作主页的背景
  static const String mainPageBackground = "main_page_background";
}

///"我的账号"页面背景类型
class AccountBGType{
  static const String defaultType = "default_account_background_type";
  static const String netPicture = "net_account_picture_type";

}