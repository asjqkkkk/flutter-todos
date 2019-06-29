import 'package:shared_preferences/shared_preferences.dart';
export 'keys.dart';
import 'keys.dart';

class SharedUtil{

  factory SharedUtil() => _getInstance();

  static SharedUtil get instance => _getInstance();
  static SharedUtil _instance;


  SharedUtil._internal() {
    //初始化
  }

  static SharedUtil _getInstance() {
    if (_instance == null) {
      _instance = new SharedUtil._internal();
    }
    return _instance;
  }


  Future saveString (String key, String value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future saveInt (String key, int value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
  }

  Future saveDouble (String key, double value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(key, value);
  }

  Future saveBoolean (String key, bool value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  Future saveStringList (String key, List<String> list) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(key, list);
  }





  //-----------------------------------------------------get----------------------------------------------------


  Future<String> getString (String key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<int> getInt (String key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  Future<double> getDouble (String key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(key);
  }

  Future<bool> getBoolean (String key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key)??false;
  }

  Future<List<String>> getStringList(String key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key);
  }


}