import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/Cubit/todo_cubit.dart';
import 'package:todo/Cubit/todo_state.dart';
import 'package:todo/Data_Model/todoModel.dart';

class Homepage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomepageState();
}

class HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    context.read<Todo_cubit>().initailTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F7F2),
      appBar: AppBar(
        backgroundColor: Color(0xffF2F7F2),
        centerTitle: true,
        title: Text(
          "Todo",
          style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontFamily: "Offside",
              fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<Todo_cubit, Todo_state>(builder: (ctx, state) {
        return state.todos.isNotEmpty
            ? Center(
                child: ListView.builder(
                itemCount: state.todos.length,
                itemBuilder: (context, index) {
                  TodoModel eachTodo = state.todos[index];
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.lightBlue, width: 2),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: InkWell(
                        onLongPress: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (ctx) {
                              return Container(
                                height: 350,
                                padding: EdgeInsets.all(16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        context
                                            .read<Todo_cubit>()
                                            .deleteTodo(removeid: eachTodo.id!);
                                        Navigator.of(context)
                                            .pop(); // Close the modal after deleting
                                      },
                                      child: Text("Delete"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: Text("Cancel"),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: ListTile(
                          contentPadding: EdgeInsets.all(15),
                          leading: Checkbox(
                            value: state.todos[index].isCompleted == true,
                            onChanged: (bool? value) {
                              setState(() {
                                eachTodo.isCompleted = value! ? true : false;
                              });
                            },
                          ),
                          title: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  eachTodo.title.toUpperCase(),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 5),
                              Text(
                                eachTodo.description,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[700],
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Complete By: ${DateFormat('dd-MM-yyyy hh:mm a').format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      int.parse(eachTodo.completetill ?? '0')),
                                )}",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.blueGrey,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                          trailing: Icon(
                            eachTodo.isCompleted == 1
                                ? Icons.check_circle
                                : Icons.cancel,
                            color: eachTodo.isCompleted == 1
                                ? Colors.green
                                : Colors.red,
                            size: 28,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ))
            : Center(
                child: Column(
                  children: [
                    Image(
                      image: AssetImage("assets/images/background.png"),
                    ),
                    SizedBox(height: 20),
                    Text("What Do you want to do today?",
                        style: TextStyle(color: Colors.black, fontSize: 25)),
                    SizedBox(height: 20),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "Tap ",
                            style: TextStyle(color: Colors.black, fontSize: 22),
                          ),
                          TextSpan(
                            text: " + ",
                            style: TextStyle(color: Colors.black, fontSize: 27),
                          ),
                          TextSpan(
                            text: " to add your task ",
                            style: TextStyle(color: Colors.black, fontSize: 22),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/addtask");
          // .then((_) {
          //   getalltodosfromdb();
          // });
        },
        backgroundColor: Color(0xff5D5FEF),
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Icon(
          Icons.add,
          size: 42,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
