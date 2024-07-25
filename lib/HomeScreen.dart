import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:todo_app/db_services/database.dart';
import 'package:todo_app/login_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool Personal = true, college = false, office = false;
  bool suggest = false;
  TextEditingController todoController = TextEditingController();
  Stream? todoStream;
  getonTheLoad() async {
    todoStream = await DatabaseServices().getTask(Personal
        ? "Personal"
        : college
            ? "college"
            : "office");
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget getWork() {
    return StreamBuilder(
        stream: todoStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot docSnap = snapshot.data.docs[index];
                        return CheckboxListTile(
                          activeColor: Colors.greenAccent.shade400,
                          title: Text(
                            docSnap["work"],
                          ),
                          value: docSnap["Yes"],
                          onChanged: (newValue) async {
                            await DatabaseServices().tickMethod(
                                docSnap["Id"],
                                Personal
                                    ? "Personal"
                                    : college
                                        ? "college"
                                        : "office");
                            setState(() {
                              Future.delayed(Duration(seconds: 2), () {
                                DatabaseServices().removeMethod(
                                    docSnap["Id"],
                                    Personal
                                        ? "Personal"
                                        : college
                                            ? "college"
                                            : "office");
                              });
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        );
                      }),
                )
              : Center(child: CircularProgressIndicator());
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent.shade400,
        onPressed: () {
          openBox();
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 35,
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 70, left: 20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.cyanAccent,
              Colors.yellow,
              Colors.green,

              // Colors.white,
              // Colors.white54,
              // Colors.white,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                "Hey,",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Container(
              child: Text(
                "Shivraj",
                style: TextStyle(
                  fontSize: 45,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Container(
              child: Text(
                "Let's the task begins !",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => LoginPage()));
              },
              child: Container(
                height: 45,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                ),
                child: Center(
                    child: Text(
                  "Sign Out",
                  style: TextStyle(color: Color(0xFF121212)),
                )),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Personal
                    ? Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.greenAccent.shade200,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Personal',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () async {
                          Personal = true;
                          college = false;
                          office = false;
                          await getonTheLoad();
                          setState(() {});
                        },
                        child: Text(
                          "Personal",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                college
                    ? Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.greenAccent.shade200,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'college',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () async {
                          Personal = false;
                          college = true;
                          office = false;
                          await getonTheLoad();
                          setState(() {});
                        },
                        child: Text(
                          "college",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                office
                    ? Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.greenAccent.shade200,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'office',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () async {
                          Personal = false;
                          college = false;
                          office = true;
                          await getonTheLoad();
                          setState(() {});
                        },
                        child: Text(
                          "office",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            getWork(),
          ],
        ),
      ),
    );
  }

  Future openBox() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: SingleChildScrollView(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.cancel),
                          ),
                          SizedBox(
                            width: 60.0,
                          ),
                          Text(
                            "Add ToDo Task ~",
                            style: TextStyle(color: Colors.greenAccent),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text("Add Text"),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                        child: TextField(
                          controller: todoController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter your task",
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Container(
                          width: 100,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.greenAccent,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              String id = randomAlphaNumeric(10);
                              Map<String, dynamic> userTodo = {
                                "work": todoController.text,
                                "Id": id,
                                "Yes": false,
                              };
                              Personal
                                  ? DatabaseServices()
                                      .addPersonalTask(userTodo, id)
                                  : college
                                      ? DatabaseServices()
                                          .addcollegeTask(userTodo, id)
                                      : DatabaseServices()
                                          .addofficeTask(userTodo, id);
                              Navigator.pop(context);
                            },
                            child: Center(
                              child: Text(
                                "Add",
                                style: TextStyle(color: Color(0xFF121212)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
