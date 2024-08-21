import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scratch_project/app/modules/ProfileScreen/controllers/profile_screen_controller.dart';
import 'package:scratch_project/app/routes/app_pages.dart';
import 'package:scratch_project/app/utils/constants.dart';
import 'package:scratch_project/app/utils/constraints/text_strings.dart';
import 'package:scratch_project/app/widgets/popup.dart';
import '../../../utils/constraints/colors.dart';
import '../../../utils/constraints/image_strings.dart';
import '../../../widgets/homeHeaderWidget.dart';

class SuggestedPeopleView extends GetView {
  SuggestedPeopleView({super.key});

  // final List<Map<String, String>> itemsList = List.generate(
  //   10,
  //       (index) => {
  //     'image': VoidImages.testImg,
  //     'name': 'David $index',
  //   },
  // );

  @override
  Widget build(BuildContext context) {
    final ProfileScreenController controller =
        Get.put(ProfileScreenController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Container(
              height: 32.h,
              width: 32.w,
              child: Center(
                child: SvgPicture.asset(
                  "assets/icons/left_arrow.svg",
                  height: 16.h,
                  width: 8.w,
                  colorFilter:
                      ColorFilter.mode(VoidColors.blackColor, BlendMode.srcIn),
                ),
              ),
            ),
            Text(
              'MeetAround',
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: VoidColors.blackColor,
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          Container(
            height: 32.h,
            width: 32.w,
            child: Center(
              child: SvgPicture.asset(
                "assets/icons/1.svg",
                height: 16.h,
                width: 8.w,
                colorFilter:
                    ColorFilter.mode(VoidColors.secondary, BlendMode.srcIn),
              ),
            ),
          ),
          Container(
            height: 32.h,
            width: 32.w,
            child: Center(
              child: SvgPicture.asset(
                "assets/icons/2.svg",
                height: 16.h,
                width: 8.w,
                colorFilter:
                    ColorFilter.mode(VoidColors.secondary, BlendMode.srcIn),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: GestureDetector(
              onTap: () {
                Get.toNamed(Routes.SETTINGS_SCREEN);
              },
              child: Container(
                height: 32.h,
                width: 32.w,
                child: Center(
                  child: SvgPicture.asset(
                    "assets/icons/3.svg",
                    height: 16.h,
                    width: 8.w,
                    colorFilter:
                        ColorFilter.mode(VoidColors.secondary, BlendMode.srcIn),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(24.h),
        child: Builder(builder: (context) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 85.w,
                      ),
                      Container(
                        height: 90.h,
                        width: 90.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100.r),
                          child: Image.asset(
                            "assets/images/profile.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 40.w,
                      ),
                      GestureDetector(
                          onTap: () {
                            showCustomPopup(
                                height: 239.h,
                                context: context,
                                headingText: 'Block Jessica?',
                                subText: 'This action cannot be undone.',
                                subText2: "Are you sure you want to proceed?",
                                buttonText: 'Block',
                                belowButtonText: 'Cancel',
                                onButtonPressed: () {
                                  Get.back();
                                  showCustomPopup(
                                      height: 300.h,
                                      context: context,
                                      headingText: 'Block Jessica?',
                                      subText:
                                          'Please send us an email at ..........@gmail.com letting us know the reason why do you want to block @jess_56?',
                                      buttonText: 'Send Email',
                                      belowButtonText: 'Cancel',
                                      onButtonPressed: () {
                                        Get.back();
                                        showCustomBottomSheet(
                                            context: context,
                                            headingText: 'Block Jessica?',
                                            subText: 'Why do you want to block jessica ?',
                                            subText2: "Pretending to be someone else?",
                                            
                                            buttonText: 'Send Email',
                                           // belowButtonText: 'Cancel',
                                            onButtonPressed: () {},
                                            
                                           subText3: 'Pretending to be someone else?', subText4: 'Inappropriate content', subText5: 'They may be under 13', subText6: 'Someone else', smallSubText: 'Your block is anonymous.  User will not get a notification if you block him . ');
                                      },
                                      onBelowButtonPressed: () {
                                        Get.back();
                                      });
                                },
                                onBelowButtonPressed: () {
                                  Get.back();
                                });
                          },
                          child: SvgPicture.asset(
                            "assets/icons/p_.svg",
                            width: 24.w,
                            height: 24.h,
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/coin.png',
                      height: 20.r,
                      width: 20.r,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      "10",
                      style: GoogleFonts.manrope(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: VoidColors.blackColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Jessica Sympson",
                            style: GoogleFonts.manrope(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w400,
                              color: VoidColors.blackColor,
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Container(
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/female.svg",
                                  height: 12.h,
                                  width: 12.w,
                                ),
                                Text(
                                  "Female",
                                  style: GoogleFonts.manrope(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w400,
                                    color: VoidColors.blackColor,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                "- So be careful, Grumpy Lina",
                                style: GoogleFonts.manrope(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: VoidColors.blackColor,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "36",
                                  style: GoogleFonts.manrope(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                    color: VoidColors.blackColor,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(
                                  "online",
                                  style: GoogleFonts.manrope(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                    color: VoidColors.green,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                Container(
                  height: 278.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: Image.asset(
                        "assets/images/girl.png",
                        fit: BoxFit.cover,
                      )),
                ),
                SizedBox(
                  height: 40.h,
                ),
                Text(
                  "Music Genres:",
                  style: GoogleFonts.manrope(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: VoidColors.blackColor,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: Wrap(
                    spacing: 10.w,
                    runSpacing: 10.h,
                    children: List.generate(musicGeners2.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          controller.toggleMusicGenre(index);
                        },
                        child: Obx(() {
                          bool isSelected =
                              controller.selectedMusicGenres.contains(index);
                          return Container(
                            padding: EdgeInsets.only(
                                left: 10.w, right: 10.w, top: 5.5.h),
                            height: 28.h,
                            width: 62.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.r),
                              color: isSelected
                                  ? VoidColors.secondary
                                  : VoidColors.whiteColor,
                              border: Border.all(
                                color: VoidColors.blackColor,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                musicGeners2[index],
                                style: GoogleFonts.poppins(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w400,
                                  color: isSelected
                                      ? VoidColors.whiteColor
                                      : VoidColors.blackColor,
                                ),
                              ),
                            ),
                          );
                        }),
                      );
                    }),
                  ),
                ),
                SizedBox(
                  height: 100.h,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
