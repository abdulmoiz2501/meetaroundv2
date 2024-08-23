import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:scratch_project/app/controllers/jam_controller.dart';
import 'package:scratch_project/app/controllers/user_controller.dart';
import 'package:scratch_project/app/controllers/websocket_controller.dart';
import 'package:scratch_project/app/modules/JammingScreen/views/jamming_screen_view.dart';
import 'package:scratch_project/app/utils/constraints/colors.dart';
import 'package:scratch_project/app/utils/constraints/text_strings.dart';

class JammingWaitingScreen extends StatefulWidget {
  final String userId;
  const JammingWaitingScreen({super.key, required this.userId});

  @override
  State<JammingWaitingScreen> createState() => _JammingWaitingScreenState();
}

class _JammingWaitingScreenState extends State<JammingWaitingScreen> {
  final WebSocketController webSocketController = Get.find();
  final JamController jamController = Get.find();
  final UserController userController = Get.find();
  int _remainingTime = 30;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    Future.delayed(Duration(seconds: 1), () {
      if (mounted && _remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
        _startCountdown();
      }
    });
  }

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
        if (_remainingTime > 0) {
          Get.snackbar(
            'Please Wait',
            'You can go back in $_remainingTime seconds.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent,
            colorText: Colors.white,
          );
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: Obx(() {
          print(
              '/////////////////////The value is ${jamController.isAccepted.value}');
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (jamController.isAccepted.value == null) {
              print('The value is null');
            } else if (jamController.isAccepted.value == true) {
              print('The value now is true');

              Get.to(() => JammingScreenView(
                    userId: userController.user.value.id,
                    targetUserId: int.parse(jamController.otherUserId.value),
                  ));
            } else if (jamController.isAccepted.value == false) {
              print('The value is false');
              Get.back();

              Future.delayed(Duration(milliseconds: 100), () {
                Get.snackbar(
                  'Request Denied',
                  'Your jamming request was not accepted.',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.redAccent,
                  colorText: Colors.white,
                );
              });
            }
          });

          // Show the current waiting screen
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
                        VoidTexts.pleaseWaitToAccept,
                        style: GoogleFonts.poppins(
                          fontSize: 18.spMax,
                          color: VoidColors.whiteColor,
                          fontWeight: FontWeight.w500,
                        ),
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
