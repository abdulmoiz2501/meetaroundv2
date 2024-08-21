import 'package:get/get.dart';

class SettingsScreenController extends GetxController {
  var switchValue = true.obs;

  void toggleSwitch(bool value) {
    switchValue.value = value;
  }
}