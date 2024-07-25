import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/HomeScreen.dart';
import 'package:todo_app/firebase_services/auth_service.dart';
import 'package:todo_app/login_page.dart';

class signupPage extends StatefulWidget {
  const signupPage({super.key});

  @override
  State<signupPage> createState() => _signupPageState();
}

class _signupPageState extends State<signupPage> {
  final FirebaseServices _auth = FirebaseServices();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/pic.jpeg"), fit: BoxFit.fill),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 50, left: 40),
                child: Text(
                  "Sign-Up",
                  style: TextStyle(
                    fontSize: 50,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Container(
                padding: EdgeInsets.only(top: 10, left: 25),
                child: Text(
                  "Welcome !",
                  style: TextStyle(
                    fontSize: 43,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 70),
                child: Container(
                  margin: EdgeInsets.only(left: 90, right: 90),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: Colors.white38),
                  child: TextFormField(
                    controller: _usernameController,
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                    decoration: InputDecoration(
                        fillColor: Colors.black12,
                        hintText: "Username..",
                        hintStyle: TextStyle(color: Colors.black),
                        border: InputBorder.none,
                        filled: true),
                  ),
                ),
              ),
              SizedBox(
                height: 28,
              ),
              Container(
                // padding: EdgeInsets.only(top: 70),
                child: Container(
                  margin: EdgeInsets.only(left: 90, right: 90),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: Colors.white38),
                  child: TextFormField(
                    controller: _emailController,
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                    decoration: InputDecoration(
                        fillColor: Colors.black12,
                        hintText: "Email..",
                        hintStyle: TextStyle(color: Colors.black),
                        border: InputBorder.none,
                        filled: true),
                  ),
                ),
              ),
              SizedBox(
                height: 28,
              ),
              Container(
                child: Container(
                  margin: EdgeInsets.only(left: 90, right: 90),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: Colors.white38),
                  child: TextFormField(
                    controller: _passwordController,
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                    decoration: InputDecoration(
                        fillColor: Colors.black12,
                        hintText: "Password",
                        hintStyle: TextStyle(color: Colors.black),
                        border: InputBorder.none,
                        filled: true),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(left: 90, right: 90),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: GestureDetector(
                    onTap: () async {
                      String username = _usernameController.text;
                      String email = _emailController.text;
                      String password = _passwordController.text;

                      User? user = await _auth.signUpMethod(email, password);

                      if (user != null) {
                        print("User is Successfully Created !");
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => HomeScreen()));
                      } else {
                        print("User is not Successfully Created !");
                      }
                    },
                    child: Text(
                      "SignUp",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an Account ! ",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => LoginPage()));
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.blue, fontSize: 15),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
