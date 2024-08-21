import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:scratch_project/app/modules/signIn/controllers/sign_in_controller.dart';
import 'package:scratch_project/app/routes/app_pages.dart';
import 'package:scratch_project/app/utils/constraints/api_constants.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../../utils/constraints/colors.dart';

class SignUpController extends GetxController {
  var isLoading = false.obs;
  var accept = false.obs;
  var loading = false.obs;
  Rx<XFile?> imgFile = Rx<XFile?>(null);
  var isImgPicked = false.obs;
  var selectedMusicGenres = <String>[].obs;
  var selectedGender = 'Male'.obs;
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var webSocketResponse = ''.obs;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPassController = TextEditingController();
  final dateOfBirthController = TextEditingController();

  final SignInController signInController = Get.put(SignInController());

  void toggleAccept() {
    accept.value = !accept.value;
  }

  void pickPicture() async {
    try {
      final ImagePicker picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        imgFile.value = XFile(pickedFile.path);
        isImgPicked(true);
      } else {
        imgFile.value = null;
        isImgPicked(false);
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while picking an image: $e',
          backgroundColor: VoidColors.secondary,
          colorText: VoidColors.whiteColor,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> emailVerify() async {
    // Validate if any fields are empty
    if (nameController.text.isEmpty) {
      Get.snackbar('Error', 'Name cannot be empty',
          backgroundColor: VoidColors.primary,
          colorText: VoidColors.whiteColor,
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    if (emailController.text.isEmpty) {
      Get.snackbar('Error', 'Email cannot be empty',
          backgroundColor: VoidColors.primary,
          colorText: VoidColors.whiteColor,
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    if (passwordController.text.isEmpty) {
      Get.snackbar('Error', 'Password cannot be empty',
          backgroundColor: VoidColors.primary,
          colorText: VoidColors.whiteColor,
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    if (confirmPassController.text.isEmpty) {
      Get.snackbar('Error', 'Confirm Password cannot be empty',
          backgroundColor: VoidColors.primary,
          colorText: VoidColors.whiteColor,
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    // Validate email format
    String emailPattern = r'^[^@]+@[^@]+\.[^@]+';
    RegExp emailRegExp = RegExp(emailPattern);
    if (!emailRegExp.hasMatch(emailController.text)) {
      Get.snackbar('Error', 'Invalid email format',
          backgroundColor: VoidColors.primary,
          colorText: VoidColors.whiteColor,
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    // Validate password length
    if (passwordController.text.length < 6) {
      Get.snackbar('Error', 'Password must be at least 6 characters long',
          backgroundColor: VoidColors.primary,
          colorText: VoidColors.whiteColor,
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    // Validate if passwords match
    if (passwordController.text != confirmPassController.text) {
      Get.snackbar('Error', 'Passwords do not match',
          backgroundColor: VoidColors.primary,
          colorText: VoidColors.whiteColor,
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    final apiUrl = "$baseUrl/emailValidation";
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      'name': nameController.text,
      'email': emailController.text,
      'password': passwordController.text,
    });

    try {
      final response =
          await http.post(Uri.parse(apiUrl), headers: headers, body: body);
      final responseData = json.decode(response.body);

      if (responseData['responseCode'] == '4001') {
        Get.snackbar('Success', 'Operation Successful',
            backgroundColor: VoidColors.primary,
            colorText: VoidColors.whiteColor,
            snackPosition: SnackPosition.BOTTOM);
        Get.toNamed(Routes.DATE_OF_BIRTH);
      } else {
        Get.snackbar('Error', responseData['responseDesc'],
            backgroundColor: VoidColors.primary,
            colorText: VoidColors.whiteColor,
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error', 'An error occurred, Plz try again',
          backgroundColor: VoidColors.primary,
          colorText: VoidColors.whiteColor,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void selectGender(String gender) {
    selectedGender.value = gender;
  }

  void toggleMusicGenre(String genre) {
    if (selectedMusicGenres.contains(genre)) {
      selectedMusicGenres.remove(genre);
    } else {
      selectedMusicGenres.add(genre);
    }
  }

  Future<void> signUp() async {
    // Validate if any fields are empty
    if (nameController.text.isEmpty) {
      Get.snackbar('Error', 'Name cannot be empty',
          backgroundColor: VoidColors.primary,
          colorText: VoidColors.whiteColor,
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    if (emailController.text.isEmpty) {
      Get.snackbar('Error', 'Email cannot be empty',
          backgroundColor: VoidColors.primary,
          colorText: VoidColors.whiteColor,
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    if (passwordController.text.isEmpty) {
      Get.snackbar('Error', 'Password cannot be empty',
          backgroundColor: VoidColors.primary,
          colorText: VoidColors.whiteColor,
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    if (confirmPassController.text.isEmpty) {
      Get.snackbar('Error', 'Confirm Password cannot be empty',
          backgroundColor: VoidColors.primary,
          colorText: VoidColors.whiteColor,
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    if (dateOfBirthController.text.isEmpty) {
      Get.snackbar('Error', 'Date of Birth cannot be empty',
          backgroundColor: VoidColors.primary,
          colorText: VoidColors.whiteColor,
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    if (selectedGender.value.isEmpty) {
      Get.snackbar('Error', 'Gender cannot be empty',
          backgroundColor: VoidColors.primary,
          colorText: VoidColors.whiteColor,
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    if (selectedMusicGenres.isEmpty) {
      Get.snackbar('Error', 'At least one interest must be selected',
          backgroundColor: VoidColors.primary,
          colorText: VoidColors.whiteColor,
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    if (latitude.value == 0.0 || longitude.value == 0.0) {
      Get.snackbar('Error', 'Location must be provided',
          backgroundColor: VoidColors.primary,
          colorText: VoidColors.whiteColor,
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    if (passwordController.text != confirmPassController.text) {
      Get.snackbar('Error', 'Passwords do not match',
          backgroundColor: VoidColors.primary,
          colorText: VoidColors.whiteColor,
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    if (imgFile.value == null) {
      Get.snackbar('Error', 'Profile picture must be selected',
          backgroundColor: VoidColors.primary,
          colorText: VoidColors.whiteColor,
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    final apiUrl = "$baseUrl/signUp";
    final headers = {'Content-Type': 'application/json'};

    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.fields['name'] = nameController.text;
    request.fields['email'] = emailController.text;
    request.fields['password'] = passwordController.text;
    request.fields['re_password'] = confirmPassController.text;
    request.fields['birthdate'] = dateOfBirthController.text;
    request.fields['gender'] = selectedGender.value;
    request.fields['interests'] = selectedMusicGenres.join(', ');
    request.fields['latitude'] = latitude.value.toString();
    request.fields['longitude'] = longitude.value.toString();

    if (imgFile.value != null) {
      var file = await http.MultipartFile.fromPath(
          'profile_picture', imgFile.value!.path);
      request.files.add(file);
    }
    try {
      loading(true);
      print('Sending request to $apiUrl with fields: ${request.fields}');
      if (imgFile.value != null) {
        print('Sending file: ${imgFile.value!.path}');
      }

      final response = await request.send();
      final responseData = await response.stream.bytesToString();

      print('Response status: ${response.statusCode}');
      print('Response body: $responseData');

      final parsedResponse = json.decode(responseData);
      if (parsedResponse['responseCode'] == '4000') {
        Get.snackbar('Success', 'Signup successful',
            backgroundColor: VoidColors.primary,
            colorText: VoidColors.whiteColor,
            snackPosition: SnackPosition.BOTTOM);
        Get.toNamed(Routes.SIGN_IN);
      } else {
        Get.snackbar('Error', parsedResponse['responseDesc'],
            backgroundColor: VoidColors.primary,
            colorText: VoidColors.whiteColor,
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      loading(false);
      Get.snackbar('Error', 'An error occurred, Plz try again',
          backgroundColor: VoidColors.primary,
          colorText: VoidColors.whiteColor,
          snackPosition: SnackPosition.BOTTOM);
      print('Exception: $e');
    }
  }

  Future<void> getCurrentLocation() async {
    isLoading.value = true;
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar('Error', 'Location services are disabled.',
          backgroundColor: VoidColors.primary, colorText: VoidColors.secondary);
      isLoading.value = false;
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar('Error', 'Location permissions are denied.',
            backgroundColor: VoidColors.primary,
            colorText: VoidColors.secondary);
        isLoading.value = false;
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar('Error',
          'Location permissions are permanently denied, we cannot request permissions.',
          backgroundColor: VoidColors.primary,
          colorText: VoidColors.whiteColor,
          snackPosition: SnackPosition.BOTTOM);
      isLoading.value = false;
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    latitude.value = position.latitude;
    longitude.value = position.longitude;
    isLoading.value = false;
  }

  void connectWebSocket() {
    final channel = WebSocketChannel.connect(
      Uri.parse('wss://meet-around-apis-production.up.railway.app/ws'),
    );

    channel.sink.add(jsonEncode({
      "userId": signInController.userId,
      "latitude": latitude.value.toString(),
      "longitude": longitude.value.toString()
    }));

    channel.stream.listen((message) {
      webSocketResponse.value = message;
      print('WebSocket Response: $message');
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
}
