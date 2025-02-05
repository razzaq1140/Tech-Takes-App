import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/chatroom_controller.dart';

class ChatRoomScreen extends StatelessWidget {
  final ChatRoomController controller = Get.put(ChatRoomController());

  ChatRoomScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chatroom"),
        bottom: TabBar(
          controller: controller.tabController,
          indicatorColor: Colors.transparent,
          onTap: (index) => controller.changeTab(index),
          tabs: List.generate(4, (index) {
            return GetBuilder<ChatRoomController>(
              builder: (_) => Tab(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                    color: controller.selectedIndex == index
                        ? Colors.green
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _tabTitle(index),
                    style: TextStyle(
                      color: controller.selectedIndex == index
                          ? Colors.white
                          : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
      body: TabBarView(
        controller: controller.tabController,
        children: const [
          Center(child: Text("All Messages")),
          Center(child: Text("Unread Messages")),
          Center(child: Text("Read Messages")),
          Center(child: Text("Pinned Messages")),
        ],
      ),
    );
  }

  String _tabTitle(int index) {
    switch (index) {
      case 0:
        return "All";
      case 1:
        return "Unread";
      case 2:
        return "Read";
      case 3:
        return "Pinned";
      default:
        return "";
    }
  }
}
