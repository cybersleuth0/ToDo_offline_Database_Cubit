import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/Cubit/todo_cubit.dart';
import 'package:todo/Dbhelper/db_helper.dart';
import 'package:todo/Data_Model/todoModel.dart';

class AddTask extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddTaskState();
}

class AddTaskState extends State<AddTask> {
  String completeTill = "";
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  DateTime? CombinedDateTime;
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();

  Dbhelper myDb = Dbhelper.getInstance();

  @override
  void initState() {
    super.initState();
    titlecontroller.clear();
    descriptioncontroller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F7F2),
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black,
          ),
        ),
        backgroundColor: Color(0xffF2F7F2),
        centerTitle: true,
        title: Text(
          "Add todo task",
          style: TextStyle(
              color: Colors.black,
              fontSize: 27,
              fontFamily: "FiraSans_SemiBoldItalic"),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(right: 10, left: 10),
          child: Column(
            children: [
              SizedBox(height: 100),
              //Title
              TextField(
                controller: titlecontroller,
                style: const TextStyle(fontSize: 15, color: Colors.black),
                decoration: InputDecoration(
                  label: Text("Todo Title"),
                  labelStyle:
                      const TextStyle(fontSize: 19, color: Color(0xff5448C8)),
                  filled: true,
                  fillColor: Color(0xffffffff),
                  hintText: "Have a coffee",
                  hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xff5448C8), width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xff5448C8), width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
              SizedBox(height: 50),
              //desc
              TextField(
                controller: descriptioncontroller,
                keyboardType: TextInputType.multiline,
                style: const TextStyle(fontSize: 14, color: Colors.black),
                maxLines: 5,
                minLines: null,
                decoration: InputDecoration(
                  label: Text("Todo Description"),
                  labelStyle:
                      const TextStyle(fontSize: 19, color: Color(0xff5448C8)),
                  filled: true,
                  fillColor: Color(0xffffffff),
                  hintText: "Coffee makes a person focus",
                  hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xff5448C8), width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xff5448C8), width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
              SizedBox(height: 80),

              Text("Complete Till",
                  style: TextStyle(fontSize: 27, fontFamily: "Itim")),
              SizedBox(height: 20),
              //Date and Time

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        selectedDate = await showDatePicker(
                          context: context,
                          firstDate: DateTime(DateTime.now().year,
                              DateTime.now().month, DateTime.now().day),
                          lastDate: DateTime(DateTime.now().year + 1),
                        );
                      },
                      child: Text("Select Date"),
                    ),
                  ),
                  SizedBox(width: 50),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        selectedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                      },
                      child: Text("Select Time"),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 200),
              Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        overlayColor: Color(0xff3734A9),
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                        backgroundColor: Color(0xff5D5FEF)),
                    onPressed: () async {
                      if (selectedTime != null && selectedDate != null) {
                        CombinedDateTime = DateTime(
                          selectedDate!.year,
                          selectedDate!.month,
                          selectedDate!.day,
                          selectedTime!.hour,
                          selectedTime!.minute,
                        );
                      }
                      // Navigator.pop(context);
                      context.read<Todo_cubit>().addTodo(
                          addModel: TodoModel(
                              title: titlecontroller.text,
                              description: descriptioncontroller.text,
                              completetill: CombinedDateTime!
                                  .millisecondsSinceEpoch
                                  .toString(),
                              isCompleted:
                                  false //because initially it is not completed
                              ));
                      Navigator.pop(context);
                    },
                    child: Text("Add Todo",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 27,
                            fontFamily: "Itim"))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
