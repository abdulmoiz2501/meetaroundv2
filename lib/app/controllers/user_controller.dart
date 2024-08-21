import 'package:get/get.dart';
import 'package:scratch_project/app/models/user_model.dart';

class UserController extends GetxController {
  final RxString token = ''.obs;
  final RxDouble latitude = 0.0.obs;
  final RxDouble longitude = 0.0.obs;
  final RxnString status = RxnString(null); // Observable for status
  final RxnInt coins = RxnInt(null); // Observable for coins
  final RxnBool verified = RxnBool(null); // Observable for verified

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

  // void updateUser(UserModel newUser) {
  //   user.value = newUser;
  //   latitude.value = newUser.latitude;
  //   longitude.value = newUser.longitude;
  //   status.value = newUser.status;
  //   coins.value = newUser.coins;
  //   verified.value = newUser.verified;
  // }
}
