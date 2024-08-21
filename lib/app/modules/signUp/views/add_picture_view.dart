import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scratch_project/app/routes/app_pages.dart';
import 'package:scratch_project/app/widgets/music_genres_tile_widget.dart';
import '../../../utils/constraints/colors.dart';
import '../../../utils/constraints/image_strings.dart';
import '../../../utils/constraints/text_strings.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/gender_selection_tile.dart';
import '../controllers/sign_up_controller.dart';


class AddPictureView extends StatefulWidget {

  const AddPictureView({super.key});

  @override
  State<AddPictureView> createState() => _AddPictureViewState();
}

class _AddPictureViewState extends State<AddPictureView> {
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
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  child: Text(
                    VoidTexts.addPictureTitle,
                    // textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: 32.spMax,
                        color: VoidColors.secondary,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ),
                SizedBox(
                    height: 5.0.h
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  child: Text(
                    VoidTexts.addPictureSubTitle,
                    // textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: 12.spMax,
                        color: VoidColors.darkGrey,
                        fontWeight: FontWeight.w400
                    ),
                  ),
                ),
                SizedBox(
                    height: 20.0.h
                ),

                GestureDetector(
                  onTap: () {
                    signUpController.pickPicture();
                  },
                  child: Stack(
                    children: [
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.0.w, vertical: 5.0.h),
                          child: Obx(() =>
                            DottedBorder(
                                borderType: BorderType.RRect,
                                radius: Radius.circular(10.0.r),
                                dashPattern: [6, 3],
                                color: Colors.grey,
                                strokeWidth: 2,
                                child: Container(
                                  height: 292.h,
                                  width: 292.w,
                                  color: VoidColors.lightGrey,
                                  child: signUpController.isImgPicked.value && signUpController.imgFile.value != null
                                    ? ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0.r),
                                      child: Image.file(File(signUpController.imgFile.value!.path),
                                      height: 292.h,
                                      width: 292.w,
                                      // width: Get.width,
                                      fit: BoxFit.cover,),
                                    ) :
                                      SizedBox(),

                                )),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 25,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: VoidColors.blackColor,
                            shape: BoxShape.circle
                          ),
                          child: Center(
                            child: Icon(
                              Icons.add_circle,
                              size: 24.0.sp,
                              color: VoidColors.whiteColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // GestureDetector(
                //   onTap: () {
                //     signUpController.pickPicture();
                //   },
                //   child: Obx(() => signUpController.isImgPicked.value && signUpController.imgFile.value != null ?
                //   Padding(
                //     padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 10.0.h),
                //     child: Center(
                //       child: Image.file(File(signUpController.imgFile.value!.path),
                //         height: 292.h,
                //         width: 292.w,
                //         // width: Get.width,
                //         fit: BoxFit.cover,),
                //     ),
                //   )
                //       : Padding(
                //         padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 10.0.h),
                //         child: SizedBox(
                //           height: 292.h,
                //           child: ClickableSquare(
                //             onTap: () {
                //           signUpController.pickPicture();
                //           },
                //           ),
                //         ),
                //       ),
                //   ),
                // ),

                SizedBox(
                  height: 50.0.h,
                ),

              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w),
            child: CustomButton(
              text: 'Next',
              onPressed: () {
                signUpController.imgFile.value == null?Get.snackbar('Error', 'Select Image',
        backgroundColor: VoidColors.primary,
        colorText: VoidColors.whiteColor,
        snackPosition: SnackPosition.BOTTOM):
                Get.toNamed(Routes.USER_LOCATION);
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











// import 'package:flutter/material.dart';
//
// import 'package:get/get.dart';
//
// class AddPictureView extends GetView {
//   const AddPictureView({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('AddPictureView'),
//         centerTitle: true,
//       ),
//       body: const Center(
//         child: Text(
//           'AddPictureView is working',
//           style: TextStyle(fontSize: 20),
//         ),
//       ),
//     );
//   }
// }
