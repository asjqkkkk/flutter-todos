class PhotoBean {

  /*
   * id : "aH8tRjQG4XM"
   * created_at : "2019-07-18T06:20:04-04:00"
   * updated_at : "2019-07-18T06:55:09-04:00"
   * color : "#C68E7A"
   * sponsored : false
   * liked_by_user : false
   * width : 2254
   * height : 2817
   * likes : 35
   * links : {"self":"https://api.unsplash.com/photos/aH8tRjQG4XM","html":"https://unsplash.com/photos/aH8tRjQG4XM","download":"https://unsplash.com/photos/aH8tRjQG4XM/download","download_location":"https://api.unsplash.com/photos/aH8tRjQG4XM/download"}
   * urls : {"raw":"https://images.unsplash.com/photo-1563445192071-fb5b2fa4ad62?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjgxNjY3fQ","full":"https://images.unsplash.com/photo-1563445192071-fb5b2fa4ad62?ixlib=rb-1.2.1&q=85&fm=jpg&crop=entropy&cs=srgb&ixid=eyJhcHBfaWQiOjgxNjY3fQ","regular":"https://images.unsplash.com/photo-1563445192071-fb5b2fa4ad62?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjgxNjY3fQ","small":"https://images.unsplash.com/photo-1563445192071-fb5b2fa4ad62?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=400&fit=max&ixid=eyJhcHBfaWQiOjgxNjY3fQ","thumb":"https://images.unsplash.com/photo-1563445192071-fb5b2fa4ad62?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=200&fit=max&ixid=eyJhcHBfaWQiOjgxNjY3fQ"}
   * user : {"id":"hHQGJB9ZejE","updated_at":"2019-07-18T07:57:50-04:00","username":"rotaalternativa","name":"Rota Alternativa","first_name":"Rota","last_name":"Alternativa","twitter_username":null,"portfolio_url":"https://www.instagram.com/rotaalternativarv/","bio":"We are exploring the nomad and simple life the road has to offer. Living in our 1992 Fiat Talento motorhome.","location":null,"links":{"self":"https://api.unsplash.com/users/rotaalternativa","html":"https://unsplash.com/@rotaalternativa","photos":"https://api.unsplash.com/users/rotaalternativa/photos","likes":"https://api.unsplash.com/users/rotaalternativa/likes","portfolio":"https://api.unsplash.com/users/rotaalternativa/portfolio","following":"https://api.unsplash.com/users/rotaalternativa/following","followers":"https://api.unsplash.com/users/rotaalternativa/followers"},"profile_image":{"small":"https://images.unsplash.com/profile-1550700203074-81551f41d6fe?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=32&w=32","medium":"https://images.unsplash.com/profile-1550700203074-81551f41d6fe?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=64&w=64","large":"https://images.unsplash.com/profile-1550700203074-81551f41d6fe?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=128&w=128"},"instagram_username":"rotaalternativarv","total_collections":0,"total_likes":1,"total_photos":72,"accepted_tos":true}
   */

  String id;
  String createdAt;
  String updatedAt;
  String color;
  bool sponsored;
  bool likedByUser;
  int width;
  int height;
  int likes;
  LinksBean links;
  UrlsBean urls;
  UserBean user;

  static PhotoBean fromMap(Map<String, dynamic> map) {
    PhotoBean photoBean = new PhotoBean();
    photoBean.id = map['id'];
    photoBean.createdAt = map['created_at'];
    photoBean.updatedAt = map['updated_at'];
    photoBean.color = map['color'];
    photoBean.sponsored = map['sponsored'];
    photoBean.likedByUser = map['liked_by_user'];
    photoBean.width = map['width'];
    photoBean.height = map['height'];
    photoBean.likes = map['likes'];
    photoBean.links = LinksBean.fromMap(map['links']);
    photoBean.urls = UrlsBean.fromMap(map['urls']);
    photoBean.user = UserBean.fromMap(map['user']);
    return photoBean;
  }

  static List<PhotoBean> fromMapList(dynamic mapList) {
    List<PhotoBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

}

class LinksBean {

  /*
   * self : "https://api.unsplash.com/users/rotaalternativa"
   * html : "https://unsplash.com/@rotaalternativa"
   * photos : "https://api.unsplash.com/users/rotaalternativa/photos"
   * likes : "https://api.unsplash.com/users/rotaalternativa/likes"
   * portfolio : "https://api.unsplash.com/users/rotaalternativa/portfolio"
   * following : "https://api.unsplash.com/users/rotaalternativa/following"
   * followers : "https://api.unsplash.com/users/rotaalternativa/followers"
   */

  String self;
  String html;
  String photos;
  String likes;
  String portfolio;
  String following;
  String followers;

  static LinksBean fromMap(Map<String, dynamic> map) {
    LinksBean linksBean = new LinksBean();
    linksBean.self = map['self'];
    linksBean.html = map['html'];
    linksBean.photos = map['photos'];
    linksBean.likes = map['likes'];
    linksBean.portfolio = map['portfolio'];
    linksBean.following = map['following'];
    linksBean.followers = map['followers'];
    return linksBean;
  }

  static List<LinksBean> fromMapList(dynamic mapList) {
    List<LinksBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class UrlsBean {

  /*
   * raw : "https://images.unsplash.com/photo-1563445192071-fb5b2fa4ad62?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjgxNjY3fQ"
   * full : "https://images.unsplash.com/photo-1563445192071-fb5b2fa4ad62?ixlib=rb-1.2.1&q=85&fm=jpg&crop=entropy&cs=srgb&ixid=eyJhcHBfaWQiOjgxNjY3fQ"
   * regular : "https://images.unsplash.com/photo-1563445192071-fb5b2fa4ad62?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjgxNjY3fQ"
   * small : "https://images.unsplash.com/photo-1563445192071-fb5b2fa4ad62?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=400&fit=max&ixid=eyJhcHBfaWQiOjgxNjY3fQ"
   * thumb : "https://images.unsplash.com/photo-1563445192071-fb5b2fa4ad62?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=200&fit=max&ixid=eyJhcHBfaWQiOjgxNjY3fQ"
   */

  String raw;
  String full;
  String regular;
  String small;
  String thumb;

  static UrlsBean fromMap(Map<String, dynamic> map) {
    UrlsBean urlsBean = new UrlsBean();
    urlsBean.raw = map['raw'];
    urlsBean.full = map['full'];
    urlsBean.regular = map['regular'];
    urlsBean.small = map['small'];
    urlsBean.thumb = map['thumb'];
    return urlsBean;
  }

  static List<UrlsBean> fromMapList(dynamic mapList) {
    List<UrlsBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class UserBean {

  /*
   * id : "hHQGJB9ZejE"
   * updated_at : "2019-07-18T07:57:50-04:00"
   * username : "rotaalternativa"
   * name : "Rota Alternativa"
   * first_name : "Rota"
   * last_name : "Alternativa"
   * portfolio_url : "https://www.instagram.com/rotaalternativarv/"
   * bio : "We are exploring the nomad and simple life the road has to offer. Living in our 1992 Fiat Talento motorhome."
   * instagram_username : "rotaalternativarv"
   * accepted_tos : true
   * total_collections : 0
   * total_likes : 1
   * total_photos : 72
   * links : {"self":"https://api.unsplash.com/users/rotaalternativa","html":"https://unsplash.com/@rotaalternativa","photos":"https://api.unsplash.com/users/rotaalternativa/photos","likes":"https://api.unsplash.com/users/rotaalternativa/likes","portfolio":"https://api.unsplash.com/users/rotaalternativa/portfolio","following":"https://api.unsplash.com/users/rotaalternativa/following","followers":"https://api.unsplash.com/users/rotaalternativa/followers"}
   * profile_image : {"small":"https://images.unsplash.com/profile-1550700203074-81551f41d6fe?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=32&w=32","medium":"https://images.unsplash.com/profile-1550700203074-81551f41d6fe?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=64&w=64","large":"https://images.unsplash.com/profile-1550700203074-81551f41d6fe?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=128&w=128"}
   */

  String id;
  String updatedAt;
  String username;
  String name;
  String firstName;
  String lastName;
  String portfolioUrl;
  String bio;
  String instagramUsername;
  bool acceptedTos;
  int totalCollections;
  int totalLikes;
  int totalPhotos;
  LinksBean links;
  ProfileImageBean profileImage;

  static UserBean fromMap(Map<String, dynamic> map) {
    UserBean userBean = new UserBean();
    userBean.id = map['id'];
    userBean.updatedAt = map['updated_at'];
    userBean.username = map['username'];
    userBean.name = map['name'];
    userBean.firstName = map['first_name'];
    userBean.lastName = map['last_name'];
    userBean.portfolioUrl = map['portfolio_url'];
    userBean.bio = map['bio'];
    userBean.instagramUsername = map['instagram_username'];
    userBean.acceptedTos = map['accepted_tos'];
    userBean.totalCollections = map['total_collections'];
    userBean.totalLikes = map['total_likes'];
    userBean.totalPhotos = map['total_photos'];
    userBean.links = LinksBean.fromMap(map['links']);
    userBean.profileImage = ProfileImageBean.fromMap(map['profile_image']);
    return userBean;
  }

  static List<UserBean> fromMapList(dynamic mapList) {
    List<UserBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class ProfileImageBean {

  /*
   * small : "https://images.unsplash.com/profile-1550700203074-81551f41d6fe?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=32&w=32"
   * medium : "https://images.unsplash.com/profile-1550700203074-81551f41d6fe?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=64&w=64"
   * large : "https://images.unsplash.com/profile-1550700203074-81551f41d6fe?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=128&w=128"
   */

  String small;
  String medium;
  String large;

  static ProfileImageBean fromMap(Map<String, dynamic> map) {
    ProfileImageBean profileImageBean = new ProfileImageBean();
    profileImageBean.small = map['small'];
    profileImageBean.medium = map['medium'];
    profileImageBean.large = map['large'];
    return profileImageBean;
  }

  static List<ProfileImageBean> fromMapList(dynamic mapList) {
    List<ProfileImageBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}
