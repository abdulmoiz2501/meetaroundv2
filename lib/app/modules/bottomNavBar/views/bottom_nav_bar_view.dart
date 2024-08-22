import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:scratch_project/app/controllers/user_controller.dart';
import 'package:scratch_project/app/controllers/websocket_controller.dart';
import 'package:scratch_project/app/modules/PastInterections/views/past_interections_view.dart';
import 'package:scratch_project/app/modules/ProfileScreen/views/profile_screen_view.dart';
import 'package:scratch_project/app/modules/SearchScreen/views/search_screen_view.dart';
import 'package:scratch_project/app/modules/bottomNavBar/views/home_screen_view.dart';
import 'package:scratch_project/app/routes/app_pages.dart';
import 'package:scratch_project/app/utils/constraints/text_strings.dart';
import 'package:scratch_project/app/widgets/homeHeaderWidget.dart';
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
    return Scaffold(
      backgroundColor: VoidColors.whiteColor,
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: StreamBuilder(
            stream: webSocketController.messageStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final message = jsonDecode(snapshot.data.toString());
                print("Message in BottomNavBarView: ${message}");
                if (message['type'] == 'request') {
                  final x = message['userId'].toString();
                  print('The user id is: $x');
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    showJammingRequestDialog(
                      name: 'name',
                      onReject: () {
                        webSocketController.sendJammingResponse(
                            userController.user.value.id.toString(), 'reject');
                      },
                      onAccept: () {
                        webSocketController.sendJammingResponse(
                            userController.user.value.id.toString(), 'accept');
                        Get.back();
                      },
                    );
                  });
                }
              }
              return Obx(
                  () => _pages[bottomNavBarController.selectedIndex.value]);
            }),
      ),
      bottomNavigationBar: Container(
        height: 50.h,
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



