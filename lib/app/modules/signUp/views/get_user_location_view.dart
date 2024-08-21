import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scratch_project/app/routes/app_pages.dart';
import 'package:scratch_project/app/utils/constraints/colors.dart';
import 'package:scratch_project/app/utils/constraints/image_strings.dart';
import 'package:scratch_project/app/utils/constraints/text_strings.dart';
import 'package:scratch_project/app/widgets/custom_button.dart';
import '../controllers/sign_up_controller.dart';

class GetUserLocationView extends StatefulWidget {
  const GetUserLocationView({super.key});

  @override
  State<GetUserLocationView> createState() => _GetUserLocationViewState();
}

class _GetUserLocationViewState extends State<GetUserLocationView> {
  final signUpController = Get.put(SignUpController());

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  child: Text(
                    VoidTexts.getLocationTitle,
                    style: GoogleFonts.poppins(
                      fontSize: 32.spMax,
                      color: VoidColors.secondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Center(
                  child: Image.asset(
                    VoidImages.getLocation,
                    height: 150.h,
                    width: 150.w,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 150.0.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w),
            child: Obx(
                  () => signUpController.loading.value
                  ? CircularProgressIndicator(
                color: VoidColors.secondary,
              )
                  : CustomButton(
                text: 'Next',
                onPressed: () async {
                  signUpController.loading.value = true;
                  try {
                    await signUpController.getCurrentLocation();
                    await signUpController.signUp();
                    Get.offAllNamed(Routes.SIGN_IN);
                  } catch (e) {
                    Get.snackbar('Error', e.toString());
                  } finally {
                    signUpController.loading.value = false;
                  }
                },
                borderRadius: 24.r,
              ),
            ),
          ),
          SizedBox(height: 20.0.h),
        ],
      ),
    );
  }
}
