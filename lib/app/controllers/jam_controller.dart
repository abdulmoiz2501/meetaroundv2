import 'package:get/get.dart';

class JamController extends GetxController {
  RxString otherUserId = ''.obs;
  var isAccepted = Rx<bool?>(null);
  RxMap<String, dynamic> jamData = <String, dynamic>{}.obs;
  void resetValues() {
    otherUserId.value = '';
    isAccepted.value = null;
    jamData.clear();
  }
}
