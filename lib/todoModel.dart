import 'package:todo/db_helper.dart';

class todoModel {
  int? id;
  String title;
  String description;
  String createdAt;
  String completedAt;
  int isCompleted;

  //constructor
  todoModel(
      {required this.title,
      required this.description,
      required this.createdAt,
      required this.completedAt,
      required this.isCompleted});

  //use for inserting data
  //For inserting data → Use toMap() (fromModelToMap)
  Map<String, dynamic> toMap() {
    return {
      Dbhelper.TODO_TITLE: title,
      Dbhelper.TODO_DESC: description,
      Dbhelper.TODO_CREATED_AT: createdAt,
      Dbhelper.TODO_COMPLETED_AT: completedAt,
      Dbhelper.TODO_IS_COMPLETED: isCompleted
    };
  }

  //For fetching data → Use fromMap() (MapToModel)
  factory todoModel.fromMap(Map<String, dynamic> fromuser) {
    return todoModel(
        title: fromuser[Dbhelper.TODO_TITLE],
        description: fromuser[Dbhelper.TODO_DESC],
        createdAt: fromuser[Dbhelper.TODO_CREATED_AT],
        completedAt: fromuser[Dbhelper.TODO_COMPLETED_AT],
        isCompleted: fromuser[Dbhelper.TODO_IS_COMPLETED]);
  }
}
