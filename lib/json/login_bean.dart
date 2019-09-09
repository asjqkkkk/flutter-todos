

class LoginBean{


  String description;
  int status;
  String token;
  String username;
  String avatarUrl;

  static LoginBean fromMap(Map<String, dynamic> map) {
    LoginBean loginBean = new LoginBean();
    loginBean.description = map['description'];
    loginBean.status = map['status'];
    loginBean.token = map['token'];
    loginBean.username = map['username'];
    loginBean.avatarUrl = map['avatarUrl'];
    return loginBean;
  }

  static List<LoginBean> fromMapList(dynamic mapList) {
    List<LoginBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

}
