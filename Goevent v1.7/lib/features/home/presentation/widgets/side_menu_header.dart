import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/extensions/media_query_ext.dart';

class SideMenuHeader extends StatelessWidget {
  const SideMenuHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            "assets/image/p1.png",
            height: context.height * .1,
          ),
          SizedBox(height: context.height * .02),
          Text(
            "Ashfak Sayem",
            style: TextStyle(
              fontSize: 15.sp,
              fontFamily: 'Gilroy Medium',
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}