import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../providers/login_provider.dart';
import '../providers/login_with_email_provider.dart';
import '/config/auth/google_signin_auth.dart';
import '/extensions/media_query_ext.dart';
import '/features/home/presentation/screens/home.dart';
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
  // bool isOtpSent = false;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final _googleSignInAuth = GoogleSignInAuth();
  
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
      log("email: ${_emailController.text}");
      ref.read(loginWithEmailProvider.notifier).loginWithEmail(email: _emailController.text);
      
    }
  }
  // The dispose method is already defined in the class, so we need to remove the duplicate.


  void _onOtpCompleted(String otp) {
    // Handle OTP completion
    if (otp.length == 6) {
      ref.read(verifyOTPProvider.notifier).verifyOTP(email: _emailController.text, otp: otp);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isOTPSent = ref.watch(otpStateProvider);
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: Padding(
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
              
              if (!isOTPSent) ...[
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
                Consumer(builder: (context, ref, child) { 
                  final state = ref.watch(loginWithEmailProvider);
                  if (state.isLoading) {
                    return const CustomButton(onPressed: null, text: "Sending OTP...");
                  }
                  if (state.hasValue && state.value != null) {
                    /// show success snackbar
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _showMessage(context, state.value.toString(), type: MessageType.success);
                      ref.read(otpStateProvider.notifier).setOTPSentState(true);
                    });
                    return const CustomButton(onPressed: null, text: "Sending OTP...");
                  }
      
                  if (state.hasError) {
                    /// show error snackbar
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _showMessage(context, state.error.toString(), type: MessageType.error);
                    });
                    return const CustomButton(onPressed: null, text: "Sending OTP...");
                  }
                  return CustomButton(
                    onPressed: isLoading ? null : _handleSendOtp,
                    text: isLoading ? "Sending OTP..." : "Send OTP",
                  ); },),
                SizedBox(height: context.height * .02),
                _buildDivider(),
                SizedBox(height: context.height * .02),
                Consumer(builder: (context, ref, child) { 
                  final state = ref.watch(loginProvider);
                  return state.when(
                    data: (user) {
                      if (user != null) {
                        // Navigate to home screen on next frame
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          context.pushReplacementNamed(Home.routeName);
                          Future.delayed(const Duration(seconds: 1), () {
                            _showMessage(
                              context,
                              'Logged in as ${user.email}',
                              type: MessageType.success,
                            );
                          });
                        
                          
                        });
                        
                      }
                      return SocialButtonStyle.google(
                        onTap: () async {
                          try { 
                            final googleUser = await _googleSignInAuth.signInWithGoogle();
                            log("googleUser: ${googleUser?.id}");
                            if (googleUser != null) {
                              ref.read(loginProvider.notifier).loginWithGoogle(
                                email: googleUser.email, 
                                name: googleUser.displayName ?? "Unknown"
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
                        isLoading: isLoading,
                      );
                    },
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (error, stack) {
                      // Show error in UI
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _showMessage(
                          context,
                          'Error: ${error.toString()}',
                          type: MessageType.error,
                        );
                      });
                      return SocialButtonStyle.google(
                        onTap: () async {
                          try {
                            final googleUser = await _googleSignInAuth.signInWithGoogle();
                            if (googleUser != null) {
                              ref.read(loginProvider.notifier).loginWithGoogle(
                                email: googleUser.email, 
                                name: googleUser.displayName ?? "Unknown"
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
                        isLoading: isLoading,
                      );
                    }
                  );
                }),
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
                Consumer(builder: (context, ref, child) { 
                  final otpState = ref.watch(verifyOTPProvider);
                  if (otpState.isLoading) {
                    return const CustomButton(onPressed: null, text: "Verifying OTP...");
                  }
                  if (otpState.hasValue && otpState.value != null) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                     context.pushReplacementNamed(Home.routeName);
                     
                     Future.delayed(const Duration(seconds: 0), () {
                      _showMessage(context, otpState.value.toString(), type: MessageType.success);
                     });
                    });
                  }
                  if (otpState.hasError) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _showMessage(context, otpState.error.toString(), type: MessageType.error);
                    });
                    return  const CustomButton(onPressed: null, text: "Verifying OTP...");
                  }
                  return CustomButton(
                  onPressed: () {
      
                    if (_otpController.text.length == 6) {
                      ref.read(verifyOTPProvider.notifier).verifyOTP(email: _emailController.text, otp: _otpController.text);
                      // context.pushNamed(Home.routeName);
                      // Verify OTP logic
                    }
                  },
                  text: "Verify OTP",
                ); },),
                SizedBox(height: context.height * .02),
                Center(
                  child: TextButton(
                    onPressed: () {
                      ref.read(otpStateProvider.notifier).setOTPSentState(false);
                      _emailController.clear();
                      _otpController.clear();
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

enum MessageType { success, error, info }

void _showMessage(BuildContext context, String message, {MessageType type = MessageType.info}) {
  final messenger = ScaffoldMessenger.of(context);
  messenger.clearSnackBars(); // Clear any existing SnackBars
  
  final snackBar = SnackBar(
    content: Text(
      message,
      key: ValueKey('snackbar_message_${DateTime.now().millisecondsSinceEpoch}'),
    ),
    backgroundColor: _getMessageColor(type, context),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    margin: EdgeInsets.all(8.w),
  );
  
  messenger.showSnackBar(snackBar);
}

Color _getMessageColor(MessageType type, BuildContext context) {
  switch (type) {
    case MessageType.success:
      return Colors.green;
    case MessageType.error:
      return Colors.red;
    case MessageType.info:
      return Theme.of(context).colorScheme.secondary;
  }
}