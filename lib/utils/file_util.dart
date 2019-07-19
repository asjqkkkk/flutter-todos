import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';



class FileUtil{
  static FileUtil _instance;

  static FileUtil getInstance(){
    if(_instance == null){
        _instance = FileUtil._internal();
    }
    return _instance;
  }

  FileUtil._internal();




  Future<String> getSavePath(String endPath) async {
    Directory tempDir = await getApplicationDocumentsDirectory();
    String path = tempDir.path + endPath;
    Directory directory = Directory(path);
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }
    return path;
  }

  void copyFile(String oldPath, String newPath){
    File file = File(oldPath);
    if(file.existsSync()){
      file.copy(newPath);
    }
  }

  Future<List<String>> getDirChildren(String path) async {
    Directory directory = Directory(path);
    final childrenDir = directory.listSync();
    List<String> pathList = [];
    for (var o in childrenDir) {
      final filename = o.path.split("/").last;
      if (filename.contains(".")) {
        pathList.add(o.path);
      }
    }
    return pathList;
  }


  /**
   * assetPath 例子 'images/'
   * assetName 例子 '1.jpg'
   * filePath 例子:'/myFile/'
   * name  例子 'girl.jpg'
   */
  Future<String> copyAssetToFile(String assetPath,String assetName, String filePath, String fileName) async{
    String newPath = await FileUtil.getInstance().getSavePath(filePath);
    String name = fileName;
    bool exists = await new File(newPath + name).exists();
    if (!exists) {
      var data = await rootBundle.load(assetPath + assetName);
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(newPath + name).writeAsBytes(bytes);
      return newPath + name;
    } else return newPath + name;
  }
}