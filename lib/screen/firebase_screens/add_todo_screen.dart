import 'package:authwithmobile/constant/constant.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({super.key});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final addtaskController = TextEditingController();
  final firebasedatabase = FirebaseDatabase.instance.ref('Priyanshu');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add ToDo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: addtaskController,
              maxLines: 5,
              //minLines: 2,
              decoration: InputDecoration(hintText: "Enter Your Task"),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 45,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  String id = DateTime.now().microsecondsSinceEpoch.toString();

                  firebasedatabase.child(id).set({
                    'title': addtaskController.text.toString(),
                    'id': id,
                  }).then((value) {
                    Constantss().toastMassege("Post Added Succesfully");
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
