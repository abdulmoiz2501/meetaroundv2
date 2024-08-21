import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:scratch_project/app/modules/signUp/controllers/sign_up_controller.dart';
import 'package:scratch_project/app/utils/constraints/colors.dart';
import 'package:scratch_project/app/utils/constraints/image_strings.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/constraints/text_strings.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textform_field.dart';

class BirthDateView extends StatefulWidget {
  const BirthDateView({super.key});

  @override
  State<BirthDateView> createState() => _BirthDateViewState();
}

class _BirthDateViewState extends State<BirthDateView> {
  final signUpController = Get.put(SignUpController());
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  Color hintTextColor = VoidColors.darkGrey;

  void _showDatePicker() {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(1900, 1, 1),
      maxTime: DateTime.now(),
      onConfirm: (date) {
        setState(() {
          signUpController.dateOfBirthController.text = "${date.day}/${date.month}/${date.year}";
        });
      },
      currentTime: DateTime.now(),
      locale: LocaleType.en,
    );
  }

  int _calculateAge(DateTime selectedDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - selectedDate.year;
    if (currentDate.month < selectedDate.month ||
        (currentDate.month == selectedDate.month && currentDate.day < selectedDate.day)) {
      age--;
    }
    return age;
  }

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
                    VoidTexts.birthDateTitle,
                    style: GoogleFonts.poppins(
                      fontSize: 32.spMax,
                      color: VoidColors.secondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 15.0.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  child: Text(
                    VoidTexts.birthDateSubTitle,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 16.spMax,
                      color: VoidColors.secondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 4.0.h),
                CustomTextFormField(
                  obscureText: false,
                  hint: 'dd/mm/yyyy',
                  controller: signUpController.dateOfBirthController,
                  readOnly: true,
                  onTap: () {
                    _showDatePicker();
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w),
            child: CustomButton(
              text: 'Next',
              onPressed: () {
                if (signUpController.dateOfBirthController.text.isEmpty) {
                  Get.snackbar(
                    'Error',
                    'Date of Birth cannot be empty',
                    backgroundColor: VoidColors.primary,
                    colorText: VoidColors.whiteColor,
                    snackPosition: SnackPosition.BOTTOM,
                  );
                } else {
                  DateTime selectedDate = DateFormat('dd/MM/yyyy').parse(signUpController.dateOfBirthController.text);
                  int userAge = _calculateAge(selectedDate);

                  if (userAge >= 18) {
                    Get.toNamed(Routes.SELECT_GENDER_VIEW);
                  } else {
                    Get.snackbar(
                      'Error',
                      'You must be 18 years or older to sign up',
                      backgroundColor: VoidColors.primary,
                      colorText: VoidColors.whiteColor,
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                }
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
