import 'package:get/get.dart';

import '../controller/chatroom_controller.dart';

class ChatRoomBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatRoomController>(() => ChatRoomController());
  }
}
