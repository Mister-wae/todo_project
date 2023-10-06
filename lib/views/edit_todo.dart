import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/todo_provider.dart';
import 'package:todo_application/widgets.dart';

class EditTodoPage extends StatelessWidget {
  EditTodoPage(
      {super.key,
      required this.id,
      required this.document,
      required this.type});
  final TextEditingController edittodoController = TextEditingController();
  final TextEditingController editdescriptionController =
      TextEditingController();
  String type;
  final Map<String, dynamic> document;
  final String id;

  @override
  Widget build(BuildContext context) {
    edittodoController.text = document["title"];
    editdescriptionController.text = document["description"];
    type = document["type"];
    Color? color1;
    Color? color2;
    int? typeIndex;
    switch (type) {
      case "Important":
        color1 = Colors.white;
        color2 = Colors.blue;
        typeIndex = 0;

      case "Planned":
        color1 = Colors.red;
        color2 = Colors.white;
        typeIndex = 1;
      default:
        color1 = Colors.red;
        color2 = Colors.blue;
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 2, 25, 45),
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 2, 25, 45),
      ),
      body: Consumer<TodoData>(
        builder: (context, provider, child) => SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Your Task",
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.normal,
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
                        controller: edittodoController,
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
                        controller: editdescriptionController,
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
                        color: color1!,
                        text: "Important",
                        type: type,
                        isSelected: provider.selectedTypeIndex != null &&
                                provider.selectedTypeIndex == typeIndex
                            ? true
                            : false,
                        onTap: () {
                          provider.onTapButton("Important", 0);
                          type = "Important";
                          color1 = Colors.white;
                          color2 = Colors.blue;
                          typeIndex = 0;
                        },
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Button(
                        color: color2!,
                        text: "Planned",
                        type: type,
                        isSelected: provider.selectedTypeIndex != null &&
                                provider.selectedTypeIndex == typeIndex
                            ? true
                            : false,
                        onTap: () {
                          provider.onTapButton("Planned", 1);
                          type = "Planned";
                          color1 = Colors.red;
                          color2 = Colors.white;
                          typeIndex = 1;
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
                    text: "Update task",
                    onTap: () {
                      provider.onTapUpdateTodo(
                        edittodoController.text,
                        editdescriptionController.text,
                        type,
                        id,
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
