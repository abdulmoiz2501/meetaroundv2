import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/jamming_screen_controller.dart';
import 'package:scratch_project/app/utils/constraints/colors.dart';

class JammingScreenView extends StatelessWidget {
  final int userId;
  final int targetUserId; // Add this to accept targetUserId

  JammingScreenView({Key? key, required this.userId, required this.targetUserId}) : super(key: key);

  // Pass the userId when creating the controller instance
  final JammingScreenController controller = Get.put(JammingScreenController
    (
      userId: Get.arguments['userId'],
      targetUserId: Get.arguments['targetUserId'], 
  ),
  );

  @override
  Widget build(BuildContext context) {

    // Use a post-frame callback to send the jamming request after the screen is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.sendJammingRequest(targetUserId); // Call the function with the targetUserId
    });

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.h,
        leading: IconButton(
          splashRadius: 20.r,
          icon: Icon(
            Icons.arrow_back,
            size: 20.r,
            color: VoidColors.whiteColor,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Obx(
              () => controller.isSearching.value
              ? TextField(
            onChanged: (value) {
              controller.filterSongs(value);
            },
            autofocus: true,
            style: GoogleFonts.poppins(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: VoidColors.whiteColor,
            ),
            decoration: InputDecoration(
              hintText: 'Search Songs',
              hintStyle: GoogleFonts.poppins(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: VoidColors.whiteColor.withOpacity(0.7),
              ),
              border: InputBorder.none,
            ),
          )
              : Text(
            "Jamming session",
            style: GoogleFonts.poppins(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: VoidColors.whiteColor,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: VoidColors.whiteColor,
            ),
            onPressed: () {
              controller.toggleSearch();
            },
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: VoidColors.primary,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          if (controller.isSearching.value) {
            controller.toggleSearch();
            controller.clearSearch();
          }
        },
        child: Obx(
              () => controller.isLoading.value
              ? buildShimmerLoading()
              : buildContent(),
        ),
      ),
    );
  }

  Widget buildShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            child: Container(
              width: double.infinity,
              height: 282.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Container(
              width: 160.w,
              height: 46.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 24.w),
                child: Container(
                  height: 80.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildContent() {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [VoidColors.primary, VoidColors.secondary],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Container(
                width: double.infinity,
                height: 282.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Obx(
                        () {
                      if (controller.filteredTracks.isEmpty) {
                        return Image.asset(
                          "assets/images/placeholder.jpg",
                          fit: BoxFit.cover,
                        );
                      }

                      final imageUrl = controller.selectedSongIndex.value == -1
                          ? controller.filteredTracks[0]['images'][0]['url'] ??
                          'assets/images/placeholder.jpg'
                          : controller.filteredTracks[
                      controller.selectedSongIndex.value]
                      ['images'][0]['url'] ??
                          'assets/images/placeholder.jpg';

                      return Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/placeholder.jpg',
                            fit: BoxFit.cover,
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                        () => Container(
                      width: 160.w,
                      height: 46.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: VoidColors.lightTransparent.withOpacity(0.3),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 7.w),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: controller.selectedCategory.value.isEmpty
                                ? controller.categories[0]
                                : controller.selectedCategory.value,
                            icon: Padding(
                              padding: EdgeInsets.only(left: 5.w),
                              child: SvgPicture.asset(
                                "assets/icons/dropdoen.svg",
                                width: 9.28.w,
                                height: 7.13.h,
                                colorFilter: ColorFilter.mode(
                                    VoidColors.whiteColor, BlendMode.srcIn),
                              ),
                            ),
                            iconSize: 24.sp,
                            elevation: 16,
                            style: TextStyle(color: Colors.black),
                            dropdownColor: VoidColors.primary,
                            onChanged: (String? newValue) {
                              controller.setSelectedCategoryIndex(
                                  controller.categories.indexOf(newValue!));
                            },
                            items: controller.categories
                                .map<DropdownMenuItem<String>>((value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14.sp,
                                    color: VoidColors.whiteColor,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Obx(
                  () => controller.filteredTracks.isEmpty
                  ? Text(
                "No playlist found",
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  color: VoidColors.whiteColor,
                ),
              )
                  : ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: controller.filteredTracks.length,
                itemBuilder: (context, index) {
                  final playlist = controller.filteredTracks[index];
                  return GestureDetector(
                    onTap: () {
                      controller.setSelectedSongIndex(index);
                      controller.setSelectedSong(playlist['name']);
                      controller.openSpotifyTrack(playlist['uri']);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5.h),
                      decoration: BoxDecoration(
                        color: controller.selectedSongIndex.value == index
                            ? VoidColors.whiteColor.withOpacity(0.08)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 15.h, horizontal: 10.w),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  playlist['images'][0]['url'] ??
                                      'assets/images/placeholder.jpg',
                                  height: 21.h,
                                  width: 23.w,
                                  errorBuilder:
                                      (context, error, stackTrace) {
                                    return Image.asset(
                                      'assets/images/placeholder.jpg',
                                      height: 21.h,
                                      width: 23.w,
                                    );
                                  },
                                ),
                                SizedBox(width: 13.w),
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 200.w,
                                      child: Text(
                                        playlist['name'],
                                        style: GoogleFonts.roboto(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                          color:
                                          VoidColors.blackColor,
                                        ),
                                        overflow:
                                        TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    SizedBox(
                                      width: 200.w,
                                      child: Text(
                                        playlist['description'] ?? '',
                                        style: GoogleFonts.roboto(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w400,
                                          color:
                                          VoidColors.blackColor,
                                        ),
                                        overflow:
                                        TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
