

class LoginBean{


  String description;
  int status;
  String token;
  String username;

  static LoginBean fromMap(Map<String, dynamic> map) {
    LoginBean login_bean = new LoginBean();
    login_bean.description = map['description'];
    login_bean.status = map['status'];
    login_bean.token = map['token'];
    login_bean.username = map['username'];
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
