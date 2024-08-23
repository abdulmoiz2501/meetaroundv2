import 'package:get/get.dart';

class JamController extends GetxController {
  RxString otherUserId = ''.obs;
  var isAccepted = Rx<bool?>(null);
  RxMap<String, dynamic> jamData = <String, dynamic>{}.obs;
  var gotUrl = Rx<bool?>(null);

  void resetValues() {
    otherUserId.value = '';
    isAccepted.value = null;
    gotUrl.value = null;
    jamData.clear();
    print('THe jam controller is resetted');
  }
}
