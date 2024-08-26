import 'dart:convert';

import 'package:get/get.dart';
import 'package:scratch_project/app/controllers/user_controller.dart';
import 'package:scratch_project/app/models/user_model.dart';
import 'package:http/http.dart' as http;

class JamController extends GetxController {
  RxString otherUserId = ''.obs;
  var isAccepted = Rx<bool?>(null);
  RxMap<String, dynamic> jamData = <String, dynamic>{}.obs;
  var gotUrl = Rx<bool?>(null);

  var isCancelled = Rx<bool?>(null);

  void resetValues() {
    otherUserId.value = '';
    isAccepted.value = null;
    gotUrl.value = null;
    jamData.clear();
    print('THe jam controller is resetted');
  }

  Future<void> completeJamming(int userId, String targetUserId) async {
    final url =
        'https://meet-around-apis-production.up.railway.app/api/user/completeJamming?userId=$userId&targetUserId=$targetUserId';

    try {
      final response = await http.post(Uri.parse(url));
      print(
          'this is the response of the complete jamming request:${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        print(
            '////This is the resopnse of the complete jamming api :${responseData}??????');
        final UserController userController = Get.find();

        if (responseData['responseCode'] == "4000") {
          final userData = responseData['data']['user'];
          userController.user.value = UserModel.fromJson(userData);

          // final targetUserData = responseData['data']['targetUser'];
          // final targetUser = UserModel.fromJson(targetUserData);
        } else {
          print('Error: ${responseData['responseDesc']}');
        }
      } else {
        print('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception occurred: $e');
    }
  }

  Future<bool> interactJamming(int userId, String targetUserId) async {
    final url =
        'https://meet-around-apis-production.up.railway.app/api/jamming/interact';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'userId': userId.toString(),
          'targetUserId': targetUserId,
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print(
            '////This is the resopnse of the complete interact jamming api :${responseData}??????');

        // Check if the responseCode is "4000"
        if (responseData['responseCode'] == "4000") {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      // Exception occurred
      print('Exception occurred: $e');
      return false;
    }
  }
}
