import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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
    final box = GetStorage();
    final userController = Get.put(UserController());

    String? storedToken = box.read('token');
    Map<String, dynamic>? storedUserData = box.read('user');

    if (storedToken != null && storedUserData != null) {
      userController.token.value = storedToken;
      userController.user.value = UserModel.fromJson(storedUserData);
    }
  }


}
