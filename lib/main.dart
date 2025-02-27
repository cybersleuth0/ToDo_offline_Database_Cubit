import 'package:flutter/material.dart';
import 'package:todo/addtask.dart';
import 'package:todo/homepage.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false  ,
    initialRoute: "/homepage",
    routes: {
      "/homepage": (context) => Homepage(),
      "/addtask": (context) => AddTask()
    },
  ));
}
