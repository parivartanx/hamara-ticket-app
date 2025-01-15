import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BulletPoints extends StatelessWidget {
  final List<String> points;
  const BulletPoints({required this.points, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context,child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: points
              .map(
                (point) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  child: Text(
                    '• $point',
                    style: TextStyle(fontSize: 14.sp, height: 1.5.h),
                  ),
                ),
              )
              .toList(),
        );
      }
    );
  }
}