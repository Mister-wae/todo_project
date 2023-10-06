import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/todo_provider.dart';

class CompletedTasks extends StatelessWidget {
  const CompletedTasks({super.key, required this.username});

  final String username;

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> stream = FirebaseFirestore.instance
        .collection("Todo")
        .where("username", isEqualTo: username)
        .where("isCompleted", isEqualTo: true)
        .snapshots();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 2, 25, 45),
      body: StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          } else if (snapshot.hasData) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> document;
                    document = snapshot.data?.docs[index].data()
                        as Map<String, dynamic>;
                    Color? color;
                    switch (document["type"]) {
                      case "Important":
                        color = Colors.red;
                      case "Planned":
                        color = Colors.blue;
                    }
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Consumer<TodoData>(
                        builder: (context, provider, child) => ListTile(
                          onTap: () {
                            SnackBar snackBar = const SnackBar(
                                content: Text("Cannot Edit Completed Tasks"));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                          shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(
                            10,
                          )),
                          tileColor: color,
                          iconColor: Colors.white,
                          leading: Checkbox(
                            value: document["isCompleted"],
                            onChanged: (bool? newValue) {
                              provider.checkTodo(
                                  snapshot.data!.docs[index].id, newValue!,
                                  document: document);
                            },
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                provider
                                    .deleteTodo(snapshot.data!.docs[index].id);
                              },
                              icon: const Icon(Icons.delete)),
                          title: Text(
                            // ignore: prefer_if_null_operators
                            document["title"] == null ? "" : document["title"],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          subtitle: Text(
                            // ignore: prefer_if_null_operators
                            document["description"] == null
                                ? ""
                                : document["description"],
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          } else {
            return const Center(
              child: Text(
                "DONE TASKS WILL APPEAR HERE",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
