import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A custom filter chip widget for booking time filters
class BookingFilterChip extends ConsumerWidget {

  const BookingFilterChip({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    

    return GestureDetector(
      onTap: () {
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: EdgeInsets.only(right: 10.w),
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 8.h,
        ),
        decoration: BoxDecoration(
          // color: isSelected ? colorScheme.primary : colorScheme.surface,
          borderRadius: BorderRadius.circular(30.r),
          // boxShadow: [
          //   BoxShadow(
          //     color: isSelected
          //         ? colorScheme.primary.withOpacity(0.3)
          //         : Colors.grey.withOpacity(0.1),
          //     blurRadius: 8,
          //     offset: const Offset(0, 2),
          //   ),
          // ],
          // border: Border.all(
          //   color:
          //       isSelected ? colorScheme.primary : Colors.grey.withOpacity(0.2),
          //   width: 1,
          // ),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon(
            //   getFilterIcon(),
            //   size: 16.sp,
            //   color: isSelected ? Colors.white : colorScheme.primary,
            // ),
            // SizedBox(width: 6.w),
            // Text(
            //   filter.displayName,
            //   style: TextStyle(
            //     fontSize: 13.sp,
            //     fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            //     color: isSelected ? Colors.white : colorScheme.onSurface,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
