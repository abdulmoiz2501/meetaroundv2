import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scratch_project/app/modules/signUp/views/signup_form_screen_view.dart';
import 'package:scratch_project/app/widgets/custom_button.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/constraints/colors.dart';
import '../../../utils/constraints/image_strings.dart';
import '../../../utils/constraints/text_strings.dart';
import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset(VoidImages.signUpFrame),
          Text(
            VoidTexts.signUpTitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                fontSize: 24.spMax,
                color: VoidColors.blackColor,
                fontWeight: FontWeight.w600
            ),
          ),
          Spacer(),
          CustomButton(
            text: 'Join now',
            onPressed: () {
              Get.toNamed(Routes.SIGNUP_FORMS);
            },
            borderRadius: 13.r,

          ),SizedBox(height: 15.h,),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                VoidTexts.already,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 12.spMax,
                    color: VoidColors.blackColor,
                    fontWeight: FontWeight.w400
                ),
              ),
              InkWell(
                onTap: () {
                     Get.toNamed(Routes.SIGN_IN);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 5.0.h),
                  child: Text(
                    VoidTexts.login,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: 12.spMax,
                        color: VoidColors.blackColor,
                        fontWeight: FontWeight.w800
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ).marginOnly(bottom: 40.0.h),
    );
  }
}
