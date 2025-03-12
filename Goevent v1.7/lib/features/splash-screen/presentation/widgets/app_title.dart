import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTitle extends StatelessWidget {
  final ColorScheme colorScheme;

  const AppTitle({
    Key? key,
    required this.colorScheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleStyle = TextStyle(
      fontSize: 100.sp,
      fontFamily: 'Gilroy ExtraBold',
      color: colorScheme.onPrimary,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Hamara", style: titleStyle),
        Text(" Ticket", style: titleStyle),
      ],
    );
  }
}