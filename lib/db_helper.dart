import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/todoModel.dart';

class Dbhelper {
  //Static keys
  static String TABLE_NAME = "TODO";
  static String TODO_ID = "TID"; // Primary Key
  static String TODO_TITLE = "TTITLE"; // Task Title
  static String TODO_DESC = "TDESC"; // Task Description
  static String TODO_CREATED_AT =
      "TCREATED_AT"; // Timestamp (millisecondsSinceEpoch)
  static String TODO_COMPLETED_AT =
      "TCOMPLETED_AT"; // Timestamp (millisecondsSinceEpoch)
  static String TODO_IS_COMPLETED = "TIS_COMPLETED"; // 0 (false) or 1 (true)

  //create a private contracture
  Dbhelper._(); //we have to access this for that we have to make singleton class
  static Dbhelper getInstance() =>
      Dbhelper._(); //using this we can access private contracture
  //we have to create a database
  Future<Database> Opendb() async {
    Directory appDirectory = await getApplicationDocumentsDirectory();
    //now we have to create a database path and database
    String Databasepath = join(appDirectory.path, "todo_database.db");
    return await openDatabase(
      Databasepath, version: 1,
      //oncreate will create a database
      onCreate: (db, version) => {
        db.execute("CREATE TABLE $TABLE_NAME ("
            "$TODO_ID INTEGER PRIMARY KEY AUTOINCREMENT, "
            "$TODO_TITLE TEXT, "
            "$TODO_DESC TEXT, "
            "$TODO_CREATED_AT TEXT, "
            "$TODO_COMPLETED_AT TEXT, "
            "$TODO_IS_COMPLETED INTEGER)"),
      },
    );
  }

  Database? _db;

  Future<Database> getdb() async {
    // if (_db != null) {
    //   return _db!;
    // } else {
    //   return _db = await Opendb();
    // }
    //_db = _db ?? await Opendb();
    _db ??= await Opendb();
    return _db!;
  }

//Addtodo
  Future<bool> addtoto({required todoModel newtodo}) async {
    var db = await getdb();
    int roweffected = await db.insert(TABLE_NAME, newtodo.toMap());
    return roweffected > 0;
  }

  //fetchtodo
  Future<List<todoModel>> fetchtodo() async {
    List<todoModel> totaltodos = [];
    var db = await getdb();
    List<Map<String, dynamic>> todos = await db.query(TABLE_NAME);
    for (Map<String, dynamic> todo in todos) {
      totaltodos.add(todoModel.fromMap(todo));
    }
    return totaltodos;
  }
}
