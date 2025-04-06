import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/login_provider.dart';
import '../providers/login_with_email_provider.dart';
import '/config/auth/google_signin_auth.dart';
import '/extensions/media_query_ext.dart';
import '/features/home/presentation/screens/home.dart';
import '/features/terms-and-conditions/screens/terms_and_conditions.dart';
import '/features/privacy-policy/privacy_policy.dart';
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

class _LoginState extends ConsumerState<Login>
    with SingleTickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final _googleSignInAuth = GoogleSignInAuth();

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutQuint,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _otpController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  Future<void> _handleSendOtp() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        log("Attempting to send OTP to email: ${_emailController.text}");
        await ref
            .read(loginWithEmailProvider.notifier)
            .loginWithEmail(email: _emailController.text);
      } catch (e) {
        log("Error sending OTP: $e");
        _showMessage(
          context,
          'Failed to send OTP: ${e.toString()}',
          type: MessageType.error,
        );
      }
    }
  }

  void _onOtpCompleted(String otp) {
    if (otp.length == 6) {
      try {
        log("Attempting to verify OTP for email: ${_emailController.text}");
        ref
            .read(verifyOTPProvider.notifier)
            .verifyOTP(email: _emailController.text, otp: otp);
      } catch (e) {
        log("Error verifying OTP: $e");
        _showMessage(
          context,
          'Failed to verify OTP: ${e.toString()}',
          type: MessageType.error,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isOTPSent = ref.watch(otpStateProvider);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              context.colorScheme.primary,
              context.colorScheme.primary.withOpacity(0.8),
              context.colorScheme.primary.withOpacity(0.6),
            ],
          ),
        ),
        child: SafeArea(
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: child,
                ),
              );
            },
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Skip Button
                              Align(
                                alignment: Alignment.topRight,
                                child: TextButton(
                                  onPressed: () {
                                    context
                                        .pushReplacementNamed(Home.routeName);
                                  },
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: Text(
                                    "Skip",
                                    style: GoogleFonts.poppins(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: context.colorScheme.surface,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: context.height * 0.03),
                              // Logo and App Name
                              Center(
                                child: Hero(
                                  tag: 'app-logo',
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: context.colorScheme.surface
                                          .withOpacity(0.2),
                                      boxShadow: [
                                        BoxShadow(
                                          color: context.colorScheme.shadow
                                              .withOpacity(0.1),
                                          blurRadius: 20,
                                          spreadRadius: 5,
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: Image.asset(
                                        "assets/image/hamara-ticket-logo.png",
                                        height: context.height * 0.12,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: context.height * 0.02),
                              Center(
                                child: Text(
                                  "Hamara Ticket",
                                  style: GoogleFonts.poppins(
                                    fontSize: 28.sp,
                                    fontWeight: FontWeight.w700,
                                    color: context.colorScheme.surface,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                              SizedBox(height: context.height * 0.02),
                              Center(
                                child: Text(
                                  "Welcome Back",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16.sp,
                                    color: context.colorScheme.surface
                                        .withOpacity(0.8),
                                    letterSpacing: 0.2,
                                  ),
                                ),
                              ),
                              SizedBox(height: context.height * 0.06),
                              if (!isOTPSent) ...[
                                // Email Input
                                Container(
                                  decoration: BoxDecoration(
                                    color: context.colorScheme.surface
                                        .withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: context.colorScheme.surface
                                          .withOpacity(0.2),
                                    ),
                                  ),
                                  child: CustomTextField(
                                    controller: _emailController,
                                    hint: "Email",
                                    prefixIcon: Icons.email_outlined,
                                    validator: _validateEmail,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.done,
                                    onFieldSubmitted: (_) => _handleSendOtp(),
                                  ),
                                ),
                                SizedBox(height: context.height * 0.03),
                                // Send OTP Button
                                Consumer(
                                  builder: (context, ref, child) {
                                    final state =
                                        ref.watch(loginWithEmailProvider);
                                    return Container(
                                      width: double.infinity,
                                      height: 56,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [
                                          BoxShadow(
                                            color: context.colorScheme.shadow
                                                .withOpacity(0.2),
                                            blurRadius: 10,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: ElevatedButton(
                                        onPressed: state.isLoading
                                            ? null
                                            : _handleSendOtp,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              context.colorScheme.surface,
                                          foregroundColor:
                                              context.colorScheme.primary,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          elevation: 0,
                                        ),
                                        child: state.isLoading
                                            ? const SizedBox(
                                                height: 20,
                                                width: 20,
                                                child:
                                                    CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(Colors.white),
                                                ),
                                              )
                                            : Text(
                                                "Send OTP",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(height: context.height * 0.03),
                                // Divider
                                Row(
                                  children: [
                                    Expanded(
                                      child: Divider(
                                        color: context.colorScheme.surface
                                            .withOpacity(0.2),
                                        thickness: 1,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: Text(
                                        "OR",
                                        style: GoogleFonts.poppins(
                                          color: context.colorScheme.surface
                                              .withOpacity(0.8),
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Divider(
                                        color: context.colorScheme.surface
                                            .withOpacity(0.2),
                                        thickness: 1,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: context.height * 0.03),
                                // Google Sign In
                                Consumer(
                                  builder: (context, ref, child) {
                                    final state = ref.watch(loginProvider);
                                    return Container(
                                      width: double.infinity,
                                      height: 56,
                                      decoration: BoxDecoration(
                                        color: context.colorScheme.surface,
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [
                                          BoxShadow(
                                            color: context.colorScheme.shadow
                                                .withOpacity(0.1),
                                            blurRadius: 10,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          onTap: state.isLoading
                                              ? null
                                              : () async {
                                                  try {
                                                    final googleUser =
                                                        await _googleSignInAuth
                                                            .signInWithGoogle();
                                                    if (googleUser != null) {
                                                      ref
                                                          .read(loginProvider
                                                              .notifier)
                                                          .loginWithGoogle(
                                                            email: googleUser
                                                                .email,
                                                            name: googleUser
                                                                    .displayName ??
                                                                "Unknown",
                                                          );
                                                    }
                                                  } catch (e) {
                                                    _showMessage(
                                                      context,
                                                      'Failed to sign in with Google: ${e.toString()}',
                                                      type: MessageType.error,
                                                    );
                                                  }
                                                },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  "assets/image/google.png",
                                                  height: 24,
                                                ),
                                                const SizedBox(width: 12),
                                                Text(
                                                  "Continue with Google",
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: context
                                                        .colorScheme.onSurface,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                const Spacer(),
                              ] else ...[
                                // OTP Input Section
                                Text(
                                  "Enter verification code",
                                  style: GoogleFonts.poppins(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                    color: context.colorScheme.surface,
                                  ),
                                ),
                                SizedBox(height: context.height * 0.02),
                                Text(
                                  "We've sent a code to ${_emailController.text}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14.sp,
                                    color: context.colorScheme.surface
                                        .withOpacity(0.8),
                                  ),
                                ),
                                SizedBox(height: context.height * 0.03),
                                OtpInputField(
                                  controller: _otpController,
                                  onCompleted: _onOtpCompleted,
                                ),
                                SizedBox(height: context.height * 0.03),
                                Consumer(
                                  builder: (context, ref, child) {
                                    final otpState =
                                        ref.watch(verifyOTPProvider);
                                    return Container(
                                      width: double.infinity,
                                      height: 56,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [
                                          BoxShadow(
                                            color: context.colorScheme.shadow
                                                .withOpacity(0.2),
                                            blurRadius: 10,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: ElevatedButton(
                                        onPressed: otpState.isLoading
                                            ? null
                                            : () {
                                                if (_otpController
                                                        .text.length ==
                                                    6) {
                                                  ref
                                                      .read(verifyOTPProvider
                                                          .notifier)
                                                      .verifyOTP(
                                                        email: _emailController
                                                            .text,
                                                        otp:
                                                            _otpController.text,
                                                      );
                                                }
                                              },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              context.colorScheme.surface,
                                          foregroundColor:
                                              context.colorScheme.primary,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          elevation: 0,
                                        ),
                                        child: otpState.isLoading
                                            ? const SizedBox(
                                                height: 20,
                                                width: 20,
                                                child:
                                                    CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(Colors.white),
                                                ),
                                              )
                                            : Text(
                                                "Verify OTP",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(height: context.height * 0.02),
                                Center(
                                  child: TextButton(
                                    onPressed: () {
                                      ref
                                          .read(otpStateProvider.notifier)
                                          .setOTPSentState(false);
                                      _emailController.clear();
                                      _otpController.clear();
                                    },
                                    child: Text(
                                      "Change Sign-in Method",
                                      style: GoogleFonts.poppins(
                                        color: context.colorScheme.surface,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                              ],

                              // Terms and Conditions
                              if (!isOTPSent) ...[
                                const Spacer(),
                                Center(
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      style: GoogleFonts.poppins(
                                        fontSize: 12.sp,
                                        color: context.colorScheme.surface
                                            .withOpacity(0.7),
                                      ),
                                      children: [
                                        const TextSpan(
                                          text:
                                              "By continuing, you agree to our ",
                                        ),
                                        TextSpan(
                                          text: "Terms of Service",
                                          style: GoogleFonts.poppins(
                                            fontSize: 12.sp,
                                            color: context.colorScheme.surface,
                                            fontWeight: FontWeight.w600,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              context.pushNamed(
                                                  TermsAndConditions.routeName);
                                            },
                                        ),
                                        const TextSpan(
                                          text: " and ",
                                        ),
                                        TextSpan(
                                          text: "Privacy Policy",
                                          style: GoogleFonts.poppins(
                                            fontSize: 12.sp,
                                            color: context.colorScheme.surface,
                                            fontWeight: FontWeight.w600,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              context.pushNamed(
                                                  PrivacyPolicyScreen
                                                      .routeName);
                                            },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: context.height * 0.02),
                                // All Rights Reserved
                                Center(
                                  child: Text(
                                    "© 2023 Hamara Ticket. All rights reserved.",
                                    style: GoogleFonts.poppins(
                                      fontSize: 12.sp,
                                      color: context.colorScheme.surface
                                          .withOpacity(0.6),
                                    ),
                                  ),
                                ),
                                SizedBox(height: context.height * 0.03),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _showMessage(BuildContext context, String message,
      {required MessageType type}) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: GoogleFonts.poppins(
          color: Colors.white,
        ),
      ),
      backgroundColor: type == MessageType.error
          ? context.colorScheme.error.withOpacity(0.8)
          : context.colorScheme.primary.withOpacity(0.8),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.all(16),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

enum MessageType { success, error, info }
