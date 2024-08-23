import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../routes/app_pages.dart';

class SettingsScreenController extends GetxController {
  var switchValue = true.obs;
   RxBool isLoading = false.obs;

  void toggleSwitch(bool value) {
    switchValue.value = value;
  }

  // Future<void> logout() async {
  //   isLoading(true);
  //   final box = GetStorage();
  //   box.remove('token');
  //   box.remove('user');
  //   final storedToken = box.read('token');
  //  if (storedToken == null) {
  //    Get.offAllNamed(Routes.SIGN_IN);
  //  }
  //  isLoading(false);
  //
  // }

  Future<void> logout() async {
    // isLoading(true);
    final box = GetStorage();
    box.remove('token');
    box.remove('user');
    final storedToken = box.read('token');
    if (storedToken == null) {
      await Get.offAllNamed(Routes.SIGN_IN);
    }
    // if (storedToken == null) {
    //   // Navigate to the Sign-In screen and wait for the navigation to complete
    //   await Get.offAllNamed(Routes.SIGN_IN);
    //   isLoading(false);
    // } else {
    //   print('AN error occurred');
    //   isLoading(false);
    // }

    // Set isLoading to false after the navigation is complete

  }


}