import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/firebase_services/auth_service.dart';
import 'package:todo_app/signUp_page.dart';

import 'HomeScreen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseServices _auth = FirebaseServices();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
                  "Login",
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
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.only(left: 90, right: 90),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: GestureDetector(
                    onTap: () async {
                      String email = _emailController.text;
                      String password = _passwordController.text;

                      User? user = await _auth.signInMethod(email, password);

                      if (user != null) {
                        print("User is Successfully Sign-In !");
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => HomeScreen()));
                      } else {
                        print("Error");
                      }
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 22,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an Account? ",
                    style: TextStyle(fontSize: 15),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => signupPage()));
                    },
                    child: Text(
                      "Sign-Up",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.blue,
                      ),
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
