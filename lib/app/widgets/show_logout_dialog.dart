import 'dart:ui';
//
// import 'package:get/get.dart';
// import 'package:scratch_project/app/utils/constraints/colors.dart';
//
// void showLogoutDialog({
//   required VoidCallback onAccept,
//   required VoidCallback onReject,
// }) {
//   Get.defaultDialog(
//     title: "",
//     middleText: "Are you sure you\nwant to logout?",
//     backgroundColor: VoidColors.whiteColor,
//     textCancel: "No",
//     textConfirm: "Yes",
//     onCancel: onReject,
//     onConfirm: onAccept,
//   );
// }

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scratch_project/app/modules/SettingsScreen/controllers/settings_screen_controller.dart';
import 'package:scratch_project/app/utils/constraints/colors.dart';

void showLogoutDialog({
  required VoidCallback onYes,
  required String title,
  required BuildContext context,

}) {
  final SettingsScreenController settingsScreenController = Get.put(SettingsScreenController());
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
          backgroundColor: Colors.white.withOpacity(0.8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: Padding(
            padding: EdgeInsets.symmetric(horizontal: 7.0.w, vertical: 10.0.h),
            child: SizedBox(
              height: 170.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    // 'Are you sure you\nwant to logout?',
                    title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                        color: VoidColors.secondary),
                  ),
                  SizedBox(height: 25.0.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SizedBox(
                          child: ElevatedButton(
                            onPressed: () {
                              Get.back();
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: VoidColors.secondary,
                                elevation: 0),
                            child: Text(
                              'No',
                              style: GoogleFonts.poppins(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                color: VoidColors.whiteColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 15.0.w,),
                      Expanded(
                        child: SizedBox(
                          child: Obx(() =>
                            ElevatedButton(
                              onPressed: onYes,
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: VoidColors.whiteColor,
                                  elevation: 0),
                              child: settingsScreenController.isLoading.value ? CircularProgressIndicator() : Text(
                                'Yes',
                                style: GoogleFonts.poppins(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: VoidColors.blackColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ));
    },
  );
}


