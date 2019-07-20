class PhotoBean {

  /**
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
  String created_at;
  String updated_at;
  String color;
  bool sponsored;
  bool liked_by_user;
  int width;
  int height;
  int likes;
  LinksBean links;
  UrlsBean urls;
  UserBean user;

  static PhotoBean fromMap(Map<String, dynamic> map) {
    PhotoBean photo_bean = new PhotoBean();
    photo_bean.id = map['id'];
    photo_bean.created_at = map['created_at'];
    photo_bean.updated_at = map['updated_at'];
    photo_bean.color = map['color'];
    photo_bean.sponsored = map['sponsored'];
    photo_bean.liked_by_user = map['liked_by_user'];
    photo_bean.width = map['width'];
    photo_bean.height = map['height'];
    photo_bean.likes = map['likes'];
    photo_bean.links = LinksBean.fromMap(map['links']);
    photo_bean.urls = UrlsBean.fromMap(map['urls']);
    photo_bean.user = UserBean.fromMap(map['user']);
    return photo_bean;
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

  /**
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

  /**
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

  /**
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
  String updated_at;
  String username;
  String name;
  String first_name;
  String last_name;
  String portfolio_url;
  String bio;
  String instagram_username;
  bool accepted_tos;
  int total_collections;
  int total_likes;
  int total_photos;
  LinksBean links;
  Profile_imageBean profile_image;

  static UserBean fromMap(Map<String, dynamic> map) {
    UserBean userBean = new UserBean();
    userBean.id = map['id'];
    userBean.updated_at = map['updated_at'];
    userBean.username = map['username'];
    userBean.name = map['name'];
    userBean.first_name = map['first_name'];
    userBean.last_name = map['last_name'];
    userBean.portfolio_url = map['portfolio_url'];
    userBean.bio = map['bio'];
    userBean.instagram_username = map['instagram_username'];
    userBean.accepted_tos = map['accepted_tos'];
    userBean.total_collections = map['total_collections'];
    userBean.total_likes = map['total_likes'];
    userBean.total_photos = map['total_photos'];
    userBean.links = LinksBean.fromMap(map['links']);
    userBean.profile_image = Profile_imageBean.fromMap(map['profile_image']);
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

class Profile_imageBean {

  /**
   * small : "https://images.unsplash.com/profile-1550700203074-81551f41d6fe?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=32&w=32"
   * medium : "https://images.unsplash.com/profile-1550700203074-81551f41d6fe?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=64&w=64"
   * large : "https://images.unsplash.com/profile-1550700203074-81551f41d6fe?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=128&w=128"
   */

  String small;
  String medium;
  String large;

  static Profile_imageBean fromMap(Map<String, dynamic> map) {
    Profile_imageBean profile_imageBean = new Profile_imageBean();
    profile_imageBean.small = map['small'];
    profile_imageBean.medium = map['medium'];
    profile_imageBean.large = map['large'];
    return profile_imageBean;
  }

  static List<Profile_imageBean> fromMapList(dynamic mapList) {
    List<Profile_imageBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}
