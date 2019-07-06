import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/json/task_bean.dart';


class DBProvider{

  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    var dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, "todo.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE TodoList ("
              "id INTEGER PRIMARY KEY AUTOINCREMENT,"
              "account TEXT,"
              "taskName TEXT,"
              "taskType TEXT,"
              "taskStatus INTEGER,"
              "taskDetailNum INTEGER,"
              "overallProgress TEXT,"
              "createDate TEXT,"
              "finishDate TEXT,"
              "detailList TEXT"
              ")");
        });
    //注意，上面创建表的时候最后一行不能带逗号
  }


  //创建一项任务
  Future createTask(TaskBean task) async{
    final db = await database;
    task.id = await db.insert("TodoList", task.toMap());
    print("task:${task}");
  }

  //查询所有任务
  Future<List<Map<String, dynamic>>> getTasks() async{
    final db = await database;
    var list = db.query("TodoList");
    list.then((List<Map<String, dynamic>> data){
      print("list:${TaskBean.fromMapList(data)}");

    });
    return list;

  }

//  Future updateDiary(Diary newDiary) async {
//    final db = await database;
//    var res = await db.update("Diary", newDiary.toMap(),
//        where: "id = ?", whereArgs: [newDiary.id]);
//    return res;
//  }
//
//  Future getDiary(int id) async {
//    final db = await database;
//    var res = await db.query("Diary", where: "id = ?", whereArgs: [id]);
//    return res.isNotEmpty ? Diary.fromMap(res.first) : null;
//  }
//
//  Future<List<Diary>> getAllDiary(String account) async {
//    final db = await database;
//    var res = await db.query("Diary", where: "account = ?", whereArgs: [account]);
//    List<Diary> list =
//    res.isNotEmpty ? res.map((c) => Diary.fromMap(c)).toList() : [];
//    return list;
//  }
//
//  Future<List<Diary>> searchDiary(String search, String account) async{
//    final db = await database;
//    var res = await db.rawQuery("SELECT * FROM Diary WHERE account = ? AND (diary_content LIKE ? OR location LIKE ? OR weather LIKE ? OR diary_title LIKE ?)",
//        [account, "%$search%","%$search%","%$search%","%$search%"]);
//    List<Diary> list = res.isNotEmpty ? res.map((c) => Diary.fromMap(c)).toList() : [];
//    return list;
//  }
//
//  Future deleteDiary(int id) async {
//    final db = await database;
//    return db.delete("Diary", where: "id = ?", whereArgs: [id]);
//  }
//
//  Future deleteAll() async {
//    final db = await database;
//    db.rawDelete("Delete * from Diary");
//  }





}
