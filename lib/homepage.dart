import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/db_helper.dart';
import 'package:todo/todoModel.dart';

class Homepage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomepageState();
}

class HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    getalltodosfromdb();
  }

  Dbhelper mydb = Dbhelper.getInstance();

  List<todoModel> alltodos = [];

  void getalltodosfromdb() async {
    alltodos = await mydb.fetchtodo();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0x1abfb6da),
      appBar: AppBar(
        backgroundColor: Color(0xff121212),
        centerTitle: true,
        title: Text(
          "Todo",
          style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontFamily: "Offside",
              fontWeight: FontWeight.bold),
        ),
      ),
      body: alltodos.isEmpty
          ? Center(
              child: Column(
                children: [
                  Image(
                    image: AssetImage("assets/images/background.png"),
                  ),
                  SizedBox(height: 20),
                  Text("What Do you want to do today?",
                      style: TextStyle(color: Colors.white, fontSize: 25)),
                  SizedBox(height: 20),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Tap ",
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                        TextSpan(
                          text: " + ",
                          style: TextStyle(color: Colors.white, fontSize: 27),
                        ),
                        TextSpan(
                          text: " to add your task ",
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          : Center(
              child: ListView.builder(
              itemCount: alltodos.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(25)),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: ListTile(
                    tileColor: Color(0xff1E1E2E),
                    textColor: Colors.white,
                    title: Text(
                      alltodos[index].title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontFamily: "Offside"),
                    ),
                    subtitle: Text(
                      alltodos[index].description,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white70,
                          fontFamily: "Offside"),
                    ),
                    trailing: Text(
                        (alltodos[index].isCompleted == 1)
                            ? "Done\t ✔"
                            : "Not Done\t ❌",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: (alltodos[index].isCompleted == 1)
                                ? Colors.green
                                : Colors.redAccent,
                            fontFamily: "Itim")),
                  ),
                );
              },
            )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/addtask").then((_) {
            getalltodosfromdb();
          });
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
