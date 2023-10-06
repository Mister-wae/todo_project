import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/todo_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_application/views/homepage.dart';

class ProfileOptions extends StatelessWidget {
  final String username;

  const ProfileOptions({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    final ImagePicker imagePicker = ImagePicker();
    final splitUsername = username.split("");
    XFile? image;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 5, 53, 92),
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      HomePage(username: username, image: image),
                ));
          },
        ),
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 5, 53, 92),
        title: const Text("Profile Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Container(
              height: 160,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Consumer<TodoData>(
                    builder: (context, provider, child) => CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: provider.profileInage,
                      radius: 80,
                      // ignore: unnecessary_null_comparison
                      child: provider.profileInage != null
                          ? const Text("")
                          : Text(
                              splitUsername[0].toUpperCase(),
                              style: const TextStyle(
                                fontSize: 80,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 70,
                    child: IconButton(
                      onPressed: () async {
                        image = await imagePicker.pickImage(
                            source: ImageSource.gallery);
                        Provider.of<TodoData>(context, listen: false)
                            .getImage(image);
                      },
                      icon: const Icon(
                        Icons.add_a_photo_sharp,
                        size: 40,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                username,
                style: const TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              onTap: () {
                Provider.of<TodoData>(context, listen: false)
                    .onTapLogOut(context);
              },
              tileColor: const Color.fromARGB(255, 8, 67, 116),
              title: const Text(
                "Sign Out",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
              trailing: const Icon(
                Icons.logout_sharp,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              onTap: () {
                Provider.of<TodoData>(context, listen: false)
                    .onTapLogOut(context);
              },
              tileColor: const Color.fromARGB(255, 8, 67, 116),
              title: const Text(
                "Switch Account",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
              trailing: const Icon(
                Icons.switch_account_outlined,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
