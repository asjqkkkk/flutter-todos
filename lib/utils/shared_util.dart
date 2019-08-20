import 'package:shared_preferences/shared_preferences.dart';
export 'package:todo_list/config/keys.dart';
import 'package:todo_list/config/keys.dart';

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
    if(key == Keys.account){
      await prefs.setString(key, value);
      return;
    }
    String account = prefs.getString(Keys.account) ?? "default";
    await prefs.setString(key + account, value);
  }

  Future saveInt (String key, int value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String account = prefs.getString(Keys.account) ?? "default";
    await prefs.setInt(key + account, value);
  }

  Future saveDouble (String key, double value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String account = prefs.getString(Keys.account) ?? "default";
    await prefs.setDouble(key + account, value);
  }

  Future saveBoolean (String key, bool value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String account =  prefs.getString(Keys.account) ?? "default";
    await prefs.setBool(key + account, value);
  }

  Future saveStringList (String key, List<String> list) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String account =  prefs.getString(Keys.account) ?? "default";
    await prefs.setStringList(key + account, list);
  }


  Future<bool> readAndSaveList(String key, String data) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String account =  prefs.getString(Keys.account) ?? "default";
    List<String> strings = prefs.getStringList(key + account) ?? [];
    if(strings.length >= 10) return false;
    strings.add(data);
    await prefs.setStringList(key + account, strings);
    return true;
  }

  void readAndExchangeList(String key, String data, int index) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String account =  prefs.getString(Keys.account) ?? "default";
    List<String> strings = prefs.getStringList(key + account) ?? [];
    strings[index] = data;
    await prefs.setStringList(key + account, strings);
  }

  void readAndRemoveList(String key,int index) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String account =  prefs.getString(Keys.account) ?? "default";
    List<String> strings = prefs.getStringList(key + account) ?? [];
    strings.removeAt(index);
    await prefs.setStringList(key + account, strings);
  }


  //-----------------------------------------------------get----------------------------------------------------


  Future<String> getString (String key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(key == Keys.account){
      return prefs.getString(key);
    }
    String account =  prefs.getString(Keys.account) ?? "default";
    return prefs.getString(key + account);
  }

  Future<int> getInt (String key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String account =  prefs.getString(Keys.account) ?? "default";
    return prefs.getInt(key + account);
  }

  Future<double> getDouble (String key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String account =  prefs.getString(Keys.account) ?? "default";
    return prefs.getDouble(key + account);
  }

  Future<bool> getBoolean (String key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String account =  prefs.getString(Keys.account) ?? "default";
    return prefs.getBool(key + account)??false;
  }

  Future<List<String>> getStringList(String key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String account =  prefs.getString(Keys.account) ?? "default";
    return prefs.getStringList(key + account);
  }

  Future<List<String>> readList(String key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String account =  prefs.getString(Keys.account) ?? "default";
    List<String> strings = prefs.getStringList(key + account) ?? [];
    return strings;
  }

}