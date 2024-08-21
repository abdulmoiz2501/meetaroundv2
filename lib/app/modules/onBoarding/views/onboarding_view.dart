import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scratch_project/app/modules/signUp/views/sign_up_view.dart';
import 'package:scratch_project/app/widgets/custom_button.dart';
import '../../../utils/constraints/colors.dart';
import '../../../utils/constraints/image_strings.dart';
import '../../../utils/constraints/text_strings.dart';
import '../../../widgets/on_boarding_widget.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();
    var currentIndex = 0.obs;

    final List<Widget> onBoardingPages = [
      OnBoardingWidget(
        imagePath: VoidImages.firstOnBoarding,
        text: VoidTexts.firstOnBoarding,
        buttonText: 'Next',
        onButtonPressed: () {
          pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
      ),
      OnBoardingWidget(
        imagePath: VoidImages.secOnBoarding,
        text: VoidTexts.secOnBoarding,
        buttonText: 'Next',
        fontSize: 30.sp,
        onButtonPressed: () {
          pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
      ),
      OnBoardingWidget(
        imagePath: VoidImages.thirdOnBoarding,
        text: VoidTexts.thirdOnBoarding,
        buttonText: 'Get Started',
        titleSize: 26.sp,
        fontWeight: FontWeight.w700,
        fontSize: 20.sp,
        onButtonPressed: () {
          Get.offAll(() => SignUpView());
        },
        isCenteredText: true,
      ),
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [VoidColors.primary, VoidColors.secondary],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                onPageChanged: (index) {
                  currentIndex.value = index;
                },
                itemCount: onBoardingPages.length,
                itemBuilder: (BuildContext context, int index) {
                  return Stack(
                    children: [
                      onBoardingPages[index],
                      Positioned(
                        top: 40.h,
                        right: 20.w,
                        child: GestureDetector(
                          onTap: () {
                            Get.offAll(() => SignUpView());
                          },
                          child: Text(
                            'Skip',
                            style: GoogleFonts.poppins(
                              fontSize: 15.sp,
                              color: VoidColors.whiteColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 40.h, top: 10.h),
              child: Column(
                children: [
                  Obx(() {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(onBoardingPages.length, (index) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 3.w),
                          width: currentIndex.value == index ? 12.w : 8.w,
                          height: currentIndex.value == index ? 12.h : 8.h,
                          decoration: BoxDecoration(
                            color: currentIndex.value == index
                                ? VoidColors.blackColor
                                : VoidColors.whiteColor,
                            shape: BoxShape.circle,
                          ),
                        );
                      }),
                    );
                  }),
                  SizedBox(height: 20.h),
                  Obx(() {
                    return Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 20.w),
                        child: CustomButton(
                          text: currentIndex.value == 2 ? "Get Started" : "Next",
                          height: 30.h,
                          width: 160.w,
                          onPressed: () {
                            if (currentIndex.value == 2) {
                              Get.offAll(() => SignUpView());
                            } else {
                              pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                          textColor: VoidColors.blackColor,
                          color: VoidColors.whiteColor,
                          borderRadius: 40.0.r,
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
