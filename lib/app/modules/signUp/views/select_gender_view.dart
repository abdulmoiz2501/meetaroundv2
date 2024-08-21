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
import '../../../widgets/gender_selection_tile.dart';
import 'music_genres_view.dart';

class SelectGenderView extends StatelessWidget {
  final SignUpController genderController = Get.put(SignUpController());

  SelectGenderView({super.key});

  @override
  Widget build(BuildContext context) {
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  child: Text(
                    VoidTexts.selectGender,
                    style: GoogleFonts.poppins(
                      fontSize: 32.spMax,
                      color: VoidColors.secondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 5.0.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  child: Text(
                    VoidTexts.selectGenderSubtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 12.spMax,
                      color: VoidColors.darkGrey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: 50.0.h),
                Obx(() => GenderSelectionTile(
                  title: 'Male',
                  iconPath: VoidImages.male, // Replace with your actual icon path
                  isSelected: genderController.selectedGender.value == 'Male',
                  onTap: () {
                    genderController.selectGender('Male');
                  },
                )),
                Obx(() => GenderSelectionTile(
                  title: 'Female',
                  iconPath: VoidImages.female, // Replace with your actual icon path
                  isSelected: genderController.selectedGender.value == 'Female',
                  onTap: () {
                    genderController.selectGender('Female');
                  },
                )),
                Obx(() => GenderSelectionTile(
                  title: 'Non Binary',
                  iconPath: VoidImages.binary, // Replace with your actual icon path
                  isSelected: genderController.selectedGender.value == 'Non Binary',
                  onTap: () {
                    genderController.selectGender('Non Binary');
                  },
                )),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w),
            child: CustomButton(
              text: 'Next',
              onPressed: () {
                genderController.selectedGender.isEmpty?Get.snackbar('Error', 'Please Select Gender',
        backgroundColor: VoidColors.primary,
        colorText: VoidColors.whiteColor,
        snackPosition: SnackPosition.BOTTOM):
                Get.toNamed(Routes.MUSIC_GENRE);
              },
              borderRadius: 24.r,
            ),
          ),
          SizedBox(height: 20.0.h),
        ],
      ),
    );
  }
}
