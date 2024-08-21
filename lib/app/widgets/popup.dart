import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scratch_project/app/utils/constraints/colors.dart';

void showCustomPopup({
  required BuildContext context,
  required String headingText,
  required String subText,
  String subText2="",
  required String buttonText,
  required String belowButtonText,
  required VoidCallback onButtonPressed,
  required VoidCallback onBelowButtonPressed,
  required var height,
 
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Center(
          child: Text(
            headingText,
           style: GoogleFonts.poppins(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w400,
                  color: VoidColors.blackColor  
                ),
          ),
        ),
        content:Padding(
          padding:  EdgeInsets.all(0),
          child: SizedBox(
            height:  height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               
                SizedBox(height: 10.h,),
                 Column(
                   children: [
                     Text(subText,style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: VoidColors.lightGrey1  
                                   ),),
                                    Text(subText2,style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: VoidColors.lightGrey1  
                                   ),),
                   ],
                 ),
                 SizedBox(height: 10.h,),
                 SizedBox(
  width: double.infinity, // Set the desired width here
  child: ElevatedButton(
    onPressed: () {
      onButtonPressed();
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: VoidColors.secondary, // Set the background color to pink
      elevation: 0
    ),
    child: Text(
      buttonText,
      style: GoogleFonts.poppins(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: VoidColors.whiteColor,
      ),
    ),
  ),
)
,
                 SizedBox(height: 10.h,),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                                onPressed: () {
                  onBelowButtonPressed;
                                },
                                style: ElevatedButton.styleFrom(
                                backgroundColor: VoidColors.whiteColor, // Set the background color to pink
                                elevation: 0
                                ),
                                child: Text(
                  belowButtonText,
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: VoidColors.lightGrey1,
                  ),
                                ),
                              ),
                )
            
            
              ],
            ),
          ),
        )
    
      );
    },
  );
}



void showCustomBottomSheet({
  required BuildContext context,
  required String headingText,
  required String subText,
  required String subText2 ,
 required String subText3 ,
  required String subText4 ,
   required String subText5 ,
    required String subText6 ,
     required String smallSubText ,
  required String buttonText,
 // required String belowButtonText,
  required VoidCallback onButtonPressed,
 // required VoidCallback onBelowButtonPressed,
 // required double height, // Changed to double for height
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Allow height to be controlled
    builder: (BuildContext context) {
      return Container(
        padding: EdgeInsets.all(20.h), // Add padding if needed
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // Adjusts the size based on content
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                headingText,
                style: GoogleFonts.poppins(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                  color: VoidColors.blackColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 10.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  maxLines: 2,
                  subText,
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: VoidColors.blackColor,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 5.h),
                  Text(
                    smallSubText,
                    style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: VoidColors.lightGrey1,
                    ),
                    //textAlign: TextAlign.center,
                  ),
                   SizedBox(height: 15.h),
                  Text(
                    subText2,
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: VoidColors.blackColor,
                    ),
                   // textAlign: TextAlign.center,
                  ),
                    SizedBox(height: 15.h),
                   //SizedBox(height: 5.h),
                  Text(
                    subText3,
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: VoidColors.blackColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                    SizedBox(height: 15.h),
                  Text(
                    subText4,
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: VoidColors.blackColor,
                    ),
                   // textAlign: TextAlign.center,
                  ),
                     SizedBox(height: 15.h),
                  Text(
                    subText5,
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: VoidColors.blackColor,
                    ),
                   // textAlign: TextAlign.center,
                  ),
                     SizedBox(height: 15.h),
                  Text(
                    subText6,
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: VoidColors.blackColor,
                    ),
                    //textAlign: TextAlign.center,
                  ),

              ],
            ),
            SizedBox(height: 10.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onButtonPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: VoidColors.secondary,
                  elevation: 0,
                ),
                child: Text(
                  buttonText,
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: VoidColors.whiteColor,
                  ),
                ),
              ),
            ),
           
          ],
        ),
      );
    },
  );
}