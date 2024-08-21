import 'package:get/get.dart';

import '../controllers/chat_detail_screen_controller.dart';

class ChatDetailScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatDetailScreenController>(
      () => ChatDetailScreenController(),
    );
  }
}
