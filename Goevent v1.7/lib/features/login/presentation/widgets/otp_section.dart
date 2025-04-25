import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '/extensions/media_query_ext.dart';
import 'otp_input_field.dart';

class OtpSection extends StatelessWidget {
  final VoidCallback onChangeSignInMethod;
  final TextEditingController otpController;
  final Function(String) onOtpCompleted;
  final String? email;

  const OtpSection({
    Key? key,
    required this.onChangeSignInMethod,
    required this.otpController,
    required this.onOtpCompleted,
    this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Enter verification code",
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: context.colorScheme.onSurface,
          ),
        ),
        SizedBox(height: context.height * .02),
        if (email != null)
          Text(
            "We've sent a code to $email",
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        SizedBox(height: context.height * .03),
        OtpInputField(
          controller: otpController,
          onCompleted: onOtpCompleted,
        ),
        SizedBox(height: context.height * .03),
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: () {
              if (otpController.text.length == 6) {
                onOtpCompleted(otpController.text);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: context.colorScheme.primary,
              foregroundColor: context.colorScheme.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: Text(
              "Verify",
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        SizedBox(height: context.height * .02),
        Center(
          child: TextButton(
            onPressed: onChangeSignInMethod,
            child: Text(
              "Change Sign-in Method",
              style: GoogleFonts.poppins(
                color: context.colorScheme.primary,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
} 