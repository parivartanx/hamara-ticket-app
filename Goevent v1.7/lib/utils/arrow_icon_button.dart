import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/extensions/media_query_ext.dart';

class ArrowIconButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  
  const ArrowIconButton({
    Key? key,
    required this.text,
    required this.backgroundColor,
    this.onPressed,
    this.isLoading = false,
    this.width,
    this.height,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? context.width,
      height: height ?? context.height * .07,
      child: Material(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: context.width*.05,),
                if (isLoading)
                  const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                else
                  Image.asset(
                    "assets/image/arrow.png",
                    width: 50,
                    height: 40,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Extension for common button styles
extension ArrowIconButtonStyle on ArrowIconButton {
  static ArrowIconButton primary(
    BuildContext context, {
    required String text,
    required VoidCallback? onPressed,
    bool isLoading = false,
  }) {
    return ArrowIconButton(
      text: text,
      backgroundColor: Theme.of(context).colorScheme.primary,
      onPressed: onPressed,
      isLoading: isLoading,
    );
  }

  static ArrowIconButton secondary(
    BuildContext context, {
    required String text,
    required VoidCallback? onPressed,
    bool isLoading = false,
  }) {
    return ArrowIconButton(
      text: text,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      onPressed: onPressed,
      isLoading: isLoading,
    );
  }
}