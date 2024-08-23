import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:scratch_project/app/controllers/jam_controller.dart';
import 'package:scratch_project/app/modules/JammingScreen/controllers/jamming_screen_controller.dart';
import 'package:scratch_project/app/utils/constraints/colors.dart';
import 'package:scratch_project/app/utils/constraints/text_strings.dart';

class JammingInProgressView extends StatefulWidget {
  const JammingInProgressView({super.key});

  @override
  State<JammingInProgressView> createState() => _JammingInProgressViewState();
}

class _JammingInProgressViewState extends State<JammingInProgressView> {
  final JamController jamController =
      Get.isRegistered() ? Get.find() : Get.put(JamController());

  @override
  void dispose() {
    // TODO: implement dispose
    jamController.resetValues();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        body: Obx(() {
          if (jamController.gotUrl.value != null) {
            if (jamController.gotUrl.value == true) {
              final JammingScreenController jammingScreenController =
                  Get.isRegistered()
                      ? Get.find()
                      : Get.put(JammingScreenController());
              print(
                  '//////////This is the url: ${jamController.jamData['spotifyUrl']}////////');
              jammingScreenController
                  .openSpotifyTrack(jamController.jamData['songUrl']);
            }
          }
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [VoidColors.primary, VoidColors.secondary],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Center(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 35.0.h, horizontal: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 100.h,
                        width: 100.w,
                        child: Lottie.asset('assets/icons/UQejRQZqHg.json'),
                      ),
                    ),
                    Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        VoidTexts.jammingInProgress,
                        style: GoogleFonts.poppins(
                            fontSize: 18.spMax,
                            color: VoidColors.whiteColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
