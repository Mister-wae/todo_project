import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:provider/provider.dart';
import 'package:todo_application/todo_provider.dart';
import 'package:todo_application/views/homepage.dart';
import 'package:todo_application/views/signin_page.dart';

final firebase_auth.FirebaseAuth firebaseAuth =
    firebase_auth.FirebaseAuth.instance;
bool circular = false;
signUp() async {
  try {
    await firebaseAuth.createUserWithEmailAndPassword(
        email: "simplyjoel6@gmail.com", password: "123456");
  } catch (e) {
    print(e);
  }
}

Widget buttonItem(String imagepath, String buttonName, double size, context) {
  return Container(
    width: MediaQuery.of(context).size.width - 60,
    height: 60,
    child: Card(
      color: const Color.fromARGB(255, 2, 25, 45),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            imagepath,
            height: size,
            width: size,
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            buttonName,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget textItem(String labelText, TextEditingController controller,
    bool obscureText, context) {
  return Container(
    width: MediaQuery.of(context).size.width - 70,
    height: 55,
    child: TextFormField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 17,
          color: Colors.white,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            width: 1,
            color: Color.fromARGB(132, 183, 58, 58),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            width: 1.5,
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}

Widget colorButton2(String text, String email, String password, context) {
  return InkWell(
    onTap: () async {
      try {
        circular = true;
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(username: email),
          ),
        );
      } catch (e) {
        final snackBar = SnackBar(
          content: Text(
            e.toString(),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    },
    child: Container(
      width: MediaQuery.of(context).size.width - 70,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(131, 122, 47, 220),
            Color.fromARGB(131, 4, 108, 235),
          ],
        ),
      ),
      child: Center(
          child: Text(
        text,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      )),
    ),
  );
}

Widget colorButton(String text, String email, String password, context) {
  return InkWell(
    onTap: () async {
      circular = true;
      try {
        firebase_auth.UserCredential userCredential = await firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SignInPage(),
          ),
        );
      } catch (e) {
        final snackBar = SnackBar(
          content: Text(
            e.toString(),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    },
    child: Container(
      width: MediaQuery.of(context).size.width - 70,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(131, 122, 47, 220),
            Color.fromARGB(131, 4, 108, 235),
          ],
        ),
      ),
      child: Center(
          child: Text(
        text,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      )),
    ),
  );
}

Widget label(String label) {
  return Text(
    label,
    style: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
  );
}

class Button extends StatelessWidget {
  Button({
    required this.onTap,
    this.isSelected = false,
    required this.color,
    required this.text,
    required this.type,
    super.key,
  });
  String text;
  Color color;
  String type;
  bool isSelected;
  void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Consumer<TodoData>(
        builder: (context, value, child) {
          return Chip(
            backgroundColor: color,
            labelPadding: const EdgeInsets.symmetric(
              vertical: 1.5,
              horizontal: 17,
            ),
            label: Text(
              text,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          );
        },
      ),
    );
  }
}

class NewTodoButton extends StatelessWidget {
  NewTodoButton({
    required this.onTap,
    required this.color,
    required this.text,
    super.key,
  });
  void Function() onTap;
  Color color;
  String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        height: 40,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
