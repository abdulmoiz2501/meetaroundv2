import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
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

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAll(()=>SecondSplashView());
    });

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
            padding: EdgeInsets.symmetric(vertical: 35.0.h, horizontal: 59.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 270.h,
                    width: 270.w,
                    child: Image.asset(VoidImages.splashLogo),
                  ),
                ),
                Text(
                  VoidTexts.splashTitle,
                  style: GoogleFonts.poppins(
                      fontSize: 30.spMax,
                      color: VoidColors.whiteColor,
                      fontWeight: FontWeight.w600
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

