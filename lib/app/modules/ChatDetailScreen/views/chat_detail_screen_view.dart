import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scratch_project/app/controllers/user_controller.dart';
import 'package:scratch_project/app/models/chat_model.dart';
import 'package:scratch_project/app/modules/ChatDetailScreen/controllers/chat_detail_screen_controller.dart';
import 'package:scratch_project/app/modules/ChatScreen/controllers/chat_screen_controller.dart';
import 'package:scratch_project/app/modules/SearchScreen/controllers/search_screen_controller.dart';
import 'package:scratch_project/app/routes/app_pages.dart';
import 'package:scratch_project/app/utils/constraints/colors.dart';

class ChatMessage {
  final String text;
  final bool isSent;

  ChatMessage({required this.text, required this.isSent});
}

class ChatDetailScreenView extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();
  final ScrollController _scrollController = ScrollController();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // Handle the selected image
      print('Image selected: ${pickedFile.path}');
      // You can also upload the selected image or display it in the chat
    }
  }

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>;
    final String name = arguments['name'];
    final String imgPath = arguments['imgPath'];
    final int coins = arguments['coins'];
    final String coinIcon = arguments['coinIcon'];
    final ChatModel chatModel = arguments['chatModel'];
    var controller = chatCntr;
    var userController = Get.find<UserController>();
    final messageTextEditingController = TextEditingController();

    return Scaffold(
      backgroundColor: VoidColors.secondary,
      appBar: AppBar(
        toolbarHeight: 80.h,
        leading: IconButton(
          splashRadius: 20.r,
          icon: Icon(
            Icons.arrow_back,
            size: 20.r,
            color: Colors.white,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          name,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: Image.asset(
              coinIcon,
              height: 20.r,
              width: 20.r,
            ),
            onPressed: () {
              print("Appbar icon pressed");
            },
          ),
          Padding(
            padding: EdgeInsets.only(right: 20.w),
            child: Text(
              coins.toString(),
              style: GoogleFonts.manrope(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: VoidColors.whiteColor),
            ),
          )
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: VoidColors.primary,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [VoidColors.primary, VoidColors.secondary],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                return Column(
                    children:
                        List.generate(controller.chatModels.length, (index1) {
                  print(
                      ":::: User Name is ${controller.chatModels[index1].userDetails?.name == name}");
                  if (controller.chatModels[index1].userDetails?.name == name) {
                    print(
                        "::: inside message ${controller.chatModels[index1].messages?.first.content}");
                    var messages = controller.chatModels[index1].messages;
                    var userDetails = controller.chatModels[index1].userDetails;

                    print(":::: Messages length ${messages?.length}");
                    return Expanded(
                      child: Obx(() {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _scrollController.jumpTo(
                            _scrollController.position.maxScrollExtent,
                          );
                        });
                        return ListView.builder(
                          padding: EdgeInsets.all(10.w),
                          itemCount:
                              controller.chatModels[index1].messages?.length,
                          reverse: false,
                          itemBuilder: (context, index) {
                            final message =
                                controller.chatModels[index1].messages?[index];
                            print(":::: Message index is $index");

                            print(
                                ':::: current User id ${userController.user.value.id}');
                            print(
                                ':::: current message id ${message?.senderId}');
                            return Column(
                              children: [
                                //  Center(
                                //                child: Text(index==3?"We75656565d 22 June":"Today",style: GoogleFonts.lato(
                                //                  fontSize:14.sp,
                                //                  fontWeight: FontWeight.w500,
                                //                  color:VoidColors.whiteColor
                                //                ),),
                                //              ),
                                Align(
                                  alignment: controller.chatModels[index1]
                                              .messages?[index].senderId ==
                                          userController.user.value.id
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: message?.senderId ==
                                          userController.user.value.id
                                      ? Container(
                                          //height: 68.h,
                                          width: 266.w,
                                          margin: EdgeInsets.symmetric(
                                              vertical: 5.h),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w, vertical: 10.h),
                                          decoration: BoxDecoration(
                                              color: controller
                                                          .chatModels[index1]
                                                          .messages?[index]
                                                          .senderId ==
                                                      userController
                                                          .user.value.id
                                                  ? VoidColors.lightPink
                                                  : VoidColors.whiteColor,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(24.r),
                                                topRight: Radius.circular(24.r),
                                                bottomLeft:
                                                    Radius.circular(24.r),
                                                // bottomRight:
                                              )),
                                          child: Text(
                                            message?.content ?? "",
                                            style: GoogleFonts.poppins(
                                              fontSize: 14.sp,
                                              color: Colors.black,
                                            ),
                                          ),
                                        )
                                      : Row(
                                          children: [
                                            Image.network(
                                              userDetails?.profilePicture ?? '',
                                              height: 40.h,
                                              width: 40.w,
                                            ),
                                            SizedBox(width: 10.w),
                                            Container(
                                              //height: 68.h,
                                              width: 266.w,
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 5.h),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.w,
                                                  vertical: 10.h),
                                              decoration: BoxDecoration(
                                                  color: controller
                                                              .chatModels[
                                                                  index1]
                                                              .messages?[index]
                                                              ?.senderId ==
                                                          userController
                                                              .user.value.id
                                                      ? VoidColors.lightPink
                                                      : VoidColors.whiteColor,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(24.r),
                                                    topRight:
                                                        Radius.circular(24.r),
                                                    bottomLeft:
                                                        Radius.circular(24.r),
                                                    // bottomRight:
                                                  )),
                                              child: Text(
                                                controller
                                                        .chatModels[index1]
                                                        .messages?[index]
                                                        .content ??
                                                    "",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 14.sp,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                ),
                              ],
                            );
                            // :Align(
                            //   alignment: message?.senderId == userController.user.value.id
                            //       ? Alignment.centerRight
                            //       : Alignment.centerLeft,
                            //   child:message?.senderId == userController.user.value.id? Container(
                            //     //height: 68.h,
                            //     width: 266.w,
                            //     margin: EdgeInsets.symmetric(vertical: 5.h),
                            //     padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                            //     decoration: BoxDecoration(

                            //       color: message?.senderId == userController.user.value.id
                            //           ? VoidColors.lightPink
                            //           : VoidColors.whiteColor,
                            //       borderRadius: BorderRadius.only(
                            //         topLeft: Radius.circular(24.r),
                            //         topRight: Radius.circular(24.r),
                            //         bottomLeft: Radius.circular(24.r),
                            //        // bottomRight:
                            //       )
                            //     ),
                            //     child: Text(
                            //       message?.content??"",
                            //       style: GoogleFonts.poppins(
                            //         fontSize: 14.sp,
                            //         color: Colors.black,
                            //       ),
                            //     ),
                            //   ):Row(
                            //     children: [
                            //       Image.asset("assets/icons/chat.png",height: 40.h,width: 40.w,),
                            //       SizedBox(width:10.w),
                            //       Container(
                            //         //height: 68.h,
                            //         width: 266.w,
                            //         margin: EdgeInsets.symmetric(vertical: 5.h),
                            //         padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                            //         decoration: BoxDecoration(

                            //           color: message?.senderId == userController.user.value.id
                            //               ? VoidColors.lightPink
                            //               : VoidColors.whiteColor,
                            //           borderRadius: BorderRadius.only(
                            //             topLeft: Radius.circular(24.r),
                            //             topRight: Radius.circular(24.r),
                            //             bottomLeft: Radius.circular(24.r),
                            //            // bottomRight:
                            //           )
                            //         ),
                            //         child: Text(
                            //           message?.content??"",
                            //           style: GoogleFonts.poppins(
                            //             fontSize: 14.sp,
                            //             color: Colors.black,
                            //           ),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // );
                          },
                        );
                      }),
                    );
                  } else {
                    return SizedBox();
                  }
                }));
              }),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
              child: Row(
                children: [
                  Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: VoidColors.purpleColor,
                    ),
                    child: Center(
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: SvgPicture.asset(
                          "assets/icons/file.svg",
                          width: 11.w,
                          height: 22.h,
                          colorFilter: ColorFilter.mode(
                              VoidColors.whiteColor, BlendMode.srcIn),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: SizedBox(
                      height: 48.h,
                      child: TextField(
                        controller: messageTextEditingController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: VoidColors.whiteColor,
                              width: 2.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: VoidColors.whiteColor,
                              width: 2.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: VoidColors.whiteColor,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: VoidColors.purpleColor,
                    ),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          print(":::: Sedning message");
                          controller.sendMessage(
                              messageTextEditingController.text.trim(),
                              chatModel.receiverId.toString(),
                              userController.user.value.id.toString());
                          messageTextEditingController.clear();

                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            _scrollController.jumpTo(
                              _scrollController.position.maxScrollExtent,
                            );
                          });
                          //  Get.toNamed(
                          // Routes.JAMMING_SCREEN,

                          // );
                        },
                        child: SvgPicture.asset(
                          "assets/icons/voice.svg",
                          width: 11.w,
                          height: 22.h,
                          colorFilter: ColorFilter.mode(
                              VoidColors.whiteColor, BlendMode.srcIn),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
