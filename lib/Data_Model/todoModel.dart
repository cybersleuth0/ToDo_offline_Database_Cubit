import 'package:todo/Dbhelper/db_helper.dart';

class TodoModel {
  int? id;
  String title;
  String description;
  String? completetill;
  bool isCompleted;

  // String createdAt;
  // String completedAt;
  // int isCompleted;

  //constructor
  TodoModel({
    this.id,
    required this.title,
    required this.description,
    required this.completetill,
    required this.isCompleted,
  });

  //use for inserting data
  //For inserting data → Use toMap() (fromModelToMap)
  Map<String, dynamic> toMap() {
    return {
      Dbhelper.TODO_TITLE: title,
      Dbhelper.TODO_DESC: description,
      Dbhelper.TODO_TCOMPLETETILL: completetill,
      Dbhelper.TODO_ISCOMPLETED: isCompleted == true ? 1 : 0,
      //if Todo_iscompleted is true then value is 1 else 0
    };
  }

  //For fetching data → Use fromMap() (MapToModel)
  factory TodoModel.fromMap(Map<String, dynamic> fromuser) {
    return TodoModel(
      id: fromuser[Dbhelper.TODO_ID],
      title: fromuser[Dbhelper.TODO_TITLE],
      description: fromuser[Dbhelper.TODO_DESC],
      completetill: fromuser[Dbhelper.TODO_TCOMPLETETILL],
      isCompleted: fromuser[Dbhelper.TODO_ISCOMPLETED] == 0 ? false : true,
    );
  }
}
