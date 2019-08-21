

class LoginBean{


  String description;
  int status;
  String token;
  String username;
  String avatarUrl;

  static LoginBean fromMap(Map<String, dynamic> map) {
    LoginBean login_bean = new LoginBean();
    login_bean.description = map['description'];
    login_bean.status = map['status'];
    login_bean.token = map['token'];
    login_bean.username = map['username'];
    login_bean.avatarUrl = map['avatarUrl'];
    return login_bean;
  }

  static List<LoginBean> fromMapList(dynamic mapList) {
    List<LoginBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

}
