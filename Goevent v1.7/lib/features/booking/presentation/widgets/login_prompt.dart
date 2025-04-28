import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../extensions/media_query_ext.dart';

/// A reusable widget for displaying a login prompt with customizable content
class LoginPrompt extends StatelessWidget {
  /// The animation controller for fade in animation
  final AnimationController? animationController;
  
  /// Title text to display
  final String title;
  
  /// Description message to display
  final String message;
  
  /// Text for the login button
  final String buttonText;
  
  /// Route name to navigate to when login button is pressed
  final String routeName;
  
  /// Optional icon to display, defaults to account circle
  final IconData icon;
  
  /// Optional callback for when the button is pressed
  /// If not provided, will use default navigation behavior
  final VoidCallback? onButtonPressed;

  const LoginPrompt({
    super.key,
    this.animationController,
    this.title = 'Please Login to Continue',
    this.message = 'You need to be logged in to access this feature.',
    this.buttonText = 'Login Now',
    required this.routeName,
    this.icon = Icons.account_circle_outlined,
    this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    final content = Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 80.sp,
              color: context.colorScheme.primary,
            ),
            SizedBox(height: 16.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: context.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: 32.h),
            ElevatedButton(
              onPressed: onButtonPressed ?? () {
                context.pushNamed(routeName);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: context.colorScheme.primary,
                foregroundColor: context.colorScheme.onPrimary,
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                buttonText,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    // Apply fade animation if controller is provided
    if (animationController != null) {
      return FadeTransition(
        opacity: animationController!,
        child: content,
      );
    }
    
    return content;
  }
}