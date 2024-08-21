import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scratch_project/app/modules/signUp/controllers/sign_up_controller.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/constraints/colors.dart';
import '../../../utils/constraints/image_strings.dart';
import '../../../utils/constraints/text_strings.dart';
import '../../../widgets/custom_button.dart';


class WelcomeView extends GetView {
  const WelcomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final signupController= Get.put(SignUpController());
    return Scaffold(
      backgroundColor: VoidColors.whiteColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: SizedBox(
            width: 32.w,
            height: 32.h,
            child: Image.asset(VoidImages.backArrow),
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 17.0.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      VoidTexts.welcomeTitle,
                      style: GoogleFonts.poppins(
                          fontSize: 32.spMax,
                          color: VoidColors.secondary,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    Text(
                      VoidTexts.welcomeSubtitle,
                      style: GoogleFonts.poppins(
                          fontSize: 16.spMax,
                          color: VoidColors.darkGrey,
                          fontWeight: FontWeight.w400
                      ),
                    ),
                    SizedBox(height: 20.0.h),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${VoidTexts.safetyTitle}\n',
                            style: GoogleFonts.poppins(
                                fontSize: 14.spMax,
                                color: VoidColors.blackColor,
                                fontWeight: FontWeight.w700
                            ),
                          ),
                          TextSpan(
                            text: '${VoidTexts.safetyDetail}\n\n',
                            style: GoogleFonts.poppins(
                                fontSize: 12.spMax,
                                color: VoidColors.blackColor,
                                fontWeight: FontWeight.w400
                            ),
                          ),
                          TextSpan(
                            text: '${VoidTexts.respectTitle}\n',
                            style: GoogleFonts.poppins(
                                fontSize: 14.spMax,
                                color: VoidColors.blackColor,
                                fontWeight: FontWeight.w700
                            ),
                          ),
                          TextSpan(
                            text: '${VoidTexts.respectDetail}\n\n',
                            style: GoogleFonts.poppins(
                                fontSize: 12.spMax,
                                color: VoidColors.blackColor,
                                fontWeight: FontWeight.w400
                            ),
                          ),
                          TextSpan(
                            text: '${VoidTexts.authenticity}\n',
                            style: GoogleFonts.poppins(
                                fontSize: 14.spMax,
                                color: VoidColors.blackColor,
                                fontWeight: FontWeight.w700
                            ),
                          ),
                          TextSpan(
                            text: '${VoidTexts.authenticityDetail}\n\n',
                            style: GoogleFonts.poppins(
                                fontSize: 12.spMax,
                                color: VoidColors.blackColor,
                                fontWeight: FontWeight.w400
                            ),
                          ),
                          TextSpan(
                            text: '${VoidTexts.reportTitle}\n',
                            style: GoogleFonts.poppins(
                                fontSize: 14.spMax,
                                color: VoidColors.blackColor,
                                fontWeight: FontWeight.w700
                            ),
                          ),
                          TextSpan(
                            text: '${VoidTexts.reportDetail}\n\n',
                            style: GoogleFonts.poppins(
                                fontSize: 12.spMax,
                                color: VoidColors.blackColor,
                                fontWeight: FontWeight.w400
                            ),
                          ),
                          TextSpan(
                            text: '${VoidTexts.communicateTitle}\n',
                            style: GoogleFonts.poppins(
                                fontSize: 14.spMax,
                                color: VoidColors.blackColor,
                                fontWeight: FontWeight.w700
                            ),
                          ),
                          TextSpan(
                            text: '${VoidTexts.communicateDetail}\n\n',
                            style: GoogleFonts.poppins(
                                fontSize: 12.spMax,
                                color: VoidColors.blackColor,
                                fontWeight: FontWeight.w400
                            ),
                          ),
                          TextSpan(
                            text: '${VoidTexts.meetTitle}\n',
                            style: GoogleFonts.poppins(
                                fontSize: 14.spMax,
                                color: VoidColors.blackColor,
                                fontWeight: FontWeight.w700
                            ),
                          ),
                          TextSpan(
                            text: '${VoidTexts.meetDetail}\n',
                            style: GoogleFonts.poppins(
                                fontSize: 12.spMax,
                                color: VoidColors.blackColor,
                                fontWeight: FontWeight.w400
                            ),
                          ),
                        ]
                      ),

                    ),

                    SizedBox(height: 70.0.h,),


                  ],
                ),
              ),
            ),
          ),
          // SizedBox(height: 150.0.h,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w),
            child: CustomButton(
              text: 'I agree',
              onPressed: () {
                signupController.signUp();
               
              },
              borderRadius: 24.r,

            ),
          ),

          SizedBox(height: 20.0.h,)
        ],
      ),
    );
  }
}
