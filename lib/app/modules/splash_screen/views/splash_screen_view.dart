import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scratch_project/app/modules/splash_screen/views/second_splash_view.dart';
import 'package:scratch_project/app/utils/constraints/colors.dart';
import 'package:scratch_project/app/utils/constraints/image_strings.dart';
import 'package:scratch_project/app/utils/constraints/text_strings.dart';

import '../../../routes/app_pages.dart';
import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  final box = GetStorage();


  @override
  void initState() {

    Future.delayed(const Duration(seconds: 2), () {
      bool? isSecondSplashShown = box.read('isSecondSplashShown');

      if (isSecondSplashShown == null || !isSecondSplashShown) {
        Get.offAllNamed(Routes.SECOND_SPLASH);
        box.write('isSecondSplashShown', true);
      } else {
        final storedToken = box.read('token');
        storedToken != null
            ? Get.offAllNamed(Routes.BOTTOM_NAV_BAR)
            : Get.offAllNamed(Routes.SIGN_IN);
      }
    });
    // Future.delayed(const Duration(seconds: 2), () {
    //   final storedToken = box.read('token');
    //   storedToken != null ? Get.toNamed(Routes.BOTTOM_NAV_BAR) : Get.toNamed(Routes.SECOND_SPLASH);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [VoidColors.primary, VoidColors.secondary],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            // stops: [0.6, 1],
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 192.h,
                  width: 203.w,
                  child: Image.asset(VoidImages.appLogo),
                ),
                SizedBox(height: 10.0.h),
                Text(
                  VoidTexts.danceAround,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                      fontSize: 28.sp,
                      color: VoidColors.whiteColor,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
