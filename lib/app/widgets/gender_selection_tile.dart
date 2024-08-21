import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scratch_project/app/utils/constraints/colors.dart';

class GenderSelectionTile extends StatelessWidget {
  final String title;
  final String iconPath; // Asset path for the icon
  final bool isSelected;
  final VoidCallback onTap;

  const GenderSelectionTile({super.key,
    required this.title,
    required this.iconPath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56.h,
        margin: EdgeInsets.symmetric(horizontal: 21.0.w, vertical: 3.0.h),
        decoration: BoxDecoration(
          color: isSelected ? VoidColors.primary.withOpacity(0.2) : VoidColors.lightGrey,
          borderRadius: BorderRadius.circular(16.0.r),

        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0.w),
              child: Image.asset(
                iconPath,
                width: 22,
                height: 22,
              ),
            ),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: VoidColors.blackColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Icon(
                isSelected
                    ? Icons.radio_button_on
                    : Icons.radio_button_off_sharp,
                color: isSelected ? VoidColors.blackColor: VoidColors.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}