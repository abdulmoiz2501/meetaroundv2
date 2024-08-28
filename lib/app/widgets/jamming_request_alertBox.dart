import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void showJammingRequestDialog({
  required String name,
  required VoidCallback onAccept,
  required VoidCallback onReject,
}) {
  Get.defaultDialog(
    title: "🎸 Jamming Request",
    titleStyle: TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    middleText: "User $name wants to jam with you. Do you want to accept?",
    middleTextStyle: TextStyle(
      fontSize: 14.sp,
      color: Colors.black54,
    ),
    backgroundColor: Colors.white,
    radius: 10.0.r,
    barrierDismissible: true,
    contentPadding: EdgeInsets.all(20.0.w),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {
              Get.back(); // Close the dialog
              onReject(); // Perform the rejection logic
            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(110.r, 50.r),
              maximumSize: Size(110.r, 50.r),
              backgroundColor: Colors.redAccent,
             // padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 15.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.r),
              ),
            ),
            child: Text(
              "Reject",
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.white,
              ),
            ),
          ),
          ElevatedButton(

            onPressed: () {
              Get.back(); // Close the dialog
              onAccept(); // Perform the acceptance logic
            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(110.r, 50.r),
              maximumSize: Size(110.r, 50.r),
              backgroundColor: Color(0xFFFF69B4),
              //padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 15.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.r),
              ),
            ),
            child: Text(
              "Accept",
              style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.white),
            ),
          ),
        ],
      ),
    ],
  );
}
