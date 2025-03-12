import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamaraticket/extensions/media_query_ext.dart';

class ContactAppBar extends ConsumerWidget {
  final double width;

  const ContactAppBar({
    required this.width,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Row(
      children: [
        SizedBox(width: width / 20),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back, color: context.colorScheme.surface),
        ),
        SizedBox(width: width / 80),
        Text(
          "Contact us",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w900,
            fontFamily: 'Gilroy Medium',
            color: context.colorScheme.surface,
          ),
        ),
        const Spacer(),
        Icon(Icons.more_vert, color: context.colorScheme.onSurface),
        SizedBox(width: width / 20),
      ],
    );
  }
}