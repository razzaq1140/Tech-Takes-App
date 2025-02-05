import 'package:get/get.dart';

import '../controller/chatgroup_controller.dart';

class ChatGroupBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatGroupController>(() => ChatGroupController());
  }
}
