class RegisterBean{


  String description;
  String token;
  String avatarUrl;
  int status;

  static RegisterBean fromMap(Map<String, dynamic> map) {
    RegisterBean diary_base = new RegisterBean();
    diary_base.description = map['description'];
    diary_base.token = map['token'];
    diary_base.avatarUrl = map['avatarUrl'];
    diary_base.status = map['status'];
    return diary_base;
  }

  static List<RegisterBean> fromMapList(dynamic mapList) {
    List<RegisterBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

}


