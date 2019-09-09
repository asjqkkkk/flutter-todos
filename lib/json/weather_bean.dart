class WeatherBean {

  //{"HeWeather6":[{"basic":{"cid":"TR3487004","location":"Akrotiri","parent_city":"Akrotiri","admin_area":"亚克罗提利与德凯利亚","cnty":"英国","lat":"34.60100174","lon":"32.95600128","tz":"+3.00"},"update":{"loc":"2019-07-24 16:57","utc":"2019-07-24 13:57"},"status":"ok","now":{"cloud":"35","cond_code":"100","cond_txt":"晴","fl":"30","hum":"87","pcpn":"0.0","pres":"1005","tmp":"26","vis":"16","wind_deg":"271","wind_dir":"西风","wind_sc":"0","wind_spd":"1"}}]}

  //{"HeWeather6":[{"status":"unknown location"}]}错误时的

  List<HeWeather6ListBean> heWeather6;

  static WeatherBean fromMap(Map<String, dynamic> map) {
    WeatherBean weatherBean = new WeatherBean();
    weatherBean.heWeather6 = HeWeather6ListBean.fromMapList(map['HeWeather6']);
    return weatherBean;
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

  /*
   * status : "ok"
   * basic : {"cid":"TR3487004","location":"Akrotiri","parent_city":"Akrotiri","admin_area":"�ǿ���������¿�����","cnty":"Ӣ��","lat":"34.60100174","lon":"32.95600128","tz":"+3.00"}
   * now : {"cloud":"35","cond_code":"100","cond_txt":"��","fl":"30","hum":"87","pcpn":"0.0","pres":"1005","tmp":"26","vis":"16","wind_deg":"271","wind_dir":"����","wind_sc":"0","wind_spd":"1"}
   * update : {"loc":"2019-07-24 16:57","utc":"2019-07-24 13:57"}
   */

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

  /*
   * cid : "TR3487004"
   * location : "Akrotiri"
   * parent_city : "Akrotiri"
   * admin_area : "�ǿ���������¿�����"
   * cnty : "Ӣ��"
   * lat : "34.60100174"
   * lon : "32.95600128"
   * tz : "+3.00"
   */

  String cid;
  String location;
  String parentCity;
  String adminArea;
  String cnty;
  String lat;
  String lon;
  String tz;

  static BasicBean fromMap(Map<String, dynamic> map) {
    BasicBean basicBean = new BasicBean();
    basicBean.cid = map['cid'];
    basicBean.location = map['location'];
    basicBean.parentCity = map['parent_city'];
    basicBean.adminArea = map['admin_area'];
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

  /*
   * cloud : "35"
   * cond_code : "100"
   * cond_txt : "��"
   * fl : "30"
   * hum : "87"
   * pcpn : "0.0"
   * pres : "1005"
   * tmp : "26"
   * vis : "16"
   * wind_deg : "271"
   * wind_dir : "����"
   * wind_sc : "0"
   * wind_spd : "1"
   */

  String cloud;
  String condCode;
  String condTxt;
  String fl;
  String hum;
  String pcpn;
  String pres;
  String tmp;
  String vis;
  String windDeg;
  String windDir;
  String windSc;
  String windSpd;

  static NowBean fromMap(Map<String, dynamic> map) {
    NowBean nowBean = new NowBean();
    nowBean.cloud = map['cloud'];
    nowBean.condCode = map['cond_code'];
    nowBean.condTxt = map['cond_txt'];
    nowBean.fl = map['fl'];
    nowBean.hum = map['hum'];
    nowBean.pcpn = map['pcpn'];
    nowBean.pres = map['pres'];
    nowBean.tmp = map['tmp'];
    nowBean.vis = map['vis'];
    nowBean.windDeg = map['wind_deg'];
    nowBean.windDir = map['wind_dir'];
    nowBean.windSc = map['wind_sc'];
    nowBean.windSpd = map['wind_spd'];
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

  /*
   * loc : "2019-07-24 16:57"
   * utc : "2019-07-24 13:57"
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
