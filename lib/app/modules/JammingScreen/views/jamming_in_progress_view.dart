import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:scratch_project/app/controllers/jam_controller.dart';
import 'package:scratch_project/app/controllers/track_controller.dart';
import 'package:scratch_project/app/controllers/user_controller.dart';
import 'package:scratch_project/app/controllers/websocket_controller.dart';
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
  final WebSocketController webSocketController = Get.find();
  final UserController userController = Get.find();
  final TrackController trackController = Get.find();

  int _secondsRemaining = 30; // Set the initial countdown time
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer(); // Start the countdown when the screen is initialized
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        _timer?.cancel(); // Stop the timer when the countdown is complete
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    trackController.isJamInProgressOpen.value = false;
    jamController.resetValues();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('this is the other user id: ${jamController.otherUserId.value}');
    return WillPopScope(
      onWillPop: () async {
        if (_secondsRemaining > 0) {
          Get.snackbar(
            'Please wait',
            'You can go back in $_secondsRemaining seconds.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent,
            colorText: Colors.white,
          );
          return false; // Prevent going back
        } else {
          webSocketController.sendCancelJamming(
            userController.user.value.id.toString(),
            jamController.otherUserId.value,
          );
          trackController.isJamInProgressOpen.value = false;

          return true;
        }
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
              final String url = jamController.jamData['songUrl'];
              trackController.isJamInProgressOpen.value = false;
              trackController.isSpotifyScreenOpen.value = true;
              jammingScreenController.openSpotifyTrack(url);
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
