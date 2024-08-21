import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

import '../../../Models/user_model.dart';
import '../../../controllers/user_controller.dart';
import '../../../utils/constraints/colors.dart';
import '../../JammingScreen/controllers/jamming_screen_controller.dart';
import '../../signIn/controllers/sign_in_controller.dart';
import '../../signUp/controllers/sign_up_controller.dart';

class SearchScreenController extends GetxController {
  final SignInController signInController = Get.put(SignInController());
  final SignUpController signUpController = Get.put(SignUpController());
  final UserController userController = Get.find();
  var isLoading = false.obs;
  var isChat = false.obs;
  var userStatus = true.obs;
  var users = <UserModel>[].obs;
  var distances = <int, double>{}.obs;
  var addresses = <int, String>{}.obs;
  var isDistanceLoading = false.obs;
  var isAddressLoading = false.obs;
  var comeFromChat = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    final userId = signInController.id.value;
    final token = signInController.token.value;
    final url = 'https://meet-around-apis-production.up.railway.app/api/user/getUsers?userId=$userId';

    try {
      isLoading(true);
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        var userList = jsonResponse['data'] as List;
        users.value = userList.map((userJson) {
          return UserModel.fromJson(userJson);
        }).toList();

        calculateDistancesAndAddressesForUsers();
      } else {
        Get.snackbar('Error', 'Failed to fetch users: ${response.reasonPhrase}');
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred: $e',
        backgroundColor: VoidColors.primary,
        colorText: VoidColors.whiteColor,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading(false);
    }
  }

  void calculateDistancesAndAddressesForUsers() async {
    isDistanceLoading(true);
    isAddressLoading(true);
    final lattitude = userController.user.value.latitude;
    final longitude = userController.user.value.longitude;

    double myLat = lattitude;
    double myLong = longitude;

    for (var user in users) {
      if (user.latitude != 0.0 && user.longitude != 0.0) {
        double calculatedDistance = calculateDistance(
            myLat,
            myLong,
            double.parse(user.latitude.toString()),
            double.parse(user.longitude.toString()));
        distances[user.id] = calculatedDistance;

        String address = await getAddressFromLatLng(
            double.parse(user.latitude.toString()),
            double.parse(user.longitude.toString()));
        addresses[user.id] = address;
      }
    }

    isDistanceLoading(false);
    isAddressLoading(false);
  }

  double calculateDistance(
      double myLat, double myLong, double userLat, double userLong) {
    const double earthRadius = 6371.0;

    double dLat = _toRadians(userLat - myLat);
    double dLong = _toRadians(userLong - myLong);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(myLat)) *
            cos(_toRadians(userLat)) *
            sin(dLong / 2) *
            sin(dLong / 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    double calculatedDistance = earthRadius * c;
    return calculatedDistance;
  }

  double _toRadians(double degree) {
    return degree * pi / 180;
  }

  Future<String> getAddressFromLatLng(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemarks[0];
      return "${place.country}, ${place.locality}}";
    } catch (e) {
      return "Unknown location";
    }
  }

  void showJammingRequestDialog(int requestingUserId) {
    Get.defaultDialog(
      title: "Jamming Request",
      middleText: "User $requestingUserId wants to jam with you. Do you want to accept?",
      textCancel: "Reject",
      textConfirm: "Accept",
      onCancel: () {
        Get.find<JammingScreenController>().sendJammingResponse(requestingUserId, 'reject');
      },
      onConfirm: () {
        Get.find<JammingScreenController>().sendJammingResponse(requestingUserId, 'accept');
      },
    );
  }

  void toggleChatMusic() {
    isChat.value = !isChat.value;
  }
}
