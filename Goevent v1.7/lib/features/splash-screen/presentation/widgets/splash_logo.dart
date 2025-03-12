import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamaraticket/extensions/media_query_ext.dart';

class SplashLogo extends StatelessWidget {
  const SplashLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height / 7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50.r),
        child: Image.asset("assets/image/hamara-ticket-logo.png"),
      ),
    );
  }
}
