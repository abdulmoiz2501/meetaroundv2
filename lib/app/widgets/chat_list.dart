import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scratch_project/app/models/chat_model.dart';
import 'package:scratch_project/app/modules/SearchScreen/controllers/search_screen_controller.dart';
import 'package:scratch_project/app/routes/app_pages.dart';
import 'package:scratch_project/app/utils/constraints/colors.dart';

final searchScreenController = Get.put(SearchScreenController());

class ChatListItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String lastMessage;
  final String time;
  final String coinIcon;
  final int coins;
  final ChatModel chatModel;

  ChatListItem(
      {required this.imageUrl,
      required this.name,
      required this.lastMessage,
      required this.time,
      required this.coinIcon,
      required this.coins,
      required this.chatModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        searchScreenController.isChat(false);
        Get.toNamed(
          Routes.CHAT_DETAIL_SCREEN,
          arguments: {
            'name': name,
            'imgPath': imageUrl,
            'coins': coins,
            "coinIcon": coinIcon,
            'chatModel': chatModel
          },
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h),
        padding: EdgeInsets.all(12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(imageUrl),
              radius: 24.r,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    lastMessage,
                    style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  time,
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                  ),
                ),
                Row(
                  children: [
                    Image.asset(
                      coinIcon,
                      height: 16.r,
                      width: 16.r,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      coins.toString(),
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ChatListItem2 extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String lastMessage;
  final String time;
  final String coinIcon;
  final int coins;

  ChatListItem2({
    required this.imageUrl,
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.coinIcon,
    required this.coins,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          Routes.CHAT_DETAIL_SCREEN,
          arguments: {
            'name': name,
            'imgPath': imageUrl,
            'coins': coins,
            "coinIcon": coinIcon,
          },
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 2.h),
        padding: EdgeInsets.all(12.h),
        decoration: BoxDecoration(
          color: VoidColors.lightBlack.withOpacity(0.26),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(imageUrl),
              radius: 24.r,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    lastMessage,
                    style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  time,
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                  ),
                ),
                Row(
                  children: [
                    Image.asset(
                      coinIcon,
                      height: 16.r,
                      width: 16.r,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      coins.toString(),
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
