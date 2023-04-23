import 'dart:async';


import 'package:authwithmobile/auth/register_screen.dart';
import 'package:authwithmobile/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplachServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      Timer(
        // ignore: prefer_const_constructors
        Duration(seconds: 5),
        () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            )),
      );
    } else {
     Timer(
        // ignore: prefer_const_constructors
        Duration(seconds: 5),
        () => Navigator.push(
            context,
            MaterialPageRoute(
              // ignore: prefer_const_constructors
              builder: (context) => Register_Screen(),
            )),
      );
    }
  }
}
