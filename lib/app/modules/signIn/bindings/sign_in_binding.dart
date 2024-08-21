import 'package:get/get.dart';
import 'package:scratch_project/app/controllers/user_controller.dart';
import 'package:scratch_project/app/controllers/websocket_controller.dart';

import '../controllers/sign_in_controller.dart';

class SignInBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SignInController>(
      SignInController(),
    );
    Get.put<LocationWebSocketController>(
      LocationWebSocketController(),
    );
    Get.put(UserController(), permanent: true);
  }
}
