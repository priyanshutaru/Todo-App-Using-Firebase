// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:authwithmobile/constant/constant.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddTaskFirestoreScreen extends StatefulWidget {
  const AddTaskFirestoreScreen({super.key});

  @override
  State<AddTaskFirestoreScreen> createState() => _AddTaskFirestoreScreenState();
}

class _AddTaskFirestoreScreenState extends State<AddTaskFirestoreScreen> {
  final addtaskController = TextEditingController();

  final firestoreDatabase = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add FireStore ToDo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: addtaskController,
              maxLines: 5,
              //minLines: 2,
              decoration: InputDecoration(
                  hintText: "Enter Your Firestore Task................."),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 45,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  var id = DateTime.now().microsecondsSinceEpoch.toString();
                  firestoreDatabase.doc().set({
                    'title': addtaskController.text.toString(),
                    'id': id,
                  }).then((value) {
                    Constantss().toastMassege("Added Sucessfullly");
                  }).onError((error, stackTrace) {
                    Constantss().toastMassege(error.toString());
                  });
                },
                child: Text("Add Task"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
