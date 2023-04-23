// ignore_for_file: prefer_const_constructors

import 'package:authwithmobile/auth/splash_services.dart';

import 'package:flutter/material.dart';

class SpalceScreen extends StatefulWidget {
  const SpalceScreen({super.key});

  @override
  State<SpalceScreen> createState() => _SpalceScreenState();
}

class _SpalceScreenState extends State<SpalceScreen> {
  SplachServices splachServices = SplachServices();

  @override
  void initState() {
    super.initState();
    splachServices.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text(
              "Splace Screen",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
