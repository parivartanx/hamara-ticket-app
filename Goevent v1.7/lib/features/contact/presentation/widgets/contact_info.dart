import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamaraticket/extensions/media_query_ext.dart';
import 'package:hamaraticket/utils/string.dart';

class ContactInfo extends ConsumerWidget {
  const ContactInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = context.height;

    return Column(
      children: [
        Text(
          CustomStrings.working,
          style: TextStyle(
            color: context.colorScheme.onSurface,
            fontSize: 15.sp,
            fontFamily: 'Gilroy Bold',
          ),
        ),
        SizedBox(height: height / 60),
        Text(
          CustomStrings.w1,
          style: TextStyle(
            color: context.colorScheme.onSurface,
            fontSize: 12.sp,
            fontFamily: 'Gilroy Normal',
          ),
        ),
        Text(
          CustomStrings.w2,
          style: TextStyle(
            color: context.colorScheme.onSurface,
            fontSize: 12.sp,
            fontFamily: 'Gilroy Normal',
          ),
        ),
      ],
    );
  }
}
