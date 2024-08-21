import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/constraints/colors.dart';
import '../utils/constraints/image_strings.dart';
import '../utils/constraints/text_strings.dart';


Column homeHeaderWidget(List<Map<String,
    String>> items, double itemWidth,
    VoidCallback onTap,
    String subTitle,
    {bool? suggested = false}) {
  final ScrollController _scrollController = ScrollController();
  int _currentItem = 0;

  void _scrollToItem(int index) {
    _scrollController.animateTo(
      index * itemWidth,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 54.h,),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 13.0.w),
            child: Image.asset(VoidImages.secSplash,
              height: 40.h,
              width: 40.w,),
          ),
          Text(
              VoidTexts.meetAround,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: VoidColors.blackColor,
                ),
              )
          ),
          Spacer(),
          suggested! ?
              Icon(Icons.person) : SizedBox(),
          suggested ? Icon(Icons.more_vert) : SizedBox(),

        ],
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 17.0.w, vertical: 15.0.h),
        child: Text(
            // VoidTexts.suggestPeople,
          subTitle,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: VoidColors.secondary,
              ),
            )
        ),
      ),
      SizedBox(height: 8.0.h),
      Row(
        children: [
          InkWell(
            onTap: () {
              if (_currentItem > 0) {
                _currentItem--;
                _scrollToItem(_currentItem);
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.w),
              child: Image.asset(VoidImages.backArrow,
                height: 22.h, width: 22.w,),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 86.h,
              child: ListView.builder(
                // itemCount: 6,
                  itemCount:  items.length,
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7.0.w),
                      child: GestureDetector(
                        onTap: onTap,
                        child: Column(
                          children: [
                            Expanded(
                              child: CircleAvatar(
                                backgroundImage: AssetImage(
                                  // VoidImages.testImg
                                  items[index]['image']!,
                                ),
                                radius: 30.r,
                              ),
                            ),
                            Text(
                              // 'David',
                                items[index]['name']!,
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: VoidColors.blackColor,
                                  ),
                                )
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ),
          InkWell(
            onTap: () {
              if (_currentItem < 10 - 1) {
                _currentItem++;
                _scrollToItem(_currentItem);
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.w),
              child: Image.asset(VoidImages.forwardArrow,
                height: 22.h, width: 22.w,),
            ),
          )
        ],
      )
    ],
  );
}




Column homeHeaderWidget2(List<Map<String,
    String>> items, double itemWidth,
    VoidCallback onTap,
    String subTitle,
    {bool? suggested = false}) {
  final ScrollController _scrollController = ScrollController();
  int _currentItem = 0;

  void _scrollToItem(int index) {
    _scrollController.animateTo(
      index * itemWidth,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 54.h,),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 13.0.w),
            child: Image.asset(VoidImages.secSplash,
              height: 40.h,
              width: 40.w,),
          ),
          Text(
              VoidTexts.meetAround,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: VoidColors.blackColor,
                ),
              )
          ),
          Spacer(),
          // suggested! ?
              SvgPicture.asset(
                                              "assets/icons/frnd.svg",
                                              height: 24.h,
                                              width: 24.w,
                                              colorFilter: ColorFilter.mode(
                                                  VoidColors.secondary,
                                                  BlendMode.srcIn),
                                            ),
                                            SizedBox(width: 5.w,),
                                             SvgPicture.asset(
                                              "assets/icons/more.svg",
                                              height: 24.h,
                                              width: 24.w,
                                              colorFilter: ColorFilter.mode(
                                                  VoidColors.secondary,
                                                  BlendMode.srcIn),
                                            ),
                                            SizedBox(width: 18.w,),
         

        ],
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 17.0.w, vertical: 15.0.h),
        child: Row(
          children: [
            Text(
                // VoidTexts.suggestPeople,
              "Top Picks to enjoy jamming:",
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: VoidColors.secondary,
                  ),
                )
            ),
            Spacer(),
            Text(
                // VoidTexts.suggestPeople,
              "See all",
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: VoidColors.secondary,
                  ),
                )
            ),
          ],
        ),
      ),
      SizedBox(height: 8.0.h),
      Row(
        children: [
          // InkWell(
          //   onTap: () {
          //     if (_currentItem > 0) {
          //       _currentItem--;
          //       _scrollToItem(_currentItem);
          //     }
          //   },
          //   child: Padding(
          //     padding: EdgeInsets.symmetric(horizontal: 5.0.w),
          //     child: Image.asset(VoidImages.backArrow,
          //       height: 32.h, width: 32.w,),
          //   ),
          // ),
          Expanded(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10.w),
              child: SizedBox(
                height: 86.h,
                child: ListView.builder(
                  // itemCount: 6,
                    itemCount:  items.length,
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 7.0.w),
                        child: GestureDetector(
                          onTap: onTap,
                          child: Column(
                            children: [
                              Expanded(
                                child: CircleAvatar(
                                  backgroundImage: AssetImage(
                                    // VoidImages.testImg
                                    items[index]['image']!,
                                  ),
                                  radius: 30.r,
                                ),
                              ),
                              Text(
                                // 'David',
                                  items[index]['name']!,
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: VoidColors.blackColor,
                                    ),
                                  )
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ),
          // InkWell(
          //   onTap: () {
          //     if (_currentItem < 10 - 1) {
          //       _currentItem++;
          //       _scrollToItem(_currentItem);
          //     }
          //   },
          //   child: Padding(
          //     padding: EdgeInsets.symmetric(horizontal: 5.0.w),
          //     child: Image.asset(VoidImages.forwardArrow,
          //       height: 32.h, width: 32.w,),
          //   ),
          // )
        ],
      )
    ],
  );
}