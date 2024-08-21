import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scratch_project/app/controllers/user_controller.dart';
import 'package:scratch_project/app/utils/constants.dart';
import 'package:scratch_project/app/utils/constraints/colors.dart';
import 'package:scratch_project/app/utils/logging/logger.dart';
import 'package:scratch_project/app/widgets/custom_button.dart';
import '../controllers/profile_screen_controller.dart';

class ProfileScreenView extends GetView<ProfileScreenController> {
  const ProfileScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProfileScreenController controller =
    Get.put(ProfileScreenController());

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading:false,
          // leading: IconButton(
          //   splashRadius: 20.r,
          //   // icon: SvgPicture.asset(
          //   //   "assets/icons/left_arrow.svg",
          //   //   height: 16.h,
          //   //   width: 8.w,
          //   //   colorFilter:
          //   //   ColorFilter.mode(VoidColors.blackColor, BlendMode.srcIn),
          //   // ),
          //   // onPressed: () {
          //   //   Get.back();
          //   // },
          // ),
          title: Text(
            'Your Profile',
            style: GoogleFonts.poppins(
              fontSize: 24.sp,
              fontWeight: FontWeight.w500,
              color: VoidColors.blackColor,
            ),
          ),
          centerTitle: true,
          bottom: TabBar(
            tabs: List.generate(2, (index) {
              return Tab(
                child: Obx(() {
                  return Text(
                    profileTabs[index],
                    style: GoogleFonts.ibmPlexSans(
                      color: controller.selectedIndex.value == index
                          ? VoidColors.secondary
                          : VoidColors.grey3,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  );
                }),
              );
            }),
            onTap: (index) {
              controller.selectIndex(index);
            },
          ),
        ),
        body: TabBarView(
          children: [
            ProfilePreview(),
            EditProfile(
              controller: controller,
            ),
          ],
        ),
      ),
    );
  }
}

class EditProfile extends StatelessWidget {
  EditProfile({
    super.key,
    required this.controller,
  });

  final ProfileScreenController controller;
  final UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    controller.initializeValues();
    VoidLogger.info("Edit Profile  Built again");
    return Padding(
      padding: EdgeInsets.all(16.h).copyWith(bottom: 96.h),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            Center(
              child: Stack(
                children: [
                  Container(
                    height: 78.h,
                    width: 78.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: VoidColors.grey4,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.r),
                      child: Obx(() {
                        if (controller.pickedImage.value != null) {
                          // Display image from file
                          return Image.file(controller.pickedImage.value!,
                              fit: BoxFit.cover);
                        } else if (controller
                            .imageFromServer.value.isNotEmpty) {
                          // Display network image
                          return Image.network(controller.imageFromServer.value,
                              fit: BoxFit.cover);
                        } else {
                          // Fallback image if no image is available
                          return Image.asset("assets/images/girl.png",
                              fit: BoxFit.cover);
                        }
                      }),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 8,
                    child: GestureDetector(
                      onTap: () {
                        controller.pickImage();
                      },
                      child: Container(
                        height: 20.h,
                        width: 20.w,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: VoidColors.green),
                        child: Center(
                          child: Icon(
                            Icons.add,
                            color: VoidColors.whiteColor,
                            size: 10.r,
                          ),
                        ),
                      ),
                    ),
                  ),
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
            GestureDetector(
              onTap: () {
                controller.toggleOnlline();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 44.h,
                      width: 129.w,
                      decoration: BoxDecoration(
                        color: VoidColors.whiteColor,
                        borderRadius: BorderRadius.circular(10.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(
                                0, 4), // Shadow is applied only downward
                            blurRadius:
                            8.0, // Adjust the blur radius to control the spread of the shadow
                            spreadRadius: 0.0,
                          ),
                        ],
                      ),
                      child: Obx(() {
                        return Center(
                          child: Text(
                            "Online",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 20.sp,
                                color: controller.isOnline.value
                                    ? VoidColors.secondary
                                    : VoidColors.grey5),
                          ),
                        );
                      })),
                  SizedBox(
                    width: 20.w,
                  ),
                  Container(
                      height: 44.h,
                      width: 129.w,
                      decoration: BoxDecoration(
                        color: VoidColors.whiteColor,
                        borderRadius: BorderRadius.circular(10.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(
                                0, 4), // Shadow is applied only downward
                            blurRadius:
                            8.0, // Adjust the blur radius to control the spread of the shadow
                            spreadRadius: 0.0,
                          ),
                        ],
                      ),
                      child: Obx(() {
                        return Center(
                          child: Text(
                            "Away",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 20.sp,
                                color: controller.isOnline.value
                                    ? VoidColors.grey5
                                    : VoidColors.secondary),
                          ),
                        );
                      }))
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Gender (required)",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                    color: VoidColors.blackColor),
              ),
            ),
            Text(
              "Select the gender that best represents who you are. Your choice is an important aspect of your identity, helping others understand and respect your individuality.",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp,
                  color: VoidColors.lightGrey1),
            ),
            SizedBox(
              height: 20.h,
            ),
            SizedBox(
              height: 210,
              child: ListView.builder(
                itemCount: 3,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Obx(() {
                    bool isSelected = controller.selectedGender.value == index;
                    return GestureDetector(
                      onTap: () {
                        // controller.selectGender(index); // Update selected gender
                      },
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: Container(
                          height: 58.79,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Colors.grey[200],
                          ),
                          child: InkWell(
                            onTap: () {
                              controller
                                  .selectGender(index); // Update selected ge
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        genderIcon[index],
                                        height: 22.05,
                                        width: 22.05,
                                        colorFilter: ColorFilter.mode(
                                            Colors.black, BlendMode.srcIn),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        gender[index],
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SvgPicture.asset(
                                    isSelected
                                        ? 'assets/icons/radio.svg'
                                        : 'assets/icons/unselectedR.svg',
                                    height: 22.05,
                                    width: 22.05,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  });
                },
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Photos",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                    color: VoidColors.blackColor),
              ),
            ),
            Text(
              "Choose a clear, well-lit photos where your face is easily visible. It's your first impression, so make it count!",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp,
                  color: VoidColors.lightGrey1),
            ),
            SizedBox(
              height: 30.h,
            ),
            Container(
              height: 200.h,
              width: 200.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Obx(() {
                  if (controller.pickedImage.value != null) {
                    // Display image from file
                    return Image.file(controller.pickedImage.value!,
                        fit: BoxFit.cover);
                  } else if (controller.imageFromServer.value.isNotEmpty) {
                    // Display network image
                    return Image.network(controller.imageFromServer.value,
                        fit: BoxFit.cover);
                  } else {
                    // Fallback image if no image is available
                    return Image.asset("assets/images/girl.png",
                        fit: BoxFit.cover);
                  }
                }),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Music Genres:",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                    color: VoidColors.blackColor),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Wrap(
              spacing: 10.w,
              runSpacing: 10.h,
              children: List.generate(musicGeners.length, (index) {
                return GestureDetector(
                  onTap: () {
                    controller.toggleMusicGenre(index);
                  },
                  child: Obx(() {
                    bool isSelected = controller.selectedMusicGenres
                        .contains(musicGeneres[index]);
                    return Container(
                      padding:
                      EdgeInsets.only(left: 10.w, right: 10.w, top: 5.5.h),
                      height: 28.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.r),
                        color: isSelected
                            ? VoidColors.secondary
                            : VoidColors.whiteColor,
                        border: Border.all(
                          color: VoidColors.blackColor,
                        ),
                      ),
                      child: Text(
                        musicGeners[index],
                        style: GoogleFonts.poppins(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                          color: isSelected
                              ? VoidColors.whiteColor
                              : VoidColors.blackColor,
                        ),
                      ),
                    );
                  }),
                );
              }),
            ),
            20.verticalSpace,
            CustomButton(
              child: Obx(() {
                return controller.isLoading.value
                    ? CircularProgressIndicator()
                    : Text(
                  'Save Information',
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: VoidColors.whiteColor,
                  ),
                );
              }),
              onPressed: () async {
                await controller.editProfile();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilePreview extends StatelessWidget {
  ProfilePreview({
    super.key,
  });

  final UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.h).copyWith(bottom: 48.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              Center(
                child: Container(
                  height: 90.h,
                  width: 90.w,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.r),
                    child: Image.network(
                      userController.user.value.profilePicture.isNotEmpty
                          ? userController.user.value.profilePicture
                          : noImagePlaceHolder,
                      fit: BoxFit.cover,
                    ),
                  ),
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
                  Text(
                    userController.user.value.coins != null
                        ? userController.user.value.coins.toString()
                        : "0",
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userController.user.value.name,
                      style: GoogleFonts.manrope(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400,
                        color: VoidColors.blackColor,
                      ),
                    ),
                    Text(
                      "Coins Earned : ${userController.user.value.coins != null ? userController.user.value.coins.toString() : 0}",
                      style: GoogleFonts.manrope(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: VoidColors.blackColor,
                      ),
                    ),
                    SizedBox(
                      width: 100.w,
                      child: Text(
                        userController.user.value.interests.join(', '),
                        maxLines: 2,
                        style: GoogleFonts.manrope(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: VoidColors.blackColor,
                        ),
                      ),
                    ),
                    Text(
                      "Interactions Completed : ${userController.user.value.coins != null ? userController.user.value.coins.toString() : 0}",
                      style: GoogleFonts.manrope(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: VoidColors.blackColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Text(
                "Photos",
                style: GoogleFonts.manrope(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: VoidColors.blackColor,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Center(
                child: Container(
                    height: 272.h,
                    width: 272.w,
                    child: Image.network(
                      userController.user.value.profilePicture.isNotEmpty
                          ? userController.user.value.profilePicture
                          : noImagePlaceHolder,
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
              Wrap(
                spacing: 10.w,
                runSpacing: 10.h,
                children: List.generate(musicGeners.length, (index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Obx(() {
                      bool isSelected = userController.user.value.interests
                          .contains(musicGeners[index]);
                      return Container(
                        padding: EdgeInsets.only(
                            left: 10.w, right: 10.w, top: 5.5.h),
                        height: 28.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.r),
                          color: isSelected
                              ? VoidColors.secondary
                              : VoidColors.whiteColor,
                          border: Border.all(
                            color: VoidColors.blackColor,
                          ),
                        ),
                        child: Text(
                          musicGeners[index],
                          style: GoogleFonts.poppins(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w400,
                            color: isSelected
                                ? VoidColors.whiteColor
                                : VoidColors.blackColor,
                          ),
                        ),
                      );
                    }),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
