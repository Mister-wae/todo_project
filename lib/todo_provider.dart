import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_application/views/homepage.dart';
import 'package:todo_application/views/signin_page.dart';
import 'package:todo_application/views/signup_page.dart';

class TodoData extends ChangeNotifier {
  bool isCompleted = false;
  List<Map<String, dynamic>> completedTasks = [];
  bool isSelected = false;
  int selectedIndex = 0;
  int? selectedTypeIndex;
  var profileInage;
  // void showCircular(bool circular, context) {
  //   circular = true;
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => const HomePage(username: ,),
  //     ),
  //   );
  //   notifyListeners();
  // }

  void onItemTapped(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  void onTapButton(String text, int index) {
    selectedTypeIndex = index;
    notifyListeners();
  }

  void onTapNewTodo(
      String username, String title, String description, String type,
      {bool isCompleted = false}) {
    FirebaseFirestore.instance.collection("Todo").add(
      {
        "username": username,
        "title": title,
        "description": description,
        "type": type,
        "isCompleted": isCompleted,
      },
    );
  }

  void onTapLogOut(context) async {
    await FirebaseAuth.instance.signOut().then(
      (value) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => SignUpPage(),
            ),
            (route) => false);
      },
    );
  }

  void onTapUpdateTodo(String title, String description, String type, String id,
      {bool isCompleted = false}) {
    FirebaseFirestore.instance.collection("Todo").doc(id).update(
      {
        "title": title,
        "description": description,
        "type": type,
        "isCompleted": isCompleted,
      },
    );
  }

  void checkTodo(String id, bool value,
      {required Map<String, dynamic> document}) {
    FirebaseFirestore.instance.collection("Todo").doc(id).update(
      {
        "isCompleted": value,
      },
    );
    if (value = true) {
      completedTasks.add(document);
    } else {
      completedTasks.remove(document);
    }

    notifyListeners();
  }

  void deleteTodo(String id) {
    FirebaseFirestore.instance.collection("Todo").doc(id).delete();
    notifyListeners();
  }

  ImageProvider? getImage(image) {
    if (Image != null) {
      profileInage = FileImage(File(image.path));
    } else {
      return null;
    }
    notifyListeners();
  }

  Future resetPassword({required String email, required context}) async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: email)
        .onError((error, stackTrace) {
      SnackBar snackBar = SnackBar(
        content: Text(
          error.toString(),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }).whenComplete(() => const Text("email sent"));
  }
}
