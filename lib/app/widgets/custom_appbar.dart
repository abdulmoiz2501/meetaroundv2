// custom_app_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scratch_project/app/modules/NotificationScreen/views/notification_screen_view.dart';
import 'package:scratch_project/app/modules/PastInterections/views/past_interections_view.dart';
import 'package:scratch_project/app/modules/SettingsScreen/views/settings_screen_view.dart';
import 'package:scratch_project/app/utils/constraints/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  CustomAppBar({Key? key})
      : preferredSize = Size.fromHeight(56.h),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      surfaceTintColor: VoidColors.whiteColor,
      backgroundColor: VoidColors.whiteColor,
      leading: Padding(
        padding: EdgeInsets.only(left: 8.w),
        child: SizedBox(
          height: 30.h,
          width: 30.w,
          child: Center(
            child: SvgPicture.asset("assets/icons/meet.svg"),
          ),
        ),
      ),
      title: Text(
        "MeetAround",
        style: GoogleFonts.poppins(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: VoidColors.blackColor,
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            // Action for the first icon
          },
          child: SizedBox(
            height: 30.h,
            width: 30.w,
            child: Center(
              child: SvgPicture.asset("assets/icons/frnd.svg"),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: PopupMenuButton<int>(
            icon: SizedBox(
              height: 30.h,
                width: 30.w,
              child: Center(
                child: SvgPicture.asset(
                  "assets/icons/more.svg",
                  colorFilter: ColorFilter.mode(VoidColors.secondary, BlendMode.srcIn),
                ),
              ),
            ),
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                value: 0,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/set.svg",
                      height: 24.h,
                      width: 24.w,
                        colorFilter: ColorFilter.mode(VoidColors.secondary, BlendMode.srcIn),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      "Settings",
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: VoidColors.secondary
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/ar.svg",
                      height: 24.h,
                      width: 24.w,
                        colorFilter: ColorFilter.mode(VoidColors.secondary, BlendMode.srcIn),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      "AR View",
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: VoidColors.secondary
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem<int>(
                value: 2,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/not.svg",
                      height: 24.h,
                      width: 24.w,
                      colorFilter: ColorFilter.mode(VoidColors.secondary, BlendMode.srcIn),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      "Notifications",
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: VoidColors.secondary
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem<int>(
                value: 3,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/msg.svg",
                        colorFilter: ColorFilter.mode(VoidColors.secondary, BlendMode.srcIn),
                      height: 24.h,
                      width: 24.w,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      "Interactions",
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: VoidColors.secondary
                      ),
                    ),
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              switch (value) {
                case 0:
                  Get.to(() => SettingsScreenView());
                  break;
                case 1:
                  // Navigate to AR View
                  break;
                case 2:
                  Get.to(() => NotificationScreenView());
                  break;
                case 3:
                  Get.to(() => PastInterectionsView());
                  break;
              }
            },
          ),
        ),
      ],
    );
  }
}
