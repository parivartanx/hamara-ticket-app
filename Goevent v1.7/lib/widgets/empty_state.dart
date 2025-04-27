import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../extensions/media_query_ext.dart';

/// A reusable empty state widget that can be used across the app
class EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final Widget? action;
  
  const EmptyState({
    Key? key,
    required this.icon,
    required this.title,
    required this.message,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 80.w,
              color: colorScheme.primary.withOpacity(0.7),
            ),
            SizedBox(height: 20.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              style: TextStyle(
                fontSize: 14.sp,
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            if (action != null) SizedBox(height: 24.h),
            if (action != null) action!,
          ],
        ),
      ),
    );
  }
} 