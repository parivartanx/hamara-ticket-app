import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamaraticket/extensions/media_query_ext.dart';

class InterestHeader extends StatelessWidget {
  final int selectedCount;

  const InterestHeader({Key? key, required this.selectedCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Select 5 your Interest ($selectedCount/5)",
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
          fontFamily: 'Gilroy Medium',
          color: context.colorScheme.onSurface,
        ),
      ),
    );
  }
}