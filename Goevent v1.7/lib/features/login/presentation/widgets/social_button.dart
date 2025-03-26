import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamaraticket/extensions/media_query_ext.dart';

class SocialButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;
  final String icon;
  final bool isLoading;
  final String? semanticsLabel;
  final Color? backgroundColor;
  final Color? textColor;
  final EdgeInsets? padding;

  const SocialButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.icon,
    this.isLoading = false,
    this.semanticsLabel,
    this.backgroundColor,
    this.textColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      enabled: onTap != null && !isLoading,
      label: semanticsLabel ?? 'Continue with $text',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: (isLoading || onTap == null) ? null : onTap,
          borderRadius: BorderRadius.circular(12),
          child: Ink(
            height: 60,
            decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(
                color: context.colorScheme.outline.withAlpha(100),
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isLoading)
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          textColor ?? context.colorScheme.onSurface,
                        ),
                      ),
                    )
                  else
                    Image.asset(icon, height: 24),
                  SizedBox(width: 12.w),
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: textColor ?? context.colorScheme.onSurface,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Extension for common social button styles
extension SocialButtonStyle on SocialButton {
  static SocialButton google({
    required VoidCallback? onTap,
    bool isLoading = false,
    String text = "Continue with Google",
  }) {
    return SocialButton(
      onTap: onTap,
      text: text,
      icon: "assets/image/google.png",
      isLoading: isLoading,
      semanticsLabel: "Sign in with Google account",
    );
  }

  static SocialButton facebook({
    required VoidCallback? onTap,
    bool isLoading = false,
    String text = "Continue with Facebook",
  }) {
    return SocialButton(
      onTap: onTap,
      text: text,
      icon: "assets/image/facebook.png",
      isLoading: isLoading,
      semanticsLabel: "Sign in with Facebook account",
      backgroundColor: const Color(0xFF1877F2),
      textColor: Colors.white,
    );
  }
}