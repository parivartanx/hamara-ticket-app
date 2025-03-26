import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '/extensions/media_query_ext.dart';
import '/features/home/presentation/screens/home.dart';
import 'custom_button.dart';
import 'otp_input_field.dart';

class OtpSection extends StatelessWidget {
  final VoidCallback onChangeSignInMethod;
  final TextEditingController otpController;
  final Function(String) onOtpCompleted;

  const OtpSection({
    Key? key,
    required this.onChangeSignInMethod,
    required this.otpController,
    required this.onOtpCompleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Enter verification code",
          style: TextStyle(
            fontSize: 16.sp,
            color: context.colorScheme.onSurface,
          ),
        ),
        SizedBox(height: context.height * .02),
        OtpInputField(
          controller: otpController,
          onCompleted: onOtpCompleted,
        ),
        SizedBox(height: context.height * .02),
        CustomButton(
          onPressed: () => _handleVerifyOtp(context),
          text: "Verify OTP",
        ),
        SizedBox(height: context.height * .02),
        Center(
          child: TextButton(
            onPressed: onChangeSignInMethod,
            child: Text(
              "Change Sign-in Method",
              style: TextStyle(
                color: context.colorScheme.primary,
                fontSize: 14.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _handleVerifyOtp(BuildContext context) {
    if (otpController.text.length == 6) {
      context.pushNamed(Home.routeName);
      // TODO: Implement OTP verification logic
    }
  }
} 