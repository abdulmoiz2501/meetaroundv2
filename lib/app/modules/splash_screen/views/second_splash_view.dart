import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scratch_project/app/modules/onBoarding/views/onboarding_view.dart';
import 'package:scratch_project/app/routes/app_pages.dart';

import '../../../utils/constraints/colors.dart';
import '../../../utils/constraints/image_strings.dart';
import '../../../utils/constraints/text_strings.dart';
import '../../../widgets/custom_button.dart';

class SecondSplashView extends GetView {
  const SecondSplashView({super.key});
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
            padding: EdgeInsets.symmetric(vertical: 35.0.h, horizontal: 20.0.w),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 118.h,
                        width: 118.w,
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
                CustomButton(
                  text: VoidTexts.getStarted,
                  color: VoidColors.whiteColor,
                  textColor: VoidColors.blackColor,
                  borderRadius: 24.r,
                  onPressed: () {
                    Get.toNamed(Routes.ONBOARDING);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
