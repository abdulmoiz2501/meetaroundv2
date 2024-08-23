import 'package:get/get.dart';

import '../controllers/jamming_screen_controller.dart';

class JammingScreenBinding extends Bindings {
  final int userId;

  JammingScreenBinding({required this.userId});

  @override
  void dependencies() {
    Get.lazyPut<JammingScreenController>(
      () => JammingScreenController(),
    );
  }
}
