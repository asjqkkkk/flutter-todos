import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/json/task_bean.dart';
import 'package:todo_list/utils/shared_util.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    var dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, "todo.db");
    return await openDatabase(
      path,
      version: 2,
      onOpen: (db) {},
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
            "startDate TEXT,"
            "deadLine TEXT,"
            "detailList TEXT,"
            "taskIconBean TEXT"
            ")");
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async{
        if(oldVersion < 2){
         await db.execute("ALTER TABLE TodoList ADD COLUMN changeTimes INTEGER DEFAULT 0");
        }
      },
    );
    //注意，上面创建表的时候最后一行不能带逗号
  }

  //创建一项任务
  Future createTask(TaskBean task) async {
    final db = await database;
    task.id = await db.insert("TodoList", task.toMap());
  }

  //查询所有任务,isDone为true表示查询已经完成的任务,否则表示未完成
  Future<List<TaskBean>> getTasks({bool isDone = false}) async {
    final db = await database;
    final account =
        await SharedUtil.instance.getString(Keys.account) ?? "default";
    var list = await db.query("TodoList",
        where: "account = ?" +
            (isDone ? " AND overallProgress >= ?" : " AND overallProgress < ?"),
        whereArgs: [account, "1.0"]);
    List<TaskBean> beans = [];
    beans.clear();
    beans.addAll(TaskBean.fromMapList(list));
    return beans;
  }

  Future updateTask(TaskBean taskBean) async {
    final db = await database;
    int id = await db.update("TodoList", taskBean.toMap(),
        where: "id = ?", whereArgs: [taskBean.id]);
    print("更新");
  }

  Future deleteTask(int id) async {
    final db = await database;
    db.delete("TodoList", where: "id = ?", whereArgs: [id]);
    print("删除");
  }

  //通过加上百分号，进行模糊查询
  Future<List<TaskBean>> queryTask(String query) async {
    final db = await database;
    final account =
        await SharedUtil.instance.getString(Keys.account) ?? "default";
    var list = await db.query("TodoList",
        where: "account = ? AND (taskName LIKE ? "
            "OR detailList LIKE ? "
            "OR startDate LIKE ? "
            "OR deadLine LIKE ?)",
        whereArgs: [
          account,
          "%$query%",
          "%$query%",
          "%$query%",
          "%$query%",
        ]);
    List<TaskBean> beans = [];
    beans.clear();
    beans.addAll(TaskBean.fromMapList(list));
    return beans;
  }

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
