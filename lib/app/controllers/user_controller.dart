import 'dart:convert';

import 'package:get/get.dart';
import 'package:scratch_project/app/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserController extends GetxController {
  final RxString token = ''.obs;
  final RxDouble latitude = 0.0.obs;
  final RxDouble longitude = 0.0.obs;
  final RxnString status = RxnString(null); // Observable for status
  final RxnInt coins = RxnInt(null); // Observable for coins
  final RxnBool verified = RxnBool(null);
  final RxnBool isSender = RxnBool(null);

  final user = UserModel(
    id: 0,
    name: '',
    email: '',
    password: '',
    rePassword: '',
    birthdate: '',
    gender: '',
    interests: [],
    profilePicture: '',
    latitude: 0.0,
    longitude: 0.0,
    status: null,
    coins: null,
    verified: null,
  ).obs;

  Future<UserModel?> fetchUserById(int userId) async {
    final String url =
        'https://meet-around-apis-production.up.railway.app/api/user/findUserById?userId=$userId';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      print('this is the response of tthe fetch user by id: ${jsonResponse}');

      if (jsonResponse['responseCode'] == "4000") {
        final userData = jsonResponse['data'];
        return UserModel.fromJson(userData);
      } else {
        print('Failed to fetch user: ${jsonResponse['responseDesc']}');
        return null;
      }
    } else {
      // Handle HTTP errors
      print('Failed to load user, status code: ${response.statusCode}');
      return null;
    }
  }

  // void updateUser(UserModel newUser) {
  //   user.value = newUser;
  //   latitude.value = newUser.latitude;
  //   longitude.value = newUser.longitude;
  //   status.value = newUser.status;
  //   coins.value = newUser.coins;
  //   verified.value = newUser.verified;
  // }
}
