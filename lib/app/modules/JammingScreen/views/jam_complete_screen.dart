import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scratch_project/app/modules/bottomNavBar/views/bottom_nav_bar_view.dart';
import 'package:scratch_project/app/utils/constraints/colors.dart'; // Assuming you're using GetX for navigation

class JamCompleteScreen extends StatefulWidget {
  const JamCompleteScreen({super.key});

  @override
  _JamCompleteScreenState createState() => _JamCompleteScreenState();
}

class _JamCompleteScreenState extends State<JamCompleteScreen> {
  @override
  void initState() {
    super.initState();
    // Start the timer to navigate after 3 seconds
    Timer(Duration(seconds: 3), () {
      Get.offAll(() => BottomNavBarView());
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [VoidColors.primary, VoidColors.secondary],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 35.0.h, horizontal: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100.h,
                    width: 100.w,
                    child: Lottie.asset('assets/icons/coin-animation.json'),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    textAlign: TextAlign.center,
                    'Congratulations! You have successfully completed the jam and earned a coin.',
                    style: GoogleFonts.poppins(
                        fontSize: 18.spMax,
                        color: Colors.white, // Replace with your desired color
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
