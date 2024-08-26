import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scratch_project/app/controllers/user_controller.dart';
import 'package:scratch_project/app/utils/constraints/colors.dart';
import 'package:scratch_project/app/widgets/chat_list.dart';

import '../controllers/past_interections_controller.dart';

class PastInterectionsView extends GetView<PastInterectionsController> {
  const PastInterectionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered()
        ? Get.find<PastInterectionsController>()
        : Get.put(PastInterectionsController());
    final UserController userController = Get.find();
    controller.fetchAndUpdatePastInteractions(userController.user.value.id);
    return Scaffold(
      backgroundColor: VoidColors.secondary,
      appBar: AppBar(
        toolbarHeight: 80.h,
        // leading: IconButton(
        //   splashRadius: 20.r,
        //   icon: Icon(
        //     Icons.arrow_back,
        //     size: 20.r,
        //     color: Colors.white,
        //   ),
        //   onPressed: () {
        //     Get.back();
        //   },
        // ),
        title: Text(
          'Past Interactions',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: VoidColors.primary,
            /*gradient: LinearGradient(
              colors: [VoidColors.primary, VoidColors.secondary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),*/
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: TextField(
              controller: controller.searchController.value,
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  color: Colors.grey,
                ),
                suffixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          // 8.verticalSpace,
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Obx(() {
                if (controller.isLoading.value && controller.users.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (controller.filteredUsers.isEmpty) {
                  return RefreshIndicator(
                    onRefresh: () => controller.fetchAndUpdatePastInteractions(
                        userController.user.value.id),
                    child: ListView(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 2,
                          child: const Center(
                            child: Text('No past interactions found'),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return RefreshIndicator(
                    onRefresh: () => controller.fetchAndUpdatePastInteractions(
                        userController.user.value.id),
                    child: ListView.builder(
                      itemCount: controller.filteredUsers.length,
                      itemBuilder: (context, index) {
                        final user = controller.filteredUsers[index];
                        return IgnorePointer(
                          ignoring: true,
                          child: ChatListItem2(
                            imageUrl: user.profilePicture,
                            name: user.name,
                            lastMessage: 'Successfully Completed Jam',
                            time: '11:20am',
                            coinIcon: 'assets/icons/coin.png',
                            coins: 1,
                          ),
                        );
                        // return ListTile(
                        //   leading: CircleAvatar(
                        //     backgroundImage: NetworkImage(user.profilePicture),
                        //   ),
                        //   title: Text(user.name),
                        //   subtitle: Text(user.email),
                        //   trailing: Text('${user.coins ?? 0} Coins'),
                        // );
                      },
                    ),
                  );
                }
              }),
            ),
          ),
        ],
      ),
      // body: Container(
      //   decoration: const BoxDecoration(
      //     gradient: LinearGradient(
      //       colors: [VoidColors.primary, VoidColors.secondary],
      //       begin: Alignment.topCenter,
      //       end: Alignment.bottomCenter,
      //     ),
      //   ),
      //   child: Column(
      //     children: [
      //       Padding(
      //         padding: EdgeInsets.all(12.h),
      //         child: SizedBox(
      //           height: 36.h,
      //           child: TextField(
      //             decoration: InputDecoration(
      //               hintText: 'Search',
      //               hintStyle: GoogleFonts.poppins(
      //                 fontSize: 14.sp,
      //                 color: Colors.grey,
      //               ),
      //               suffixIcon: const Icon(
      //                 Icons.search,
      //                 color: Colors.grey,
      //               ),
      //               filled: true,
      //               fillColor: Colors.white,
      //               border: OutlineInputBorder(
      //                 borderRadius: BorderRadius.circular(12.r),
      //                 borderSide: BorderSide.none,
      //               ),
      //             ),
      //           ),
      //         ),
      //       ),
      //       Expanded(
      //         child: ListView.builder(
      //           padding: EdgeInsets.all(12.h),
      //           itemCount: 5, // Placeholder item count
      //           itemBuilder: (context, index) {
      //             return IgnorePointer(
      //               ignoring: true,
      //               child: ChatListItem2(
      //                 imageUrl: 'assets/icons/chat.png',
      //                 name: 'User Name',
      //                 lastMessage: 'Last message preview',
      //                 time: '11:20am',
      //                 coinIcon: 'assets/icons/coin.png',
      //                 coins: 10,
      //               ),
      //             );
      //           },
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
