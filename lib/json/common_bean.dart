class CommonBean {

  String description;
  int status;

  static CommonBean fromMap(Map<String, dynamic> map) {
    CommonBean common_bean = new CommonBean();
    common_bean.description = map['description'];
    common_bean.status = map['status'];
    return common_bean;
  }

  static List<CommonBean> fromMapList(dynamic mapList) {
    List<CommonBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

}
