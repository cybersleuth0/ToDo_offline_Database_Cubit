import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/db_helper.dart';
import 'package:todo/todoModel.dart';

class AddTask extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddTaskState();
}

class AddTaskState extends State<AddTask> {
  int Iscomplited = 0;
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
      backgroundColor: Color(0x1abfb6da),
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0x80121212),
        centerTitle: true,
        title: Text(
          "Add Task",
          style: TextStyle(
              color: Colors.white,
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
              Row(
                children: [
                  Expanded(
                      child: Text("Title",
                          style: TextStyle(
                            color: Color(0xffEDEDED),
                            fontSize: 20,
                            fontFamily: "Itim",
                          ))),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xff1E1E2E),
                          borderRadius: BorderRadius.circular(10)),
                      height: 50,
                      child: TextField(
                          controller: titlecontroller,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: Color(0xffafafaf)),
                            hintText: "     Add Title",
                            border: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2)),
                          )),
                    ),
                  )
                ],
              ),
              SizedBox(height: 50),
              //Description
              Row(
                children: [
                  Expanded(
                      child: Text("Description",
                          style: TextStyle(
                            color: Color(0xffEDEDED),
                            fontSize: 20,
                            fontFamily: "Itim",
                          ))),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xff1E1E2E),
                          borderRadius: BorderRadius.circular(10)),
                      height: 50,
                      child: TextField(
                          controller: descriptioncontroller,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: Color(0xffA1A1AA)),
                            hintText: "     Add Description",
                            border: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2)),
                          )),
                    ),
                  )
                ],
              ),
              SizedBox(height: 50),
              //Is Completed
              Row(
                children: [
                  Expanded(
                      child: Text("Is Completed",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: "Itim",
                          ))),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xff1E1E2E),
                          borderRadius: BorderRadius.circular(10)),
                      child: Transform.scale(
                        scale: 1.4,
                        child: Checkbox(
                          side: BorderSide(
                            width: 2,
                            color: Colors
                                .white, // Matches other borders in your UI
                          ),
                          activeColor: Color(0xffFF4081),
                          // Checked color
                          checkColor: Color(0xffffc107),
                          // Tick color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                5), // Makes it slightly rounded
                          ),
                          value: Iscomplited == 1,
                          onChanged: (bool? value) {
                            setState(() {
                              if (value != null) {
                                Iscomplited = 1;
                              } else {
                                Iscomplited = 0;
                              }
                            });
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 300),
              Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        overlayColor: Color(0xff3734A9),
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                        backgroundColor: Color(0xff5D5FEF)),
                    onPressed: () async {
                      String completedAt = (Iscomplited == 1)
                          ? DateTime.now().millisecondsSinceEpoch.toString()
                          : "";
                      bool inserted = await myDb.addtoto(
                          newtodo: todoModel(
                              title: titlecontroller.text,
                              description: descriptioncontroller.text,
                              createdAt: DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString(),
                              completedAt: completedAt,
                              isCompleted: Iscomplited));
                      print(inserted ? "Inserted" : "Not Inserted");
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
