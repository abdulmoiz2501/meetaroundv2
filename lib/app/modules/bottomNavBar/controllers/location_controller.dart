import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:scratch_project/app/controllers/user_controller.dart';
import 'package:scratch_project/app/models/user_location_model.dart';
import 'package:scratch_project/app/models/user_model.dart';
import 'package:scratch_project/app/utils/constraints/colors.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class LocationController extends GetxController {
  var currentAddress = 'Fetching location...'.obs;
  var currentUsers = <UserLocationModel>[].obs;
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var webSocketResponse = ''.obs;
  var currentPosition = LatLng(37.7749, -122.4194).obs; // Default to San Francisco
  loc.Location location = loc.Location();

  WebSocketChannel? locationChannel;
  WebSocketChannel? searchChannel;

  @override
  void onInit() {
    super.onInit();
    goToCurrentLocation();
  }

  Future<void> goToCurrentLocation() async {
    try {
      final locationData = await location.getLocation();
      final position = LatLng(locationData.latitude!, locationData.longitude!);
      currentPosition.value = position;
      await connectWebSocket();
      await connectSearchWebSocket();
      // await getAddressFromLatLng(position);
    } catch (e) {
      Get.snackbar('Error', 'An error occurred, Please try again',
          backgroundColor: VoidColors.primary,
          colorText: VoidColors.whiteColor,
          snackPosition: SnackPosition.BOTTOM);
      print('Exception: $e');
    }
  }

  Future<void> connectWebSocket() async {
    locationChannel = WebSocketChannel.connect(
      Uri.parse('wss://meet-around-apis-production.up.railway.app/ws'),
    );

    var signInController = Get.put(UserController());
    final locationData = await location.getLocation();
    locationChannel!.sink.add(jsonEncode({
      "userId": signInController.user.value.id,
      "latitude": locationData.latitude,
      "longitude": locationData.longitude
    }));

    locationChannel!.stream.listen((message) {
      webSocketResponse.value = message;
      print('::: Location WebSocket Response: $message');
    }, onError: (error) {
      print('WebSocket Error: $error');
      Get.snackbar('Error', 'WebSocket connection error: $error',
          backgroundColor: VoidColors.primary,
          colorText: VoidColors.whiteColor,
          snackPosition: SnackPosition.BOTTOM);
    }, onDone: () {
      print('WebSocket connection closed');
      Get.snackbar('Info', 'WebSocket connection closed',
          backgroundColor: VoidColors.primary,
          colorText: VoidColors.whiteColor,
          snackPosition: SnackPosition.BOTTOM);
    });
  }

  Future<void> connectSearchWebSocket() async {
    print(":::: inside search websocket");

    searchChannel = WebSocketChannel.connect(
      Uri.parse('wss://meet-around-apis-production.up.railway.app/ws/search'),
    );

    var signInController = Get.put(UserController());
    final locationData = await location.getLocation();
    searchChannel!.sink.add(jsonEncode({
      "userId": signInController.user.value.id,
      "latitude": locationData.latitude,
      "longitude": locationData.longitude
    }));

    searchChannel!.stream.listen((message) {
      print('::: Search WebSocket Response: $message');
      List<dynamic> jsonResponse = jsonDecode(message);
      List<UserLocationModel> users = jsonResponse.map((userJson) => UserLocationModel.fromJson(userJson)).toList();
      currentUsers.addAll(users);
      users.forEach((user) {
        print("::: User are ${user.toJson()}");
      });
    }, onError: (error) {
      print('::: WebSocket Error: $error');
      Get.snackbar('Error', 'WebSocket connection error: $error',
          backgroundColor: VoidColors.primary,
          colorText: VoidColors.whiteColor,
          snackPosition: SnackPosition.BOTTOM);
    }, onDone: () {
      print('::: WebSocket connection closed');
      Get.snackbar('Info', 'WebSocket connection closed',
          backgroundColor: VoidColors.primary,
          colorText: VoidColors.whiteColor,
          snackPosition: SnackPosition.BOTTOM);
    });
  }

  @override
  void onClose() {
    locationChannel?.sink.close();
    searchChannel?.sink.close();
    super.onClose();
  }

  // Future<void> getAddressFromLatLng(LatLng position) async {
  //   try {
  //     List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
  //     Placemark place = placemarks[0];
  //     currentAddress.value = "${place.street}, ${place.locality}, ${place.country}";
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
