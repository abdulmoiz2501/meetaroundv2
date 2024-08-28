import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/constraints/colors.dart';
import '../../../widgets/popup.dart';
import '../../../controllers/user_controller.dart';
import '../../../models/user_model.dart';

class SuggestedPeopleView extends StatelessWidget {
  final String uid;
  SuggestedPeopleView(this.uid, {super.key});

  Future<UserModel?> _fetchUser(
      int userId, UserController userController) async {
    return await userController.fetchUserById(userId);
  }

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: SizedBox(
                height: 32.h,
                width: 32.w,
                child: Center(
                  child: SvgPicture.asset(
                    "assets/icons/left_arrow.svg",
                    height: 16.h,
                    width: 8.w,
                    colorFilter: ColorFilter.mode(
                        VoidColors.blackColor, BlendMode.srcIn),
                  ),
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
          /*Container(
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
                Get.toNamed('/settings'); // Update your routes accordingly
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
          ),*/
        ],
      ),
      body: FutureBuilder<UserModel?>(
        future: _fetchUser(int.parse(uid), userController),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: VoidColors.secondary,
              ),
            );
          }

          if (!snapshot.hasData) {
            return Center(
              child: Text(
                'Failed to load user data',
                style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: VoidColors.blackColor,
                ),
              ),
            );
          }

          final user = snapshot.data!;
          final String gender = user.gender.toLowerCase();
          final String genderIcon = gender == 'male'
              ? 'assets/icons/male.svg'
              : gender == 'female'
                  ? 'assets/icons/female.svg'
                  : 'assets/icons/nogender.svg';
          final int age =
              DateTime.now().year - int.parse(user.birthdate.split('/').last);

          return Padding(
            padding: EdgeInsets.all(24.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 40.w),
                        Container(
                          height: 90.h,
                          width: 90.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            radius: 40.0.r,
                            backgroundImage: user.profilePicture.isNotEmpty
                                ? NetworkImage(user.profilePicture)
                                : AssetImage("assets/images/profile.png")
                                    as ImageProvider,
                          ),
                        ),
                        SizedBox(width: 40.w),
                        /*GestureDetector(
                          onTap: () {
                            showCustomPopup(
                              height: 239.h,
                              context: context,
                              headingText: 'Block ${user.name}?',
                              subText: 'This action cannot be undone.',
                              subText2: "Are you sure you want to proceed?",
                              buttonText: 'Block',
                              belowButtonText: 'Cancel',
                              onButtonPressed: () {
                                Get.back();
                                showCustomPopup(
                                  height: 300.h,
                                  context: context,
                                  headingText: 'Block ${user.name}?',
                                  subText:
                                      'Please send us an email at ..........@gmail.com letting us know the reason why you want to block @jess_56?',
                                  buttonText: 'Send Email',
                                  belowButtonText: 'Cancel',
                                  onButtonPressed: () {
                                    Get.back();
                                    showCustomBottomSheet(
                                      context: context,
                                      headingText: 'Block ${user.name}?',
                                      subText:
                                          'Why do you want to block ${user.name}?',
                                      subText2:
                                          "Pretending to be someone else?",
                                      buttonText: 'Send Email',
                                      onButtonPressed: () {},
                                      subText3:
                                          'Pretending to be someone else?',
                                      subText4: 'Inappropriate content',
                                      subText5: 'They may be under 13',
                                      subText6: 'Someone else',
                                      smallSubText:
                                          'Your block is anonymous. The user will not get a notification if you block them.',
                                    );
                                  },
                                  onBelowButtonPressed: () {
                                    Get.back();
                                  },
                                );
                              },
                              onBelowButtonPressed: () {
                                Get.back();
                              },
                            );
                          },
                          child: SvgPicture.asset(
                            "assets/icons/p_.svg",
                            width: 24.w,
                            height: 24.h,
                          ),
                        ),*/
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/coin.png',
                        height: 20.r,
                        width: 20.r,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        user.coins?.toString() ?? "0",
                        style: GoogleFonts.manrope(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: VoidColors.blackColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              user.name,
                              style: GoogleFonts.manrope(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w400,
                                color: VoidColors.blackColor,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Container(
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    genderIcon,
                                    height: 12.h,
                                    width: 12.w,
                                  ),
                                  SizedBox(width: 10.w),
                                  Text(
                                    gender.capitalizeFirst!,
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
/*                              Center(
                                child: Text(
                                  "- So be careful, Grumpy Lina",
                                  style: GoogleFonts.manrope(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: VoidColors.blackColor,
                                  ),
                                ),
                              ),*/
                              SizedBox(height: 10.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "$age",
                                    style: GoogleFonts.manrope(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                      color: VoidColors.blackColor,
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Text(
                                    user.status == true ? "online" : "offline",
                                    style: GoogleFonts.manrope(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w700,
                                      color: user.status == true
                                          ? VoidColors.green
                                          : VoidColors.blackColor,
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
                  SizedBox(height: 50.h),
                  Container(
                    height: 278.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: Image(
                        image: user.profilePicture.isNotEmpty
                            ? NetworkImage(user.profilePicture)
                            : AssetImage("assets/images/profile.png") as ImageProvider,
                        fit: BoxFit.cover,
                      ),

                    ),
                  ),
                  SizedBox(height: 40.h),
                  Text(
                    "Music Genres:",
                    style: GoogleFonts.manrope(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: VoidColors.blackColor,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.w),
                    child: Wrap(
                      spacing: 10.w,
                      runSpacing: 10.h,
                      children: List.generate(user.interests.length, (index) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 7.w,
                          ),
                          height: 28.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.r),
                            color: VoidColors.whiteColor,
                            border: Border.all(
                              color: VoidColors.blackColor,
                            ),
                          ),
                          child: Text(
                            user.interests[index],
                            style: GoogleFonts.poppins(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w400,
                              color: VoidColors.blackColor,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  SizedBox(height: 100.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
