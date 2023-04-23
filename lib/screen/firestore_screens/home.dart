// ignore_for_file: prefer_const_constructors

import 'package:authwithmobile/auth/register_screen.dart';
import 'package:authwithmobile/constant/constant.dart';

import 'package:authwithmobile/screen/firestore_screens/add_task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class FirestoreHomeScreen extends StatefulWidget {
  const FirestoreHomeScreen({super.key});

  @override
  State<FirestoreHomeScreen> createState() => _FirestoreHomeScreenState();
}

class _FirestoreHomeScreenState extends State<FirestoreHomeScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  //final ref = FirebaseDatabase.instance.ref('Priyanshu');
  final firestoreDatabase =
      FirebaseFirestore.instance.collection('users').snapshots();
  final searchController = TextEditingController();
  final updateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FirestoreHomeScreen"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              _firebaseAuth.signOut().then((value) {
                //showLoaderDialog(context);
                Constantss().toastMassege("Logout Successfully");
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Register_Screen()));
              }).onError((error, stackTrace) {
                Constantss().toastMassege(error.toString());
              });
            },
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 30,
          ),
        ],
        // automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTaskFirestoreScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: firestoreDatabase,
              //initialData: Text("Loding..."),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Text("Something Went wrong..please waith a while");
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                            snapshot.data!.docs[index]['title'].toString()),
                        subtitle:
                            Text(snapshot.data!.docs[index]['id'].toString()),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Future<void> showMydailaug(String tittle, String idd) async {
  //   updateController.text = tittle;
  //   return showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text("Update"),
  //         content: Container(
  //           child: TextField(
  //             // controller: editcontroller,
  //             controller: updateController,
  //             decoration: InputDecoration(),
  //           ),
  //         ),
  //         actions: [
  //           TextButton(
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               },
  //               child: Text("Cancel")),
  //           TextButton(
  //               onPressed: () {
  //                 Navigator.pop(context);
  //                 ref
  //                     .child(idd)
  //                     .update({'title': updateController.text.toString()}).then(
  //                         (value) {
  //                   Constantss().toastMassege("Post Updated");
  //                 }).onError((error, stackTrace) {
  //                   Constantss().toastMassege(error.toString());
  //                 });
  //               },
  //               child: Text("Update")),
  //         ],
  //       );
  //     },
  //   );
  // }
}
