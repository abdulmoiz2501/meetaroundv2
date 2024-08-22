import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:scratch_project/app/utils/constraints/colors.dart';
import 'package:scratch_project/app/utils/constraints/text_strings.dart';


class JammingInProgressView extends StatefulWidget {
  final bool isSender;
  const JammingInProgressView({super.key, required this.isSender});

  @override
  State<JammingInProgressView> createState() => _JammingInProgressViewState();
}

class _JammingInProgressViewState extends State<JammingInProgressView> {

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
            padding: EdgeInsets.symmetric(vertical: 35.0.h, horizontal: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: SizedBox(
                    height:100 .h,
                    width: 100.w,
                    child: Lottie.asset('assets/icons/UQejRQZqHg.json'),
                  ),
                ),
                // 40.0.verticalSpace,
                Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    widget.isSender ? VoidTexts.pleaseWaitToAccept : VoidTexts.jammingInProgress,
                    style: GoogleFonts.poppins(
                        fontSize: 18.spMax,
                        color: VoidColors.whiteColor,
                        fontWeight: FontWeight.w500
                    ),
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

