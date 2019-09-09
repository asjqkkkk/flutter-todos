class UploadTaskBean {

  /*
   * description : "任务创建成功"
   * uniqueId : "772565130@qq.com1566790167339"
   * status : 0
   */

  String description;
  String uniqueId;
  int status;

  static UploadTaskBean fromMap(Map<String, dynamic> map) {
    UploadTaskBean uploadTaskBean = new UploadTaskBean();
    uploadTaskBean.description = map['description'];
    uploadTaskBean.uniqueId = map['uniqueId'];
    uploadTaskBean.status = map['status'];
    return uploadTaskBean;
  }

  static List<UploadTaskBean> fromMapList(dynamic mapList) {
    List<UploadTaskBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

  @override
  String toString() {
    return 'UploadTaskBean{description: $description, uniqueId: $uniqueId, status: $status}';
  }


}
