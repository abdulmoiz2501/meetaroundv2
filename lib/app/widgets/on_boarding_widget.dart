import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scratch_project/app/widgets/custom_button.dart';
import '../utils/constraints/colors.dart';

class OnBoardingWidget extends StatelessWidget {
  final String imagePath;
  final String text;
  //final String? subTitle;
  final double? titleSize;
  final FontWeight? fontWeight;
  final String buttonText;
  final double? fontSize;
  final VoidCallback onButtonPressed;
  final VoidCallback? onTap;
  final bool showNextButton;
  final bool isCenteredText;

  const OnBoardingWidget({
    super.key,
    required this.imagePath,
    required this.text,
    required this.buttonText,
    required this.onButtonPressed,
    this.showNextButton = false,
    this.isCenteredText = false,
   // this.subTitle,
    this.fontSize,
    this.titleSize,
    this.fontWeight,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 60.h, right: 25.0.w, left: 25.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: showNextButton ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
        children: [
          if (showNextButton)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: onTap,
                  child: Text(
                    "Skip",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 15.spMax,
                      color: VoidColors.whiteColor,
                    ),
                  ),
                ),
              ],
            ),
          SizedBox(height: 70.h,),
          Expanded(
            child: Image.asset(imagePath),
          ),
          SizedBox(height: 100.h,),
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: titleSize ?? 15.spMax,
                color: VoidColors.whiteColor,
                fontWeight: fontWeight ?? FontWeight.w400,
              ),
            ),
          ),
          
         
        ],
      ),
    );
  }
}
