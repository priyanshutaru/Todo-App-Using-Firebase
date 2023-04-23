// ignore_for_file: prefer_const_constructors

import 'package:authwithmobile/auth/otp_screen.dart';
import 'package:authwithmobile/constant/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class Register_Screen extends StatefulWidget {
  const Register_Screen({super.key});

  @override
  State<Register_Screen> createState() => _Register_ScreenState();
}

class _Register_ScreenState extends State<Register_Screen> {
  final phonenumberController = TextEditingController();
  var isloading = false;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login With Phone"),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            SizedBox(height: 70),
            TextFormField(
              // keyboardType: TextInputType.text,
              controller: phonenumberController,
              decoration: InputDecoration(
                hintText: "+91 0000010000",
                // focusedBorder: OutlineInputBorder(
                //   borderSide: BorderSide(color: Colors.black, width: 1),
                //   borderRadius: BorderRadius.circular(20),
                // ),
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
                  onPressed: () {
                    setState(() {
                      isloading = true;
                    });
                    auth.verifyPhoneNumber(
                        phoneNumber: phonenumberController.text,
                        verificationCompleted: (_) {},
                        verificationFailed: (e) {
                          Constantss().toastMassege(e.toString());
                        },
                        codeSent: ((verificationId, forceResendingToken) {
                          Constantss().toastMassege("Login Succesfully");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PhoneOtpScreen(
                                verificationId: verificationId,
                              ),
                            ),
                          );
                          setState(() {
                            isloading = false;
                          });
                        }),
                        codeAutoRetrievalTimeout: (e) {
                          Constantss().toastMassege(e.toString());
                        });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
