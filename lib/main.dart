import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:scratch_project/app/controllers/user_controller.dart';
import 'package:scratch_project/app/models/user_model.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // if (WebView.platform == null) {
  //   WebView.platform = SurfaceAndroidWebView();
  // }
  // Initialize GetStorage
  await GetStorage.init();
  final box = GetStorage();
  final storedToken = box.read('token');
  final user = box.read('user');
  if (user != null) {
    final UserController userController =
        Get.put(UserController(), permanent: true);
    print('This is the user ${user.runtimeType}');
    userController.user.value = UserModel.fromJson(user);
    print('this is the user id ${userController.user.value.id}');
    userController.token.value = storedToken;
    print('This is the user token ${userController.token.value}');
  }

  runApp(
    ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          title: "Application",
          debugShowCheckedModeBanner: false,
          // initialRoute: AppPages.SPLASH_SCREEN,
          initialRoute: storedToken != null
              ? Routes.BOTTOM_NAV_BAR
              : AppPages.SPLASH_SCREEN,
          getPages: AppPages.routes,
        );
      },
    ),
  );
}
