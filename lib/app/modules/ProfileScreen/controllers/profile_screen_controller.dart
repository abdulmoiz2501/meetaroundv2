import 'dart:convert';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:scratch_project/app/controllers/user_controller.dart';
import 'package:scratch_project/app/models/user_model.dart';
import 'package:scratch_project/app/utils/constants.dart';

class ProfileScreenController extends GetxController {
  var selectedIndex = 0.obs;
  var isOnline = true.obs;
  var selectedMusicGenres = <String>[].obs;
  final RxString imageFromServer = ''.obs;
  var pickedImage = Rxn<File>();
  var gender = 3.obs;
  final UserController userController = Get.find<UserController>();
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initializeValues();
  }

  void initializeValues() {
    selectedMusicGenres.clear();
    userController.user.value.interests.forEach((element) {
      selectedMusicGenres.add(element);
    });
    userController.user.value.status == true ? isOnline.value = true : false;
    if (userController.user.value.gender == "Male") {
      gender.value = 0;
    } else if (userController.user.value.gender == 'Female') {
      gender.value = 1;
    } else {
      gender.value = 2;
    }
    imageFromServer.value = userController.user.value.profilePicture;
  }

  void selectIndex(int index) {
    selectedIndex.value = index;
  }

  void toggleMusicGenre(int index) {
    if (selectedMusicGenres.contains(musicGeneres[index])) {
      selectedMusicGenres.remove(musicGeneres[index]);
    } else {
      selectedMusicGenres.add(musicGeneres[index]);
    }
  }

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      pickedImage.value = File(pickedFile.path);
    }
  }

  toggleOnlline() {
    isOnline.value = !isOnline.value;
  }

  // Initialize selectedGender with a default value (e.g., 0 for the first item)
  var selectedGender = 0.obs;

  // Method to update the selected gender
  void selectGender(int index) {
    selectedGender.value = index;
  }

  Future<void> editProfile() async {
    isLoading.value = true;
    try {
      final url = '$baseUrl/api/user/editProfile';
      final userId = userController.user.value.id.toString();
      final interests = selectedMusicGenres.join(',');

      final gender = selectedGender.value == 0
          ? 'Male'
          : selectedGender.value == 1
              ? 'Female'
              : 'Non Binary';
      final status = isOnline.value.toString();

      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers['Authorization'] = 'Bearer ${userController.token.value}';

      request.fields['userId'] = userId;

      request.fields['gender'] = gender;
      request.fields['status'] = status;
      request.fields['interests'] = interests;
      print('URL: $url');
      print('UserID: $userId');

      print('Gender: $gender');
      print('Status: $status');
      print('Interests: $interests');

      if (pickedImage.value != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'profile_picture',
          pickedImage.value!.path,
        ));
      }

      var response = await request.send();
      var responseData = await http.Response.fromStream(response);
      var responseJson = json.decode(responseData.body);
      print(responseJson);

      isLoading.value = false;

      switch (responseJson['responseCode']) {
        case '4000':
          print('In this case');
          Get.snackbar('Success', 'Operation Successful.');
          userController.user.value = UserModel.fromJson(responseJson['data']);
          break;

        case '3004':
          Get.snackbar('Error', 'File uploading failed');
          break;
        case '3005':
          Get.snackbar('Error', 'Error while saving User');
          break;
        case '401':
          Get.snackbar('Error', 'Unauthorized user');
          break;
        default:
          Get.snackbar('Error', 'Failed to update profile');
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
      Get.snackbar('Error', e.toString());
    }
  }
}
