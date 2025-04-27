import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hamaraticket/extensions/media_query_ext.dart';

class GreetingWidget extends StatelessWidget {
  final String greeting;
  final String userName;

  const GreetingWidget({
    super.key,
    required this.greeting,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '$greeting, $userName',
      style: GoogleFonts.poppins(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: context.colorScheme.onSurface,
        letterSpacing: 0.3,
        height: 1.1,
      ),
    );
  }
}
