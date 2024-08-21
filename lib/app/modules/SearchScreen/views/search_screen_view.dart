import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controllers/user_controller.dart';
import '../../../widgets/custom_appbar.dart';
import '../../JammingScreen/controllers/jamming_screen_controller.dart';
import '../controllers/search_screen_controller.dart';
import '../../../models/chat_model.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/constraints/colors.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchScreenController searchScreenController = Get.put(SearchScreenController());
  final UserController userController = Get.find();

  @override
  void initState() {
    searchScreenController.fetchUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VoidColors.whiteColor,
      appBar: CustomAppBar(),
      body: Container(
        color: VoidColors.whiteColor,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24.h),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Top Picks to enjoy jamming:",
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: VoidColors.blackColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // See All
                      },
                      child: Text(
                        "See All",
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: VoidColors.redColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                child: SizedBox(
                  height: 100.h,
                  child: Obx(() {
                    if (searchScreenController.isLoading.value) {
                      return Container(
                        color: VoidColors.whiteColor,
                        height: 400.h,
                        width: 400.w,
                        child: Center(
                            child: CircularProgressIndicator(
                              color: VoidColors.secondary,
                            )),
                      );
                    }
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: searchScreenController.users.map((user) {
                          return Padding(
                            padding: EdgeInsets.all(8.h),
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      height: 60.63.h,
                                      width: 60.63.w,
                                      decoration: BoxDecoration(shape: BoxShape.circle),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(100.r),
                                        child: Image.network(
                                          user.profilePicture,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Image.asset(
                                              'assets/images/noimage.png',
                                              fit: BoxFit.cover,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 1,
                                      right: 1,
                                      child: Obx(() {
                                        return Container(
                                          height: 7.h,
                                          width: 10.w,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: userController.status.value == null ||
                                                userController.status.value == false
                                                ? VoidColors.grey2
                                                : VoidColors.green,
                                          ),
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  user.name,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: VoidColors.blackColor,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  }),
                ),
              ),
              Expanded(
                child: Obx(() {
                  if (searchScreenController.isLoading.value) {
                    return Center(
                        child: CircularProgressIndicator(
                          color: VoidColors.secondary,
                        ));
                  }
                  return PageView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: searchScreenController.users.length,
                    itemBuilder: (context, index) {
                      final user = searchScreenController.users[index];
                      final distance = searchScreenController.distances[user.id]?.toInt().toString() ?? 'N/A';
                      final address = searchScreenController.addresses[user.id] ?? 'Unknown Location';
                      return Container(
                        height: 100.h,
                        child: Stack(
                          children: [
                            Container(
                              height: 300.h,
                              width: double.infinity,
                              child: Image.network(
                                user.profilePicture,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    'assets/images/noimage.png',
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(15.h),
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border(
                                    top: BorderSide(color: VoidColors.whiteColor, width: 1.w),
                                    left: BorderSide(color: VoidColors.whiteColor, width: 1.w),
                                    right: BorderSide(color: VoidColors.whiteColor, width: 1.w),
                                  ),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(10.h),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Obx(() {
                                        if (searchScreenController.isDistanceLoading.value) {
                                          return Align(
                                            alignment: Alignment.topRight,
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                color: VoidColors.whiteColor.withOpacity(0.4),
                                                strokeWidth: 2,
                                              ),
                                            ),
                                          );
                                        }
                                        return Align(
                                          alignment: Alignment.topRight,
                                          child: IntrinsicWidth(
                                            child: Container(
                                              height: 40.h,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(32.r),
                                                color: VoidColors.blackColor.withOpacity(0.2),
                                                border: Border.all(
                                                  color: VoidColors.whiteColor.withOpacity(0.4),
                                                  width: 1.w,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 5.w),
                                                child: Center(
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      SizedBox(
                                                        height: 12.h,
                                                        width: 16.w,
                                                        child: Center(
                                                          child: SvgPicture.asset("assets/icons/distance.svg"),
                                                        ),
                                                      ),
                                                      SizedBox(width: 3.w),
                                                      Text(
                                                        '$distance km',
                                                        style: GoogleFonts.poppins(
                                                          fontSize: 16.sp,
                                                          fontWeight: FontWeight.w500,
                                                          color: VoidColors.whiteColor,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                      Column(
                                        children: [
                                          Stack(
                                            children: [
                                              Align(
                                                alignment: Alignment.bottomCenter,
                                                child: IntrinsicWidth(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(12.r),
                                                      color: VoidColors.whiteColor.withOpacity(0.2),
                                                    ),
                                                    child: Stack(
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.all(8.h),
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Flexible(
                                                                    flex: 2,
                                                                    child: Text(
                                                                      user.name,
                                                                      style: GoogleFonts.poppins(
                                                                        fontWeight: FontWeight.w700,
                                                                        fontSize: 18.sp,
                                                                        color: VoidColors.whiteColor,
                                                                      ),
                                                                      overflow: TextOverflow.ellipsis,
                                                                      maxLines: 1,
                                                                      softWrap: false,
                                                                    ),
                                                                  ),
                                                                  SizedBox(width: 5.w),
                                                                  Flexible(
                                                                    flex: 2,
                                                                    child: Row(
                                                                      children: [
                                                                        SvgPicture.asset(
                                                                          "assets/icons/var.svg",
                                                                          height: 12.h,
                                                                          width: 16.w,
                                                                        ),
                                                                        SizedBox(width: 5.w),
                                                                        Flexible(
                                                                          child: Text(
                                                                            userController.verified.value == null ||
                                                                                userController.verified.value == false
                                                                                ? "Not Verified"
                                                                                : "Id Verified",
                                                                            style: GoogleFonts.poppins(
                                                                              fontWeight: FontWeight.w400,
                                                                              fontSize: 10.sp,
                                                                              color: VoidColors.whiteColor,
                                                                            ),
                                                                            overflow: TextOverflow.ellipsis,
                                                                            maxLines: 1,
                                                                            softWrap: false,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Obx(() {
                                                                    if (searchScreenController.isAddressLoading.value) {
                                                                      return Center(
                                                                        child: CircularProgressIndicator(
                                                                          color: VoidColors.secondary,
                                                                          strokeWidth: 2,
                                                                        ),
                                                                      );
                                                                    }
                                                                    return Text(
                                                                      address,
                                                                      style: GoogleFonts.poppins(
                                                                        fontWeight: FontWeight.w400,
                                                                        fontSize: 12.sp,
                                                                        color: VoidColors.whiteColor,
                                                                      ),
                                                                    );
                                                                  }),
                                                                  SizedBox(width: 15.w),
                                                                  Row(
                                                                    children: [
                                                                      SvgPicture.asset(
                                                                        "assets/icons/coin1.svg",
                                                                        height: 16.h,
                                                                        width: 16.w,
                                                                      ),
                                                                      SizedBox(width: 5.w),
                                                                      Text(
                                                                        userController.coins.value == null || userController.verified.value == 0
                                                                            ? '0'
                                                                            : userController.coins.value.toString(),
                                                                        style: GoogleFonts.poppins(
                                                                          fontWeight: FontWeight.w700,
                                                                          fontSize: 14.sp,
                                                                          color: VoidColors.whiteColor,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Positioned(
                                                          right: 1,
                                                          child: Padding(
                                                            padding: EdgeInsets.all(0.h),
                                                            child: Obx(() {
                                                              return Container(
                                                                height: 14.h,
                                                                width: 14.w,
                                                                decoration: BoxDecoration(
                                                                  shape: BoxShape.circle,
                                                                  color: userController.status.value == null ||
                                                                      userController.status.value == false
                                                                      ? VoidColors.grey2
                                                                      : VoidColors.green,
                                                                ),
                                                              );
                                                            }),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 6.h),
                                          Container(
                                            width: ScreenUtil().screenWidth - 50.w,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(40.r),
                                                topRight: Radius.circular(40.r),
                                              ),
                                              color: VoidColors.bottomNavColor,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black.withOpacity(0.2),
                                                  offset: Offset(0, 5),
                                                  blurRadius: 10.r,
                                                  spreadRadius: 2.r,
                                                ),
                                              ],
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Music genre:",
                                                    style: GoogleFonts.manrope(
                                                      fontSize: 14.sp, // Reduced size
                                                      fontWeight: FontWeight.w600,
                                                      color: VoidColors.grey2,
                                                    ),
                                                  ),
                                                  SizedBox(height: 6.h), // Reduced spacing
                                                  Wrap(
                                                    spacing: 8.w, // Reduced spacing
                                                    runSpacing: 8.h, // Reduced spacing
                                                    children: List.generate(user.interests.length, (index) {
                                                      return Container(
                                                        padding: EdgeInsets.symmetric(horizontal: 8.w, // Reduced padding
                                                            vertical: 4.h), // Reduced padding
                                                        height: 22.h, // Reduced height
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(50.r),
                                                          color: VoidColors.whiteColor,
                                                          border: Border.all(
                                                            color: VoidColors.lightGrey,
                                                            width: 2,
                                                          ),
                                                        ),
                                                        child: Text(
                                                          user.interests[index],
                                                          style: GoogleFonts.poppins(
                                                            fontSize: 9.sp, // Reduced font size
                                                            fontWeight: FontWeight.w400,
                                                            color: VoidColors.blackColor,
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 8.h),
                                          Center(
                                            child: Container(
                                              height: 52.h,
                                              width: 138.w,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(100.r),
                                                color: VoidColors.grey2.withOpacity(0.2),
                                              ),
                                              child: Obx(() {
                                                return Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        searchScreenController.toggleChatMusic();
                                                        Get.toNamed(
                                                          Routes.CHAT_DETAIL_SCREEN,
                                                          arguments: {
                                                            'name': user.name,
                                                            'imgPath': user.profilePicture,
                                                            'coins': user.coins ?? 0,
                                                            "coinIcon": "assets/icons/coin.png",
                                                            'chatModel': ChatModel(
                                                              receiverId: user.id,
                                                              messages: [],
                                                              userDetails: UserDetails(
                                                                coins: user.coins ?? 0,
                                                                profilePicture: user.profilePicture,
                                                                name: user.name,
                                                              ),
                                                            ),
                                                          },
                                                        );
                                                      },
                                                      child: Container(
                                                        height: 46.h,
                                                        width: 46.w,
                                                        decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          color: searchScreenController.isChat.value
                                                              ? VoidColors.secondary
                                                              : VoidColors.whiteColor,
                                                        ),
                                                        child: Center(
                                                          child: SvgPicture.asset(
                                                            "assets/icons/chat1.svg",
                                                            height: 20.h,
                                                            width: 20.w,
                                                            colorFilter: ColorFilter.mode(
                                                                searchScreenController.isChat.value
                                                                    ? VoidColors.whiteColor
                                                                    : VoidColors.secondary,
                                                                BlendMode.srcIn),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 20.w),
                                                    GestureDetector(
                                                      onTap: () {
                                                        searchScreenController.toggleChatMusic();
                                                        print("Creating JammingScreenController with userId: ${userController.user.value.id} and targetUserId: ${user.id}");
                                                        Get.delete<JammingScreenController>();
                                                        Get.put(
                                                          JammingScreenController(
                                                            userId: userController.user.value.id,
                                                            targetUserId: user.id,
                                                          ),
                                                        );
                                                        print("The user id that send request is: ${userController.user.value.id}");
                                                        print("The target user id is: ${user.id}");
                                                        Get.toNamed(
                                                          Routes.JAMMING_SCREEN,
                                                          arguments: {
                                                            'userId': userController.user.value.id,
                                                            'targetUserId': user.id,
                                                          },
                                                        );
                                                        print("The target user id is 000000: ${user.id}");
                                                      },
                                                      child: Container(
                                                        height: 46.h,
                                                        width: 46.w,
                                                        decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          color: searchScreenController.isChat.value
                                                              ? VoidColors.whiteColor
                                                              : VoidColors.secondary,
                                                        ),
                                                        child: Center(
                                                          child: SvgPicture.asset(
                                                            "assets/icons/music.svg",
                                                            height: 20.h,
                                                            width: 20.w,
                                                            colorFilter: ColorFilter.mode(
                                                                searchScreenController.isChat.value
                                                                    ? VoidColors.secondary
                                                                    : VoidColors.whiteColor,
                                                                BlendMode.srcIn),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
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
