import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scratch_project/app/modules/ProfileScreen/controllers/profile_screen_controller.dart';
import 'package:scratch_project/app/utils/constants.dart';
import 'package:scratch_project/app/utils/constraints/colors.dart';
import 'package:scratch_project/app/widgets/custom_switch.dart';

import '../controllers/settings_screen_controller.dart';

class SettingsScreenView extends GetView<SettingsScreenController> {
  const SettingsScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileScreenController profileScreenController = Get.put(ProfileScreenController());
    SettingsScreenController controller = Get.put(SettingsScreenController());

 
    

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
              'Settings',
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
          height: 500.h,
          child: ListView.builder(
            itemCount: 8,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  if (index == 2) {
                    profileScreenController.selectedIndex(1);
                  }
                  Get.toNamed(settingRoutes[index]);
                },
                child: Container(
                  height: 50.h,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 24.h,
                            width: 16.88.w,
                            child: SvgPicture.asset(
                              settingIcons[index],
                              colorFilter: ColorFilter.mode(VoidColors.blackColor, BlendMode.srcIn),
                            ),
                          ),
                          SizedBox(width: 15.w),
                          Text(
                            settingOptions[index],
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w400,
                              fontSize: 18.sp,
                              color: VoidColors.blackColor,
                            ),
                          ),
                        ],
                      ),
                      if (index == 1)
                        Obx(() => CustomSwitch(
                              valueFalse: VoidColors.primary,
                              valueTrue: VoidColors.secondary,
                              value: controller.switchValue.value,
                              onChanged: (value) {
                                controller.toggleSwitch(value);
                              },
                              scale: 0.8,
                            ))
                      else
                        SizedBox(
                          height: 12.h,
                          width: 7.41.w,
                          child: SvgPicture.asset(
                            "assets/icons/righta.svg",
                            colorFilter: ColorFilter.mode(VoidColors.blackColor, BlendMode.srcIn),
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
