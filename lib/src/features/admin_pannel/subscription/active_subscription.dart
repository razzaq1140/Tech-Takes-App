import 'package:flutter/material.dart';
import 'package:tech_takes_app/src/common/constants/global_variable.dart';
import 'package:tech_takes_app/src/common/widgets/custom_appbar.dart';

class ActiveSubscription extends StatefulWidget {
  final String text;
  const ActiveSubscription({Key? key, required this.text}) : super(key: key);

  @override
  State<ActiveSubscription> createState() => _ActiveSubscriptionState();
}

class _ActiveSubscriptionState extends State<ActiveSubscription> {
  final List<User> users = [
    User(
      name: 'Jerome Bell,',
      email: 'jeromebell@gmail.com',
      imageUrl:
          'https://static.vecteezy.com/system/resources/previews/005/346/410/non_2x/close-up-portrait-of-smiling-handsome-young-caucasian-man-face-looking-at-camera-on-isolated-light-gray-studio-background-photo.jpg',
      subscriptionType: "Monthly",
    ),
    User(
      name: 'Jerome Bell,',
      email: 'jeromebell@gmail.com',
      imageUrl:
          'https://static.vecteezy.com/system/resources/previews/005/346/410/non_2x/close-up-portrait-of-smiling-handsome-young-caucasian-man-face-looking-at-camera-on-isolated-light-gray-studio-background-photo.jpg',
      subscriptionType: "Yearly",
    ),
    User(
      name: 'Jerome Bell,',
      email: 'jeromebell@gmail.com',
      imageUrl:
          'https://static.vecteezy.com/system/resources/previews/005/346/410/non_2x/close-up-portrait-of-smiling-handsome-young-caucasian-man-face-looking-at-camera-on-isolated-light-gray-studio-background-photo.jpg',
      subscriptionType: "Trail",
    ),
  ];

  void _handleMenuSelection(String choice) {
    // Handle "Approve" or "Reject" actions here
    if (choice == 'Approved') {
      // Approve action
    } else if (choice == 'Rejected') {
      // Reject action
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 80),
        child: DecoratedAppBar(
          title: '${widget.text} Subscriptions',
          endWidget: SizedBox(),
          leadingWidget: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back,
              color: colorScheme(context).surface,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Subscriptions List',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        // Profile Picture with Online Indicator
                        Stack(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.green, width: 2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  user.imageUrl,
                                  fit: BoxFit.cover,
                                  height: 50,
                                  width: 50,
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
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 15),

                        // User Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    user.name,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    user.subscriptionType,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                user.email,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // More Options (Approve/Reject)
                        PopupMenuButton<String>(
                          color: Colors.white,
                          icon: const Icon(Icons.more_vert, color: Colors.grey),
                          onSelected: _handleMenuSelection,
                          itemBuilder: (BuildContext context) => [
                            const PopupMenuItem<String>(
                              value: 'Approve',
                              child: Text(
                                'Approve',
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                            const PopupMenuItem<String>(
                              value: 'Reject',
                              child: Text(
                                'Reject',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      ],
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

class User {
  final String name;
  final String email;
  final String imageUrl;
  final String subscriptionType;

  User({
    required this.name,
    required this.email,
    required this.imageUrl,
    required this.subscriptionType,
  });
}
