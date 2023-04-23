// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:authwithmobile/constant/constant.dart';
import 'package:authwithmobile/screen/firebase_screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneOtpScreen extends StatefulWidget {
  final String verificationId;
  const PhoneOtpScreen({super.key, required this.verificationId});

  @override
  State<PhoneOtpScreen> createState() => _PhoneOtpScreenState();
}

class _PhoneOtpScreenState extends State<PhoneOtpScreen> {
  final phoneotpController = TextEditingController();
  var isloading = false;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Verify Your Number"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              SizedBox(height: 70),
              TextFormField(
                controller: phoneotpController,
                decoration: InputDecoration(
                  hintText: " 6 Digit code ",
                ),
              ),
              SizedBox(height: 30),
              Container(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                    child: Text(
                      "Verify Your Number",
                    ),
                    onPressed: () async {
                      setState(() {
                        isloading = true;
                      });

                      final credetential = PhoneAuthProvider.credential(
                          verificationId: widget.verificationId,
                          smsCode: phoneotpController.text.toString());

                      try {
                        await auth.signInWithCredential(credetential);
                        Constantss().toastMassege("Login Succesfully");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      } catch (e) {
                        setState(() {
                          isloading = false;
                        });
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
