import 'package:get/get.dart';
import 'package:scratch_project/app/controllers/websocket_controller.dart';

import '../controllers/bottom_nav_bar_controller.dart';

class BottomNavBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomNavBarController>(
      () => BottomNavBarController(),
    );
    Get.lazyPut<LocationWebSocketController>(
      () => LocationWebSocketController(),
    );
  }
}
