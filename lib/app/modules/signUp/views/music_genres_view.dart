import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scratch_project/app/modules/signUp/controllers/sign_up_controller.dart';
import 'package:scratch_project/app/widgets/music_genres_tile_widget.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/constraints/colors.dart';
import '../../../utils/constraints/image_strings.dart';
import '../../../utils/constraints/text_strings.dart';
import '../../../widgets/custom_button.dart';

class MusicGenresView extends StatefulWidget {
  const MusicGenresView({super.key});

  @override
  State<MusicGenresView> createState() => _MusicGenresViewState();
}

class _MusicGenresViewState extends State<MusicGenresView> {
  final SignUpController controller = Get.put(SignUpController());

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
                    VoidTexts.musicGenresTitle,
                    style: GoogleFonts.poppins(
                        fontSize: 32.spMax,
                        color: VoidColors.secondary,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: 5.0.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  child: Text(
                    VoidTexts.musicGenresSubTitle,
                    style: GoogleFonts.poppins(
                        fontSize: 12.spMax,
                        color: VoidColors.darkGrey,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(height: 20.0.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  child: Obx(
                    () => MusicGenreTileWidget(
                      options: [
                        'Pop',
                        'Rock',
                        'Hip-Hop',
                        'Dance',
                        'Soul',
                        'Classical',
                        'Romantic',
                        'Country',
                        'Metal',
                        'Folk',
                        'Punk',
                        'Baroque',
                        'Modern',
                        'Latin',
                        'Afrobeat',
                        'Reggae'
                      ],
                      initialSelected: controller.selectedMusicGenres.toList(),
                      onSelected: (value) {
                        controller.toggleMusicGenre(value);
                      },
                    ),
                  ),
                ),
                SizedBox(height: 50.0.h),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w),
            child: CustomButton(
              text: 'Next',
              onPressed: () {
                 controller.selectedMusicGenres.isEmpty?Get.snackbar('Error', 'Atleast One Generes Must be Selected',
        backgroundColor: VoidColors.primary,
        colorText: VoidColors.whiteColor,
        snackPosition: SnackPosition.BOTTOM):
                Get.toNamed(Routes.ADD_PICTURE);
              },
              borderRadius: 28.0.r,
              textColor: VoidColors.whiteColor,
            ),
          ),
          SizedBox(height: 40.0.h),
        ],
      ),
    );
  }
}
