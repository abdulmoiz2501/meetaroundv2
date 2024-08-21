import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scratch_project/app/modules/signIn/views/sign_in_view.dart';
import 'package:scratch_project/app/utils/constraints/image_strings.dart';
import '../../../utils/constraints/colors.dart';
import '../../../utils/constraints/text_strings.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textform_field.dart';
import '../controllers/sign_up_controller.dart';
import 'TermsAndConditionsView.dart';

class SignupFormScreenView extends GetView<SignUpController> {
  SignupFormScreenView({super.key});
  final signUpController = Get.put(SignUpController());
  final _formKey = GlobalKey<FormState>();

  void _showTermsAndConditions() {
    Get.to(() => TermsAndConditionsView(onAccept: () {
      signUpController.accept.value = true;
      Get.back();  // Close the terms and conditions page
    }));
  }

  void _showErrorSnackbar(String message) {
    Get.snackbar(
      'Oops!!!',
      message,
      backgroundColor: Colors.red, // Set the background color to red
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VoidColors.whiteColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50.0.h),
                Image.asset(
                  VoidImages.secSplash,
                  height: 100.h,
                  width: 100.w,
                ),
                SizedBox(height: 20.0.h),
                Text(
                  VoidTexts.signUpTitle,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 24.sp,
                    color: VoidColors.blackColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 30.0.h),
                CustomTextFormField(
                  obscureText: false,
                  controller: signUpController.nameController,
                  hint: 'Name',
                  prefix: Icon(
                    Icons.person_outline_rounded,
                    size: 24.sp,
                    color: VoidColors.darkGrey,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      _showErrorSnackbar('Oops! Name not found');
                      return '';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 5.0.h),
                CustomTextFormField(
                  obscureText: false,
                  controller: signUpController.emailController,
                  hint: 'Email',
                  prefix: Icon(
                    Icons.email_outlined,
                    size: 24.sp,
                    color: VoidColors.darkGrey,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      _showErrorSnackbar('Please enter your email');
                      return '';
                    } else if (value.contains(' ')) {
                      _showErrorSnackbar('Email should not contain spaces');
                      return '';
                    } else if (!value.endsWith('@gmail.com')) {
                      _showErrorSnackbar('Invalid email format');
                      return '';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 5.0.h),
                CustomTextFormField(
                  obscureText: true,
                  controller: signUpController.passwordController,
                  hint: 'Password',
                  prefix: Icon(
                    Icons.lock_outline,
                    size: 24.sp,
                    color: VoidColors.darkGrey,
                  ),
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      _showErrorSnackbar('Please enter your password');
                      return '';
                    } else if (value.length < 6) {
                      _showErrorSnackbar('Password must be at least 6 characters');
                      return '';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 5.0.h),
                CustomTextFormField(
                  obscureText: true,
                  controller: signUpController.confirmPassController,
                  hint: 'Re-enter Password',
                  prefix: Icon(
                    Icons.lock_outline,
                    size: 24.sp,
                    color: VoidColors.darkGrey,
                  ),
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      _showErrorSnackbar('Please confirm your password');
                      return '';
                    } else if (value != signUpController.passwordController.text) {
                      _showErrorSnackbar('Passwords do not match');
                      return '';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  child: CustomButton(
                    text: 'Sign up',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (signUpController.accept.value) {
                          signUpController.emailVerify();
                        } else {
                          _showErrorSnackbar('Accept Terms and Conditions');
                        }
                      }
                    },
                    borderRadius: 24.r,
                  ),
                ),
                SizedBox(height: 15.0.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Obx(
                            () => Checkbox(
                          value: signUpController.accept.value,
                          activeColor: VoidColors.secondary,
                          onChanged: (value) {
                            signUpController.toggleAccept();
                          },
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: _showTermsAndConditions,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                VoidTexts.accept,
                                textAlign: TextAlign.start,
                                style: GoogleFonts.poppins(
                                  fontSize: 12.sp,
                                  color: VoidColors.blackColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(width: 4.0.w),
                              Text(
                                VoidTexts.termsAndConditions,
                                textAlign: TextAlign.start,
                                style: GoogleFonts.poppins(
                                  fontSize: 12.sp,
                                  decoration: TextDecoration.underline,
                                  color: VoidColors.blueColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.0.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        height: 0.5,
                        color: VoidColors.darkGrey,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.0.w),
                      child: Text(
                        'Or continue with',
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
                SizedBox(height: 15.0.h),
                Container(
                  height: 48.h,
                  margin: EdgeInsets.symmetric(horizontal: 20.0.w),
                  decoration: BoxDecoration(
                    color: VoidColors.lightGrey,
                    borderRadius: BorderRadius.circular(5.0.r),
                  ),
                  child: Center(
                    child: Image.asset(
                      VoidImages.googleIcon,
                      height: 32.h,
                      width: 32.w,
                    ),
                  ),
                ),
                SizedBox(height: 25.0.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      VoidTexts.already,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        color: VoidColors.darkGrey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => SignInView());
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                        child: Text(
                          VoidTexts.signIn,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 12.sp,
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
            ),
          ),
        ),
      ),
    );
  }
}
