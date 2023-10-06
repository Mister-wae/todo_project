import 'package:flutter/material.dart';
import 'package:todo_application/todo_provider.dart';
import 'package:todo_application/views/addtodopage.dart';
import 'package:todo_application/views/completed_tasks.dart';
import 'package:todo_application/views/profilepage.dart';
import 'package:todo_application/views/tasks.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key, required this.username, this.image});
  var image;
  final String username;

  @override
  Widget build(BuildContext context) {
    final splitUsername = username.split("");
    final now = DateTime.now().day;
    final month = DateTime.now().month;
    List<String> months = [
      "",
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];

    List<Widget> display = [
      Tasks(username: username),
      CompletedTasks(
        username: username,
      ),
    ];

    final provider = Provider.of<TodoData>(context);

    image = provider.profileInage;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 2, 25, 45),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 2, 25, 45),
        leading: const Icon(
          Icons.checklist_rounded,
          size: 40,
          color: Colors.white,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return ProfileOptions(username: username);
                      },
                    );
                  },
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.white,
                    backgroundImage: provider.profileInage,
                  ),
                ),
                Positioned(
                  bottom: .7,
                  child: image != null
                      ? const Text("")
                      : Text(
                          splitUsername[0] == "" ? "" : splitUsername[0],
                          style: const TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                          ),
                        ),
                ),
              ],
            ),
          )
        ],
        title: const Text(
          "MyTodo",
          style: TextStyle(
            fontSize: 30,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(35),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Text(
                      "$now ${months[month]}",
                      style: const TextStyle(
                        fontSize: 33,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        const Icon(
                          Icons.calendar_today_outlined,
                          size: 50,
                          color: Colors.white,
                        ),
                        Positioned(
                          top: 20,
                          child: Text(
                            now.toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 2, 25, 45),
        currentIndex: provider.selectedIndex,
        onTap: (index) {
          Provider.of<TodoData>(context, listen: false).onItemTapped(index);
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.check_box_outline_blank,
                color: Colors.white,
              ),
              label: "Tasks"),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.check_box_outlined,
              color: Colors.white,
            ),
            label: "Completed Tasks",
          ),
        ],
      ),
      body: Consumer<TodoData>(
        builder: (context, value, child) => display[provider.selectedIndex],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          size: 35,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTodoPage(username: username),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
