import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:todo_app/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => LoginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Lottie.network(
              "https://lottie.host/c69403a0-1bf6-4660-b4e2-c3a7f316b7bf/0mmGBNWFOg.json"),
        ),
      ),
    );
  }
}
