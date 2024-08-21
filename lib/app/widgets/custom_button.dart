import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/constraints/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onPressed,
    this.text,
    this.color,
    this.width,
    this.textColor,
    this.borderRadius,
    this.height,
    this.child,
  });

  final VoidCallback? onPressed;
  final String? text;
  final Color? color;
  final double? width;
  final Color? textColor;
  final double? borderRadius;
  final double? height;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? Get.width - 30.w,
      height: height ?? 52.h,
      child: ElevatedButton(
        style: ButtonStyle(
          fixedSize: WidgetStatePropertyAll<Size>(
            Size(Get.width, 52.h),
          ),
          backgroundColor:
              WidgetStateProperty.all<Color>(color ?? VoidColors.secondary),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 13.r),
            ),
          ),
        ),
        onPressed: onPressed,
        child: child ??
            Text(
              text ?? ' ',
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
                color: textColor ?? VoidColors.whiteColor,
              ),
            ),
      ),
    );
  }
}

class CustomButtonWithLoader extends StatelessWidget {
  const CustomButtonWithLoader({
    super.key,

    // this.color,
    this.width,
    this.borderRadius,
    this.height,
  });

  // final Color? color;
  final double? width;

  final double? borderRadius;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? Get.width - 30.w,
      height: height ?? 52.h,
      child: ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
            fixedSize: WidgetStatePropertyAll<Size>(
              Size(Get.width, 52.h),
            ),
            backgroundColor:
                WidgetStateProperty.all<Color>(VoidColors.secondary),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 13.r),
              ),
            ),
          ),
          child: Center(
              child: CircularProgressIndicator(
            color: VoidColors.whiteColor,
          ))),
    );
  }
}
