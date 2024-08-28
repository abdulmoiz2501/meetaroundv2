import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scratch_project/app/modules/bottomNavBar/views/bottom_nav_bar_view.dart';

void showJammingRequestDialog({
  required String name,
  required VoidCallback onAccept,
  required VoidCallback onReject,
}) {
  Get.defaultDialog(
    title: "🎸 Jamming Request",
    titleStyle: const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    middleText: "User $name wants to jam with you. Do you want to accept?",
    middleTextStyle: const TextStyle(
      fontSize: 18,
      color: Colors.black54,
    ),
    backgroundColor: Colors.white,
    radius: 10.0,
    barrierDismissible: true,
    contentPadding: EdgeInsets.all(20.0),
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
              backgroundColor: Colors.redAccent,
              padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.r),
              ),
            ),
            child: const Text(
              "Reject",
              style: TextStyle(
                fontSize: 18,
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
              backgroundColor: Color(0xFFFF69B4),
              padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.r),
              ),
            ),
            child: const Text(
              "Accept",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ],
      ),
    ],
  );
}
