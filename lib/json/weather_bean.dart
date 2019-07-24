class WeatherBean {


  List<HeWeather6ListBean> HeWeather6;

  static WeatherBean fromMap(Map<String, dynamic> map) {
    WeatherBean weather_bean = new WeatherBean();
    weather_bean.HeWeather6 = HeWeather6ListBean.fromMapList(map['HeWeather6']);
    return weather_bean;
  }

  static List<WeatherBean> fromMapList(dynamic mapList) {
    List<WeatherBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

}

class HeWeather6ListBean {


  String status;
  BasicBean basic;
  NowBean now;
  UpdateBean update;

  static HeWeather6ListBean fromMap(Map<String, dynamic> map) {
    HeWeather6ListBean heWeather6ListBean = new HeWeather6ListBean();
    heWeather6ListBean.status = map['status'];
    heWeather6ListBean.basic = BasicBean.fromMap(map['basic']);
    heWeather6ListBean.now = NowBean.fromMap(map['now']);
    heWeather6ListBean.update = UpdateBean.fromMap(map['update']);
    return heWeather6ListBean;
  }

  static List<HeWeather6ListBean> fromMapList(dynamic mapList) {
    List<HeWeather6ListBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class BasicBean {


  String cid;
  String location;
  String parent_city;
  String admin_area;
  String cnty;
  String lat;
  String lon;
  String tz;

  static BasicBean fromMap(Map<String, dynamic> map) {
    BasicBean basicBean = new BasicBean();
    basicBean.cid = map['cid'];
    basicBean.location = map['location'];
    basicBean.parent_city = map['parent_city'];
    basicBean.admin_area = map['admin_area'];
    basicBean.cnty = map['cnty'];
    basicBean.lat = map['lat'];
    basicBean.lon = map['lon'];
    basicBean.tz = map['tz'];
    return basicBean;
  }

  static List<BasicBean> fromMapList(dynamic mapList) {
    List<BasicBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class NowBean {


  String cloud;
  String cond_code;
  String cond_txt;
  String fl;
  String hum;
  String pcpn;
  String pres;
  String tmp;
  String vis;
  String wind_deg;
  String wind_dir;
  String wind_sc;
  String wind_spd;

  static NowBean fromMap(Map<String, dynamic> map) {
    NowBean nowBean = new NowBean();
    nowBean.cloud = map['cloud'];
    nowBean.cond_code = map['cond_code'];
    nowBean.cond_txt = map['cond_txt'];
    nowBean.fl = map['fl'];
    nowBean.hum = map['hum'];
    nowBean.pcpn = map['pcpn'];
    nowBean.pres = map['pres'];
    nowBean.tmp = map['tmp'];
    nowBean.vis = map['vis'];
    nowBean.wind_deg = map['wind_deg'];
    nowBean.wind_dir = map['wind_dir'];
    nowBean.wind_sc = map['wind_sc'];
    nowBean.wind_spd = map['wind_spd'];
    return nowBean;
  }

  static List<NowBean> fromMapList(dynamic mapList) {
    List<NowBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class UpdateBean {

  /**
   * loc : "2019-03-04 09:55"
   * utc : "2019-03-04 01:55"
   */

  String loc;
  String utc;

  static UpdateBean fromMap(Map<String, dynamic> map) {
    UpdateBean updateBean = new UpdateBean();
    updateBean.loc = map['loc'];
    updateBean.utc = map['utc'];
    return updateBean;
  }

  static List<UpdateBean> fromMapList(dynamic mapList) {
    List<UpdateBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}
