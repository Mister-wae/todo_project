import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/todo_provider.dart';
import 'package:todo_application/widgets.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 2, 25, 45),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Reset Password \n    with email",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              textItem("email", emailController, false, context),
              SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  Provider.of<TodoData>(context, listen: false).resetPassword(
                      context: context, email: emailController.text);
                },
                child: const Text(
                  "Send email",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
