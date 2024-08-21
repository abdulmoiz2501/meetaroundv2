import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/constraints/colors.dart';
import '../../../widgets/custom_button.dart';

class TermsAndConditionsView extends StatelessWidget {
  final VoidCallback onAccept;

  const TermsAndConditionsView({super.key, required this.onAccept});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VoidColors.whiteColor,
      appBar: AppBar(
        title: Text(
          'Terms and Conditions',
          style: GoogleFonts.poppins(
            color: VoidColors.blackColor,
            fontSize: 20.spMax,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: VoidColors.whiteColor,
        iconTheme: IconThemeData(color: VoidColors.blackColor),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 20.0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  '''
Welcome to MeetAround! Before you sign up and start using our services, please take a moment to read through our Terms and Conditions. By using our app, you agree to these terms, so it's important to understand them.

- By accessing and using MeetAround, you agree to be bound by these Terms and Conditions. If you do not agree with any part of these terms, you may not use the app.

- To use our services, you must create an account by providing accurate and complete information. You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account. You must be at least 13 years old to create an account. If you are under 18, you need permission from a parent or guardian.

- You agree not to engage in any activities that violate any laws or regulations, infringe on the rights of others including privacy, intellectual property, and personal rights, spread viruses, malware, or other harmful software, or use the app for unauthorized commercial purposes or solicitations.

- You retain ownership of any content you create and share on MeetAround. However, by posting content, you grant us a license to use, modify, and distribute your content within the app. All content provided by MeetAround, including text, images, logos, and software, is owned by us or our licensors and is protected by intellectual property laws. You may not use this content without permission.

- We collect personal data to provide and improve our services. This includes information you provide during account creation and data collected through your use of the app. Your data will be used in accordance with our Privacy Policy, which outlines how we handle and protect your personal information. We do not share your personal information with third parties without your consent, except as required by law.

- You may terminate your account at any time by contacting our support team. We reserve the right to suspend or terminate your account if you violate these Terms and Conditions or engage in prohibited activities.

- MeetAround is provided "as is" and "as available." We do not guarantee that the app will be free of errors, bugs, or interruptions. To the extent permitted by law, we are not liable for any damages or losses resulting from your use of the app, including indirect, incidental, or consequential damages.

- We may update these Terms and Conditions from time to time. When we do, we will notify you by updating the "Last Updated" date at the top of these terms. Your continued use of the app after changes to the Terms and Conditions constitutes your acceptance of the new terms.

- These Terms and Conditions are governed by and construed in accordance with the laws of [Country/State]. Any disputes arising from these terms will be subject to the jurisdiction of the courts in [Country/State].

If you have any questions or concerns about these Terms and Conditions, please contact us at [support email or contact form link].
                  ''',
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    color: VoidColors.blackColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            // CustomButton(
            //   text: 'Accept',
            //   onPressed: onAccept,
            //   borderRadius: 24.r,
            //   color: VoidColors.primary,
            //   textColor: VoidColors.whiteColor,
            // ),
          ],
        ),
      ),
    );
  }
}
