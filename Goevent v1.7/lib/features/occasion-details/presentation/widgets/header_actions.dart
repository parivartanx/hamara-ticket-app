import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/extensions/media_query_ext.dart';

class HeaderActions extends StatelessWidget {
  final String title;
  final bool showSaveButton;

  const HeaderActions({
    super.key,
    required this.title,
    this.showSaveButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: context.width / 20),
        const BackButton(color: Colors.white),
        SizedBox(width: context.width / 80),
        Text(
          title,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w900,
            fontFamily: 'Gilroy Medium',
            color: Colors.white,
          ),
        ),
        if (showSaveButton) ...[
          const Spacer(),
          Container(
            height: 35.h,
            width: 35.h,
            margin: EdgeInsets.only(right: 20.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: const Icon(
              Icons.bookmark_border,
              color: Colors.white,
            ),
          ),
        ],
      ],
    );
  }
}