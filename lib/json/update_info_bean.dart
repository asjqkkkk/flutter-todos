class UpdateInfoBean {

  /**
   * appVersion : "1.0.0"
   * appName : "无"
   * updateInfo : "无"
   * downloadUrl : "无"
   * appId : "001"
   */

  String appVersion;
  String appName;
  String updateInfo;
  String downloadUrl;
  String appId;

  static UpdateInfoBean fromMap(Map<String, dynamic> map) {
    UpdateInfoBean update_info_bean = new UpdateInfoBean();
    update_info_bean.appVersion = map['appVersion'];
    update_info_bean.appName = map['appName'];
    update_info_bean.updateInfo = map['updateInfo'];
    update_info_bean.downloadUrl = map['downloadUrl'];
    update_info_bean.appId = map['appId'];
    return update_info_bean;
  }

  static List<UpdateInfoBean> fromMapList(dynamic mapList) {
    List<UpdateInfoBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

  static  bool needUpdate(String oldVersion, String newVersion){
    final oldList = oldVersion.split(".");
    final newList = newVersion.split(".");

    bool needUpdate = false;

    for (var i = 0; i < oldList.length; i++) {
      String oldNumString = oldList[i];
      String newNumString = newList[i];
      int oldNum = int.parse(oldNumString);
      int newNum = int.parse(newNumString);
      if(newNum > oldNum){
        needUpdate = true;
        return needUpdate;
      }
    }
    return needUpdate;

  }

}
