import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/Cubit/todo_state.dart';
import 'package:todo/Data_Model/todoModel.dart';
import 'package:todo/Dbhelper/db_helper.dart';

class Todo_cubit extends Cubit<Todo_state> {
  Dbhelper dbhelper;

  Todo_cubit({required this.dbhelper}) : super(Todo_state(todos: []));

  //Events
  void addTodo({required TodoModel addModel}) async {
    bool isInserted = await dbhelper.addtoto(newtodo: addModel);
    if (isInserted) {
      List<TodoModel> todos = await dbhelper.fetchtodo();
      emit(Todo_state(todos: todos));
    }
  }

  void initailTodos() async {
    List<TodoModel> todos = await dbhelper.fetchtodo();
    emit(Todo_state(todos: todos));
  }

  void deleteTodo({required int removeid}) async {
    bool check = await dbhelper.deleteTodo(deleteindex: removeid);
    if (check) {
      List<TodoModel> todos = await dbhelper.fetchtodo();
      emit(Todo_state(todos: todos));
    }
  }

  void updateTodoStatus(
      {required int whereupdateID, required bool updateStatus}) async {
    bool check = await dbhelper.updateStatus(
        updatedid: whereupdateID, updateStatus: updateStatus ? 1 : 0);
    if (check) {
      List<TodoModel> todos = await dbhelper.fetchtodo();
      emit(Todo_state(todos: todos));
    }
  }
}
