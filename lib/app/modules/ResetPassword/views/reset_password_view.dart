import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scratch_project/app/modules/signIn/controllers/sign_in_controller.dart';
import 'package:scratch_project/app/modules/signUp/views/signup_form_screen_view.dart';
import 'package:scratch_project/app/utils/constraints/colors.dart';
import 'package:scratch_project/app/utils/constraints/image_strings.dart';
import 'package:scratch_project/app/utils/constraints/text_strings.dart';
import 'package:scratch_project/app/widgets/custom_button.dart';
import 'package:scratch_project/app/widgets/custom_textform_field.dart';

import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  const ResetPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      final ResetPasswordController resetPasswordController =Get.put(ResetPasswordController());
       final SignInController _controller = Get.find<SignInController>();
    return Scaffold(
      appBar: AppBar(
title:  Text('Reset Your Password',style: GoogleFonts.poppins(
  fontSize: 16.sp,
  fontWeight:FontWeight.w500,
  color: VoidColors.blackColor,
)),
        centerTitle: true,
      ),
      body:SingleChildScrollView(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.h,),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 24.w),
            child: Text('Current Password',style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight:FontWeight.w500,
              color: VoidColors.lightGrey3,
            )),
          ),
SizedBox(height: 10.h,),
CustomTextFormField(
  controller: resetPasswordController.currentPasssword,
  obscureText: true,
  suffix: SvgPicture.asset("assets/icons/eye.svg",
  height: 24.h,
  width: 24.w,
  colorFilter: ColorFilter.mode(VoidColors.lightGrey4, BlendMode.srcIn),)
),
SizedBox(height: 10.h,),

Padding(
            padding:  EdgeInsets.symmetric(horizontal: 24.w),
            child: Text('Password',style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight:FontWeight.w500,
              color: VoidColors.lightGrey3,
            )),
          ),
SizedBox(height: 10.h,),
CustomTextFormField(
  obscureText: false,
  controller: resetPasswordController.password,
  
),
SizedBox(height: 10.h,),

Padding(
            padding:  EdgeInsets.symmetric(horizontal: 24.w),
            child: Text('Confirm New Password',style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight:FontWeight.w500,
              color: VoidColors.lightGrey3,
            )),
          ),
SizedBox(height: 10.h,),
CustomTextFormField(
  controller: resetPasswordController.cPassword,
  obscureText: false,
  
),

 SizedBox(height: 100.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
              child: Obx(() {
                return _controller.loading.value
                    ? CustomButtonWithLoader(
                        
                        borderRadius: 24.r,
                      )
                    : CustomButton(
                        text: VoidTexts.signIn,
                        onPressed: () {
                          _controller.signIn(
                            _controller.emailController.text,
                            _controller.passwordController.text,
                          );
                        },
                        borderRadius: 24.r,
                      );
              }),
            ),
            SizedBox(height: 30.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      height: 0.5,
                      color: VoidColors.darkGrey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Text(
                      'Or Continue with',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: VoidColors.darkGrey,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 0.5,
                      color: VoidColors.darkGrey,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 48.h,
              margin: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 15.0.h),
              width: double.infinity,
              decoration: BoxDecoration(
                color: VoidColors.lightGrey,
                borderRadius: BorderRadius.circular(5.0.r),
              ),
              child: Center(
                child: Image.asset(VoidImages.googleIcon,
                  height: 32.h, width: 32.w),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  VoidTexts.noAccount,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 12.spMax,
                    color: VoidColors.darkGrey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(()=>SignupFormScreenView());
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 5.0.h),
                    child: Text(
                      VoidTexts.signUp,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 12.spMax,
                        decoration: TextDecoration.underline,
                        color: VoidColors.blueColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ).marginOnly(bottom: 30.0.h),
        
        )
      );
  
  }
}
