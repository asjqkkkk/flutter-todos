class UploadAvatarBean {

  /**
   * description : "头像上传成功"
   * filePath : "files/772565130@qq.com/2019/7/avatar.jpg"
   * status : 0
   */

  String description;
  String filePath;
  int status;

  static UploadAvatarBean fromMap(Map<String, dynamic> map) {
    UploadAvatarBean upload_avatar_bean = new UploadAvatarBean();
    upload_avatar_bean.description = map['description'];
    upload_avatar_bean.filePath = map['filePath'];
    upload_avatar_bean.status = map['status'];
    return upload_avatar_bean;
  }

  static List<UploadAvatarBean> fromMapList(dynamic mapList) {
    List<UploadAvatarBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

}
