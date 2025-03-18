import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/Data_Model/todoModel.dart';

class Dbhelper {
  //Static keys
  static String TABLE_NAME = "TODO";
  static String TODO_ID = "TID"; // Primary Key
  static String TODO_TITLE = "TTITLE"; // Task Title
  static String TODO_DESC = "TDESC"; // Task Description
  static String TODO_TCOMPLETETILL = "TCOMPLETETILL";
  static String TODO_ISCOMPLETED = "TISCompleted";

  //create a private contracture
  Dbhelper._(); //we have to access this for that we have to make singleton class
  static Dbhelper getInstance() =>
      Dbhelper._(); //using this we can access private contracture
  //we have to create a database
  Future<Database> Opendb() async {
    Directory appDirectory = await getApplicationDocumentsDirectory();
    // Create the database path
    String databasePath = join(appDirectory.path, "todo_database.db");
    return await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE $TABLE_NAME ("
          "$TODO_ID INTEGER PRIMARY KEY AUTOINCREMENT, "
          "$TODO_TITLE TEXT, "
          "$TODO_DESC TEXT, "
          "$TODO_TCOMPLETETILL TEXT, "
          "$TODO_ISCOMPLETED INTEGER"
          ")",
        );
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
  Future<bool> addtoto({required TodoModel newtodo}) async {
    var db = await getdb();
    int roweffected = await db.insert(TABLE_NAME, newtodo.toMap());
    return roweffected > 0;
  }

  //fetchtodo
  Future<List<TodoModel>> fetchtodo() async {
    List<TodoModel> totaltodos = [];
    var db = await getdb();
    List<Map<String, dynamic>> todos = await db.query(TABLE_NAME);
    // print("Eryuou: $todos");
    for (Map<String, dynamic> todo in todos) {
      totaltodos.add(TodoModel.fromMap(todo));
    }
    return totaltodos;
  }

  //delete todo

  Future<bool> deleteTodo({required int deleteindex}) async {
    var db = await getdb();
    int roweffected =
        await db.delete(TABLE_NAME, where: "$TODO_ID = $deleteindex");
    return roweffected > 0;
  }

  //update todo complete status
  Future<bool> updateStatus(
      {required int updatedid, required int updateStatus}) async {
    var db = await getdb();
    int roweffected = await db.update(
        TABLE_NAME, {"$TODO_ISCOMPLETED": updateStatus},
        where: "$TODO_ID=$updatedid");
    return roweffected > 0;
    // db.update(
    //     tableName,          // 1. Table name (WHERE the data is stored)
    //     values,             // 2. Data to update (WHAT you want to change)
    //     where: condition     // 3. Condition (WHERE to apply the change)
    // );
  }
}
