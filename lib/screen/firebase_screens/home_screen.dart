// ignore_for_file: prefer_const_constructors

import 'package:authwithmobile/auth/register_screen.dart';
import 'package:authwithmobile/constant/constant.dart';
import 'package:authwithmobile/screen/firebase_screens/add_todo_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Priyanshu');
  final searchController = TextEditingController();
  final updateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomeScreen"),
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
              builder: (context) => AddTodoScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Search Your task here.....",
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
            Expanded(
              child: FirebaseAnimatedList(
                defaultChild: Center(
                  child: Text("Loading..."),
                ),
                query: ref,
                itemBuilder: (context, snapshot, animation, index) {
                  final title1 = snapshot.child("title").value.toString();

                  if (searchController.text.isEmpty) {
                    return Card(
                      child: ListTile(
                          title: Text(snapshot.child("title").value.toString()),
                          subtitle: Text(snapshot.child("id").value.toString()),
                          trailing: PopupMenuButton(
                            icon: Icon(
                              Icons.more_vert,
                              color: Colors.black,
                            ),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                child: ListTile(
                                  onTap: () {
                                    Navigator.pop(context);
                                    showMydailaug(title1,
                                        snapshot.child("id").value.toString());
                                  },
                                  title: Text("Edit"),
                                  leading: Icon(Icons.edit),
                                ),
                              ),
                              PopupMenuItem(
                                child: ListTile(
                                  onTap: () {
                                    Navigator.pop(context);
                                    ref
                                        .child(snapshot
                                            .child("id")
                                            .value
                                            .toString())
                                        .remove()
                                        .then((value) {
                                      Constantss()
                                          .toastMassege("Delete Sucessfully");
                                    }).onError((error, stackTrace) {
                                      Constantss()
                                          .toastMassege(error.toString());
                                    });
                                  },
                                  title: Text("Delete"),
                                  leading: Icon(Icons.delete),
                                ),
                              ),
                            ],
                          )),
                    );
                  } else if (title1.toLowerCase().contains(
                      searchController.text.toLowerCase().toLowerCase())) {
                    return Card(
                      child: ListTile(
                          title: Text(snapshot.child("title").value.toString()),
                          subtitle: Text(snapshot.child("id").value.toString()),
                          trailing: PopupMenuButton(
                            icon: Icon(
                              Icons.more_vert,
                              color: Colors.black,
                            ),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                child: ListTile(
                                  onTap: () {
                                    Navigator.pop(context);
                                    // showMydailaug(title1);
                                  },
                                  title: Text("Edit"),
                                  leading: Icon(Icons.edit),
                                ),
                              ),
                              PopupMenuItem(
                                child: ListTile(
                                  title: Text("Delete"),
                                  leading: Icon(Icons.delete),
                                ),
                              ),
                            ],
                          )),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showMydailaug(String tittle, String idd) async {
    updateController.text = tittle;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Update"),
          content: Container(
            child: TextField(
              // controller: editcontroller,
              controller: updateController,
              decoration: InputDecoration(),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel")),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  ref
                      .child(idd)
                      .update({'title': updateController.text.toString()}).then(
                          (value) {
                    Constantss().toastMassege("Post Updated");
                  }).onError((error, stackTrace) {
                    Constantss().toastMassege(error.toString());
                  });
                },
                child: Text("Update")),
          ],
        );
      },
    );
  }
}
