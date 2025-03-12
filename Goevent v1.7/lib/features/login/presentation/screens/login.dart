import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamaraticket/extensions/media_query_ext.dart';
import 'package:hamaraticket/features/home/presentation/screens/home.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/otp_input_field.dart';
import '../widgets/social_button.dart';


class Login extends ConsumerStatefulWidget {
  static const routeName = 'Login';
  static const routePath = '/login';
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  final _emailController = TextEditingController();
  final _otpController = TextEditingController();
  bool isOtpSent = false;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  
  @override
  void dispose() {
    _emailController.dispose();
    _otpController.dispose();
    super.dispose();
  }
  
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    // Regular expression for email validation
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  Future<void> _handleSendOtp() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => isLoading = true);
      try {
        // Simulate API call
        await Future.delayed(const Duration(seconds: 1));
        setState(() {
          isOtpSent = true;
          isLoading = false;
        });
      } catch (e) {
        // Handle error
        setState(() => isLoading = false);
      }
    }
  }
  // The dispose method is already defined in the class, so we need to remove the duplicate.


  void _onOtpCompleted(String otp) {
    // Handle OTP completion
    if (otp.length == 6) {
      // Verify OTP logic here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: context.height * .07),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      "assets/image/hamara-ticket-logo.png",
                      height: context.height * .1,
                    ),
                  ),
                ),
                SizedBox(height: context.height * .02),
                Center(
                  child: Text(
                    "Hamara Ticket",
                    style: TextStyle(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w700,
                      color: context.colorScheme.primary,
                    ),
                  ),
                ),
                SizedBox(height: context.height * .05),
                Text(
                  "Sign in",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: context.height * .02),
                
                if (!isOtpSent) ...[
                  CustomTextField(
                      controller: _emailController,
                      hint: "Email",
                      prefixIcon: Icons.email_outlined,
            validator: (value) {
                        // First check basic validation
                        final validationError = _validateEmail(value);
                        if (validationError != null) {
                          return validationError;
                        }
                        // Check for API error
                        if (value == 'error@test.com') {
                          return 'This email is not registered';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => _handleSendOtp(),
                    ),
                  SizedBox(height: context.height * .03),
                  CustomButton(
                      onPressed: isLoading ? null : _handleSendOtp,
                      text: isLoading ? "Sending OTP..." : "Send OTP",
                    ),
                  SizedBox(height: context.height * .02),
                  _buildDivider(),
                  SizedBox(height: context.height * .02),
                  SocialButton(
                    onTap: () {
                      // Implement Google Sign In
                    },
                    text: "Continue with Google",
                    icon: "assets/image/google.png",
                  ),
                ] else ...[
                  Text(
                    "Enter verification code",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: context.height * .02),
                  OtpInputField(
                    controller: _otpController,
                    onCompleted: _onOtpCompleted,
                  ),
                  SizedBox(height: context.height * .02),
                  CustomButton(
                    onPressed: () {

                      if (_otpController.text.length == 6) {
                        context.pushNamed(Home.routeName);
                        // Verify OTP logic
                      }
                    },
                    text: "Verify OTP",
                  ),
                  SizedBox(height: context.height * .02),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          isOtpSent = false;
                          _emailController.clear();
                          _otpController.clear();
                        });
                      },
                      child: Text(
                        "Change Sign-in Method",
                        style: TextStyle(
                          color: context.colorScheme.primary,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  )
                  ]
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: context.colorScheme.onSurface.withAlpha(100))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "OR",
            style: TextStyle(
              color: context.colorScheme.onSurface.withAlpha(200),
              fontSize: 14.sp,
            ),
          ),
        ),
        Expanded(child: Divider(color: context.colorScheme.onSurface.withAlpha(100))),
      ],
    );
  }
}