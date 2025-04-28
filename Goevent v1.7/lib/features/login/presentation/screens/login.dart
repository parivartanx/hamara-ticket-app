import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hamaraticket/features/home/presentation/screens/bottom_nav_page.dart';
import '../providers/login_provider.dart';
import '../providers/login_with_email_provider.dart';
import '/config/auth/google_signin_auth.dart';
import '/extensions/media_query_ext.dart';
import '/features/terms-and-conditions/screens/terms_and_conditions.dart';
import '/features/privacy-policy/privacy_policy.dart';

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
    _fadeAnimation.removeListener(() {});
    _slideAnimation.removeListener(() {});
    _animationController.removeListener(() {});
    _animationController.dispose();
    super.dispose();
  }

  // String? _validateEmail(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Email is required';
  //   }
  //   final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  //   if (!emailRegex.hasMatch(value)) {
  //     return 'Please enter a valid email';
  //   }
  //   return null;
  // }

  // Future<void> _handleSendOtp() async {
  //   if (_formKey.currentState?.validate() ?? false) {
  //     try {
  //       log("Attempting to send OTP to email: ${_emailController.text}");
  //       await ref
  //           .read(loginWithEmailProvider.notifier)
  //           .loginWithEmail(email: _emailController.text);
  //     } catch (e) {
  //       log("Error sending OTP: $e");
  //       _showMessage(
  //         context,
  //         'Failed to send OTP: ${e.toString()}',
  //         type: MessageType.error,
  //       );
  //     }
  //   }
  // }

  // void _onOtpCompleted(String otp) {
  //   if (otp.length == 6) {
  //     try {
  //       log("Attempting to verify OTP for email: ${_emailController.text}");
  //       ref
  //           .read(verifyOTPProvider.notifier)
  //           .verifyOTP(email: _emailController.text, otp: otp);
  //     } catch (e) {
  //       log("Error verifying OTP: $e");
  //       _showMessage(
  //         context,
  //         'Failed to verify OTP: ${e.toString()}',
  //         type: MessageType.error,
  //       );
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final isOTPSent = ref.watch(otpStateProvider);
    return Scaffold(
      body: SafeArea(
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
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
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
                                  context.go(BottomNavPage.routePath);
                                },
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                ),
                                child: Text(
                                  "Skip",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: context.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: context.height * 0.05),
                            // Logo and App Name
                            Center(
                              child: Hero(
                                tag: 'app-logo',
                                child: Container(
                                  padding: const EdgeInsets.all(16),
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
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                            SizedBox(height: context.height * 0.01),
                            Center(
                              child: Text(
                                "Welcome Back",
                                style: GoogleFonts.poppins(
                                  fontSize: 16.sp,
                                  color: Colors.black54,
                                  letterSpacing: 0.2,
                                ),
                              ),
                            ),
                            SizedBox(height: context.height * 0.06),
                            // if (!isOTPSent) ...[
                            //   // Email Input
                            //   Container(
                            //     decoration: BoxDecoration(
                            //       color: Color.alphaBlend(
                            //         context.colorScheme.surfaceContainerHighest.withAlpha(25),
                            //         context.colorScheme.surfaceContainerHighest,
                            //       ),
                            //       borderRadius: BorderRadius.circular(12),
                            //       border: Border.all(
                            //         color: Color.alphaBlend(
                            //           context.colorScheme.outline.withAlpha(51),
                            //           context.colorScheme.outline,
                            //         ),
                            //         width: 1,
                            //       ),
                            //     ),
                            //     child: CustomTextField(
                            //       controller: _emailController,
                            //       hint: "Email",
                            //       prefixIcon: Icons.email_outlined,
                            //       validator: _validateEmail,
                            //       keyboardType: TextInputType.emailAddress,
                            //       textInputAction: TextInputAction.done,
                            //       onFieldSubmitted: (_) => _handleSendOtp(),
                            //     ),
                            //   ),
                            //   SizedBox(height: context.height * 0.03),
                            //   // Send OTP Button
                            //   Consumer(
                            //     builder: (context, ref, child) {
                            //       final state = ref.watch(loginWithEmailProvider);
                            //       return SizedBox(
                            //         width: double.infinity,
                            //         height: 52,
                            //         child: ElevatedButton(
                            //           onPressed: state.isLoading
                            //               ? null
                            //               : _handleSendOtp,
                            //           style: ElevatedButton.styleFrom(
                            //             backgroundColor: context.colorScheme.primary,
                            //             foregroundColor: context.colorScheme.onPrimary,
                            //             shape: RoundedRectangleBorder(
                            //               borderRadius: BorderRadius.circular(12),
                            //             ),
                            //             elevation: 0,
                            //           ),
                            //           child: state.isLoading
                            //               ? SizedBox(
                            //                   height: 20,
                            //                   width: 20,
                            //                   child: CircularProgressIndicator(
                            //                     strokeWidth: 2,
                            //                     valueColor:
                            //                         AlwaysStoppedAnimation<Color>(
                            //                             context.colorScheme.onPrimary),
                            //                   ),
                            //                 )
                            //               : Text(
                            //                   "Continue with Email",
                            //                   style: GoogleFonts.poppins(
                            //                     fontSize: 16.sp,
                            //                     fontWeight: FontWeight.w500,
                            //                   ),
                            //                 ),
                            //         ),
                            //       );
                            //     },
                            //   ),
                            //   SizedBox(height: context.height * 0.03),
                            //   // Divider
                            //   Row(
                            //     children: [
                            //       Expanded(
                            //         child: Divider(
                            //           color: Colors.grey[300],
                            //           thickness: 1,
                            //         ),
                            //       ),
                            //       Padding(
                            //         padding: const EdgeInsets.symmetric(
                            //             horizontal: 16),
                            //         child: Text(
                            //           "OR",
                            //           style: GoogleFonts.poppins(
                            //             color: Colors.grey[600],
                            //             fontSize: 14.sp,
                            //           ),
                            //         ),
                            //       ),
                            //       Expanded(
                            //         child: Divider(
                            //           color: Colors.grey[300],
                            //           thickness: 1,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            //   SizedBox(height: context.height * 0.03),
                              // Google Sign In
                              Consumer(
                                builder: (context, ref, child) {
                                  final state = ref.watch(loginProvider);
                                  return Container(
                                    width: double.infinity,
                                    height: 52,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: Colors.grey[300]!,
                                        width: 1,
                                      ),
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(12),
                                        onTap: state.isLoading || isLoading
                                            ? null
                                            : () async {
                                                setState(() {
                                                  isLoading = true;
                                                });

                                                try {
                                                  log("Login: Starting Google Sign-in process");
                                                  final googleUser =
                                                      await _googleSignInAuth
                                                          .signInWithGoogle();

                                                  if (googleUser == null) {
                                                    log(
                                                        "Login: Google sign-in was canceled by the user $googleUser");
                                                    if (mounted) {
                                                      setState(() {
                                                        isLoading = false;
                                                      });
                                                      _showMessage(
                                                        context,
                                                        'Sign-in cancelled',
                                                        type: MessageType.info,
                                                      );
                                                    }
                                                    return;
                                                  }

                                                  await ref
                                                      .read(loginProvider.notifier)
                                                      .loginWithGoogle(
                                                        email: googleUser.email,
                                                        name: googleUser
                                                                .displayName ??
                                                            "Guest",
                                                      );

                                                  if (mounted) {
                                                    context.go(BottomNavPage.routePath);
                                                  }
                                                } catch (e) {
                                                  log("Login: Error during Google sign-in: $e");
                                                  if (mounted) {
                                                    _showMessage(
                                                      context,
                                                      'Failed to sign in: ${e.toString()}',
                                                      type: MessageType.error,
                                                    );
                                                  }
                                                } finally {
                                                  if (mounted) {
                                                    setState(() {
                                                      isLoading = false;
                                                    });
                                                  }
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
                                                  color: Colors.black87,
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
                            // ] else ...[
                            //   // OTP Section
                            //   OtpSection(
                            //     onChangeSignInMethod: () {
                            //       ref.read(otpStateProvider.notifier).setOTPSentState(false);
                            //       _emailController.clear();
                            //       _otpController.clear();
                            //     },
                            //     otpController: _otpController,
                            //     onOtpCompleted: _onOtpCompleted,
                            //     email: _emailController.text,
                            //   ),
                            // ],

                            // Terms and Conditions
                            if (!isOTPSent) ...[
                              const Spacer(),
                              Center(
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    style: GoogleFonts.poppins(
                                      fontSize: 12.sp,
                                      color: Colors.black54,
                                    ),
                                    children: [
                                      const TextSpan(
                                        text: "By continuing, you agree to our ",
                                      ),
                                      TextSpan(
                                        text: "Terms of Service",
                                        style: GoogleFonts.poppins(
                                          fontSize: 12.sp,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w500,
                                          decoration: TextDecoration.underline,
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
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w500,
                                          decoration: TextDecoration.underline,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            context.pushNamed(
                                                PrivacyPolicyScreen.routeName);
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
                                    color: Colors.black45,
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
    );
  }

  void _showMessage(BuildContext context, String message,
      {required MessageType type}) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: GoogleFonts.poppins(
          color: context.colorScheme.onError,
        ),
      ),
      backgroundColor: type == MessageType.error
          ? context.colorScheme.error
          : type == MessageType.success
              ? context.colorScheme.primary
              : context.colorScheme.surface,
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
