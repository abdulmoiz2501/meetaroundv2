import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:scratch_project/app/modules/ChatScreen/controllers/chat_screen_controller.dart';

import '../../../controllers/user_controller.dart';
import '../../../models/user_model.dart';

class BottomNavBarController extends GetxController {
  var selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    // final box = GetStorage();
    // final userController = Get.put(UserController());
    // final ChatScreenController chatScreenController =
    //     Get.isRegistered() ? Get.find() : Get.put(ChatScreenController());
    //
    // String? storedToken = box.read('token');
    // Map<String, dynamic>? storedUserData = box.read('user');
    //
    // if (storedToken != null && storedUserData != null) {
    //   userController.token.value = storedToken;
    //   userController.user.value = UserModel.fromJson(storedUserData);
    //   print('????????//${userController.user.value.name}');
    // }
  }
}
