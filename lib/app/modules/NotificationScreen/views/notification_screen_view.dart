import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scratch_project/app/utils/constants.dart';
import 'package:scratch_project/app/utils/constraints/colors.dart';

import '../controllers/notification_screen_controller.dart';

class NotificationScreenView extends GetView<NotificationScreenController> {
  const NotificationScreenView({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                height: 32.h,
                width: 32.w,
                child: Center(
                  child: SvgPicture.asset(
                    "assets/icons/left_arrow.svg",
                    height: 16.h,
                    width: 8.w,
                    colorFilter: ColorFilter.mode(VoidColors.blackColor, BlendMode.srcIn),
                  ),
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              'Notifications',
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: VoidColors.blackColor,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(24.h),
        child: SizedBox(
          // height: 500.h,
          child: ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:  EdgeInsets.only(bottom: 10.h),
                child: Container(
                  width: double.infinity,
                 // height: 90.h,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(notificationImg[index], height: 40.h, width: 40.w),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: VoidColors.grey4, // Customize the color as needed
                                width: 2.0, // Customize the width as needed
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 15.w, bottom: 3.h,top: 3.h,),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        notifications[index],
                                        style: GoogleFonts.poppins(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                          color: VoidColors.blackColor,
                                        ),
                                        overflow: TextOverflow.visible, // Allow text to wrap
                                      ),
                                    ),
                                    SizedBox(width: 3.w,),
                                    Text(
                                      notficationTime[index],
                                      style: GoogleFonts.poppins(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w400,
                                        color: VoidColors.grey2,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.h,),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 8.h),
                                  child: Container(
                                    height: 28.h,
                                    width: 95.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50.r),
                                      border: Border.all(color: VoidColors.blackColor),
                                    ),
                                    child: Center(
                                      child: Text(
                                        chat[index],
                                        style: GoogleFonts.poppins(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w700,
                                          color: VoidColors.blackColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
