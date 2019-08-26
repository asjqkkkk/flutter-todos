class UploadTaskBean {

  /**
   * description : "任务创建成功"
   * uniqueId : "772565130@qq.com1566790167339"
   * status : 0
   */

  String description;
  String uniqueId;
  int status;

  static UploadTaskBean fromMap(Map<String, dynamic> map) {
    UploadTaskBean upload_task_bean = new UploadTaskBean();
    upload_task_bean.description = map['description'];
    upload_task_bean.uniqueId = map['uniqueId'];
    upload_task_bean.status = map['status'];
    return upload_task_bean;
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
