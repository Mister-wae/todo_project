import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/todo_provider.dart';
import 'package:todo_application/widgets.dart';

class AddTodoPage extends StatelessWidget {
  const AddTodoPage({super.key, required this.username});

  final String username;

  @override
  Widget build(BuildContext context) {
    final TextEditingController todoController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    String type = "";

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 2, 25, 45),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 2, 25, 45),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
      ),
      body: Consumer<TodoData>(
        builder: (context, provider, child) => Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "New Task",
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  label("Task title"),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Colors.white,
                      ),
                    ),
                    height: 50,
                    width: MediaQuery.of(context).size.width - 80,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      child: TextField(
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        cursorColor: Colors.white,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        controller: todoController,
                        maxLines: null,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  label("Description"),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.white,
                        )),
                    height: 200,
                    width: MediaQuery.of(context).size.width - 80,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: TextField(
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        cursorColor: Colors.white,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        controller: descriptionController,
                        maxLines: null,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  label("Task Type"),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Button(
                        color: provider.selectedTypeIndex != null &&
                                provider.selectedTypeIndex == 0
                            ? Colors.white
                            : Colors.red,
                        text: "Important",
                        type: type,
                        isSelected: provider.selectedTypeIndex != null &&
                                provider.selectedTypeIndex == 0
                            ? true
                            : false,
                        onTap: () {
                          provider.onTapButton("Important", 0);
                          type = "Important";
                        },
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Button(
                        color: provider.selectedTypeIndex != null &&
                                provider.selectedTypeIndex == 1
                            ? Colors.white
                            : Colors.blue,
                        text: "Planned",
                        type: type,
                        isSelected: provider.selectedTypeIndex != null &&
                                provider.selectedTypeIndex == 1
                            ? true
                            : false,
                        onTap: () {
                          provider.onTapButton("Planned", 1);
                          type = "Planned";
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  NewTodoButton(
                    color: const Color.fromARGB(255, 255, 104, 3),
                    text: "Add task",
                    onTap: () {
                      provider.onTapNewTodo(
                        username,
                        todoController.text,
                        descriptionController.text,
                        type,
                      );
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
