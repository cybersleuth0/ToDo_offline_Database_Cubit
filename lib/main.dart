import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/Cubit/todo_cubit.dart';
import 'package:todo/Dbhelper/db_helper.dart';
import 'package:todo/pages/addtask.dart';
import 'package:todo/pages/homepage.dart';

void main() {
  runApp(BlocProvider(
      create: (context) => Todo_cubit(dbhelper: Dbhelper.getInstance()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/homepage",
        routes: {
          "/homepage": (context) => Homepage(),
          "/addtask": (context) => AddTask()
        },
      )));
}