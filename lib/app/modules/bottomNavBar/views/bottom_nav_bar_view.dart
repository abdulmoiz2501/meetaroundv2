import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:scratch_project/app/controllers/jam_controller.dart';
import 'package:scratch_project/app/controllers/track_controller.dart';
import 'package:scratch_project/app/controllers/user_controller.dart';
import 'package:scratch_project/app/controllers/websocket_controller.dart';
import 'package:scratch_project/app/modules/JammingScreen/controllers/jamming_screen_controller.dart';
import 'package:scratch_project/app/modules/JammingScreen/views/jamming_in_progress_view.dart';
import 'package:scratch_project/app/modules/PastInterections/views/past_interections_view.dart';
import 'package:scratch_project/app/modules/ProfileScreen/views/profile_screen_view.dart';
import 'package:scratch_project/app/modules/SearchScreen/views/search_screen_view.dart';
import 'package:scratch_project/app/modules/bottomNavBar/views/home_screen_view.dart';
import 'package:scratch_project/app/widgets/jamming_request_alertBox.dart';

import '../../../utils/constraints/colors.dart';
import '../../../utils/constraints/image_strings.dart';
import '../../ChatScreen/views/chat_screen_view.dart';
import '../controllers/bottom_nav_bar_controller.dart';

class BottomNavBarView extends GetView<BottomNavBarController> {
  BottomNavBarView({super.key});
  final BottomNavBarController bottomNavBarController =
      Get.put(BottomNavBarController());
  final WebSocketController webSocketController =
      Get.find<WebSocketController>();
  final UserController userController = Get.find();

  final List<Widget> _pages = [
    HomeScreenView(),
    PastInterectionsView(),
    SearchScreen(),
    ChatScreenView(),
    ProfileScreenView(),
  ];

  @override
  Widget build(BuildContext context) {
    final TrackController trackController = Get.find();
    return Scaffold(
      backgroundColor: VoidColors.whiteColor,
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: StreamBuilder(
            stream: webSocketController.messageStream.asBroadcastStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final message = jsonDecode(snapshot.data.toString());
                print("Message in BottomNavBarView: ${message}");
                if (message['type'] == 'request') {
                  trackController.isDialogOpen.value = true;
                  final x = message['userId'].toString();
                  final JamController jamController = Get.isRegistered()
                      ? Get.find()
                      : Get.put(JamController());
                  jamController.jamData.value = message;
                  jamController.otherUserId.value = message['userId'];

                  print('The user id is: $x');
                  WidgetsBinding.instance.addPostFrameCallback((_) async {
                    final user =
                        await userController.fetchUserById(int.parse(x));
                    String name = '';

                    if (user != null) {
                      name = user.name;
                    } else {
                      name = 'Unknown';
                    }
                    showJammingRequestDialog(
                      name: name,
                      onReject: () {
                        webSocketController.sendJammingResponse(
                            userController.user.value.id.toString(), 'reject');
                        trackController.isDialogOpen.value = false;
                      },
                      onAccept: () {
                        webSocketController.sendJammingResponse(
                            userController.user.value.id.toString(), 'accept');
                        trackController.isDialogOpen.value = false;

                        userController.isSender.value = false;

                        Get.back();
                        trackController.isJamInProgressOpen.value = true;
                        Get.to(() => const JammingInProgressView());
                      },
                    );
                  });
                } else if (message['status'] == 'accept') {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    print('////this message is accepted $message');
                    final JamController jamController = Get.find();

                    jamController.otherUserId.value =
                        message['userId'].toString();
                    jamController.isAccepted.value = true;
                    jamController.jamData.value = message;
                    userController.isSender.value = true;
                  });
                } else if (message['status'] == 'reject') {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    print('////this message is rejected $message');

                    final JamController jamController = Get.find();
                    jamController.otherUserId.value =
                        message['userId'].toString();
                    jamController.isAccepted.value = false;
                    jamController.jamData.value = message;
                  });

                  // print(
                  //     'This is the isAccepted value: ${jamController.isAccepted}');
                } else if (message['type'] == 'url') {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    final JamController jamController = Get.isRegistered()
                        ? Get.find()
                        : Get.put(JamController());
                    jamController.jamData.value = message;
                    print('This is the jam data: ${jamController.jamData}');
                    final JammingScreenController jammingScreenController =
                        Get.isRegistered()
                            ? Get.find()
                            : Get.put(JammingScreenController());
                    jammingScreenController
                        .openSpotifyTrack(message['songUrl']);
                  });
                } else if (message['type'] == 'jammingCancelled') {
                  final TrackController trackController = Get.find();
                  if (trackController.isDialogOpen.value) {
                    if (Navigator.canPop(Get.context!)) {
                      Navigator.pop(Get.context!);
                    }
                    Get.snackbar(
                      'Request Cancelled',
                      'The other user has cancelled the request.',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.redAccent,
                      colorText: Colors.white,
                    );
                    trackController.isDialogOpen.value = false;
                  } else if (trackController.isJamWaitingScreenOpen.value) {
                    trackController.isJamWaitingScreenOpen.value = false;

                    Navigator.pop(context);

                    Future.delayed(const Duration(milliseconds: 100), () {
                      Get.snackbar(
                        'Request Cancelled',
                        'The other user has cancelled the request.',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.redAccent,
                        colorText: Colors.white,
                      );
                    });
                  } else if (trackController.isJamInProgressOpen.value) {
                    trackController.isJamInProgressOpen.value = false;

                    Navigator.pop(context);

                    Future.delayed(const Duration(milliseconds: 100), () {
                      Get.snackbar(
                        'Request Cancelled',
                        'The other user has cancelled the request.',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.redAccent,
                        colorText: Colors.white,
                      );
                    });
                  } else if (trackController.isJamWaitingScreenOpen.value) {
                    trackController.isJamWaitingScreenOpen.value = false;

                    Navigator.pop(context);

                    Future.delayed(const Duration(milliseconds: 100), () {
                      Get.snackbar(
                        'Request Cancelled',
                        'The other user has cancelled the request.',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.redAccent,
                        colorText: Colors.white,
                      );
                    });
                  } else if (trackController.isJammingScreenViewOpen.value) {
                    trackController.isJammingScreenViewOpen.value = false;

                    // Get.offAll(() => BottomNavBarView());
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => BottomNavBarView()),
                      (Route<dynamic> route) => false,
                    );

                    Future.delayed(const Duration(milliseconds: 100), () {
                      Get.snackbar(
                        'Request Cancelled',
                        'The other user has cancelled the request.',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.redAccent,
                        colorText: Colors.white,
                      );
                    });
                  } else if (trackController.isSpotifyScreenOpen.value) {
                    trackController.isSpotifyScreenOpen.value = false;

                    // Get.offAll(() => BottomNavBarView());
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => BottomNavBarView()),
                      (Route<dynamic> route) => false,
                    );

                    // Show snackbar after a short delay
                    Future.delayed(Duration(milliseconds: 100), () {
                      Get.snackbar(
                        'Request Cancelled',
                        'The other user has cancelled the request.',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.redAccent,
                        colorText: Colors.white,
                      );
                    });
                  }
                }
              }
              return Obx(
                  () => _pages[bottomNavBarController.selectedIndex.value]);
            }),
      ),
      bottomNavigationBar: Container(
        height: 60.h,
        decoration: const BoxDecoration(
          color: VoidColors.bottomNavColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(() =>
                _buildNavItem(VoidImages.homeIcon, 0, bottomNavBarController)),
            Obx(
              () => _buildNavItem(
                  VoidImages.favouriteIcon, 1, bottomNavBarController),
            ),
            Obx(
              () => _buildNavItem(
                  VoidImages.searchIcon, 2, bottomNavBarController),
            ),
            Obx(() =>
                _buildNavItem(VoidImages.msgIcon, 3, bottomNavBarController)),
            Obx(
              () => _buildNavItem(
                  VoidImages.personIcon, 4, bottomNavBarController),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
      String asset, int index, BottomNavBarController controller,
      {double? size}) {
    return GestureDetector(
      onTap: () {
        controller.changeIndex(index);
      },
      child: Container(
        width: 25.w,
        color: Colors.transparent,
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(asset,
                      width: controller.selectedIndex.value == index
                          ? (size ?? 29.sp)
                          : (size ?? 28.sp),
                      height: controller.selectedIndex.value == index
                          ? (size ?? 29.sp)
                          : (size ?? 28.sp),
                      color: controller.selectedIndex.value == index
                          ? VoidColors.secondary
                          : null),
                  controller.selectedIndex.value == index
                      ? const SelectBar()
                      : const SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectBar extends StatelessWidget {
  const SelectBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(top: 5),
        height: 2.h,
        // width: isActive ? 6 : 0,
        width: 52.w,
        decoration: const BoxDecoration(
          color: VoidColors.secondary,
        ));
  }
}



// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(child: Text('Home Screen')),
//     );
//   }
// }



