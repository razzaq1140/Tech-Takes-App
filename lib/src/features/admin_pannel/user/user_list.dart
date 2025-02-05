import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_takes_app/src/common/constants/global_variable.dart';
import 'package:tech_takes_app/src/common/widgets/custom_appbar.dart';

class User {
  final String name;
  final String email;
  final String imageUrl;

  User({required this.name, required this.email, required this.imageUrl});
}

class UserList extends StatefulWidget {
  final String text;

  UserList({super.key, required this.text});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final List<User> users = [
    User(
      name: 'Jerome Bell',
      email: 'jeromebell@gmail.com',
      imageUrl:
          'https://static.vecteezy.com/system/resources/previews/005/346/410/non_2x/close-up-portrait-of-smiling-handsome-young-caucasian-man-face-looking-at-camera-on-isolated-light-gray-studio-background-photo.jpg',
      // Replace with actual URL
    ),
    User(
      name: 'Jerome Bell',
      email: 'jeromebell@gmail.com',
      imageUrl:
          'https://static.vecteezy.com/system/resources/previews/005/346/410/non_2x/close-up-portrait-of-smiling-handsome-young-caucasian-man-face-looking-at-camera-on-isolated-light-gray-studio-background-photo.jpg',
    ),
    User(
      name: 'Jerome Bell',
      email: 'jeromebell@gmail.com',
      imageUrl:
          'https://static.vecteezy.com/system/resources/previews/005/346/410/non_2x/close-up-portrait-of-smiling-handsome-young-caucasian-man-face-looking-at-camera-on-isolated-light-gray-studio-background-photo.jpg',
    ),
    User(
      name: 'Jerome Bell',
      email: 'jeromebell@gmail.com',
      imageUrl:
          'https://static.vecteezy.com/system/resources/previews/005/346/410/non_2x/close-up-portrait-of-smiling-handsome-young-caucasian-man-face-looking-at-camera-on-isolated-light-gray-studio-background-photo.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 80),
          child: DecoratedAppBar(
            title: 'Total ${widget.text} User',
            leadingWidget: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back,
                color: colorScheme(context).surface,
              ),
            ),
            endWidget: SizedBox(
              width: 10,
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Subscription List',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.green, width: 2),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15)),
                                ),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15)),
                                  child: Image.network(
                                    user.imageUrl,
                                    fit: BoxFit.cover,
                                    height: 55,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: -2,
                                right: 4,
                                child: Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 19, 162, 98),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors
                                          .white, // Border around the green dot
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.name,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                user.email,
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
