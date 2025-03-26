import 'package:flutter/material.dart';
import '/extensions/media_query_ext.dart';
import 'custom_button.dart';
import 'custom_text_field.dart';

class EmailSection extends StatelessWidget {
  final TextEditingController emailController;
  final bool isLoading;
  final VoidCallback onSendOtp;
  final Function(String?) emailValidator;
  final GlobalKey<FormState> formFieldKey;

  const EmailSection({
    Key? key,
    required this.emailController,
    required this.isLoading,
    required this.onSendOtp,
    required this.emailValidator,
    required this.formFieldKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          controller: emailController,
          hint: "Email",
          prefixIcon: Icons.email_outlined,
          validator: (value) => emailValidator(value),
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) => onSendOtp(),
        ),
        SizedBox(height: context.height * .03),
        CustomButton(
          onPressed: isLoading ? null : onSendOtp,
          text: isLoading ? "Sending OTP..." : "Send OTP",
        ),
      ],
    );
  }
} 