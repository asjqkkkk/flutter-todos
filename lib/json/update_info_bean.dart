class UpdateInfoBean {

  /*
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
    UpdateInfoBean updateInfoBean = new UpdateInfoBean();
    updateInfoBean.appVersion = map['appVersion'];
    updateInfoBean.appName = map['appName'];
    updateInfoBean.updateInfo = map['updateInfo'];
    updateInfoBean.downloadUrl = map['downloadUrl'];
    updateInfoBean.appId = map['appId'];
    return updateInfoBean;
  }

  static List<UpdateInfoBean> fromMapList(dynamic mapList) {
    List<UpdateInfoBean> list = List.filled(mapList.length, null);
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
      } else if(oldNum > newNum){
        return false;
      }
    }
    return needUpdate;

  }

}
