import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:hamaraticket/providers/color_provider.dart';

class CustomAppbar extends ConsumerWidget {
  final String title;
  const CustomAppbar({super.key,required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifire = ref.watch(colorProvider);
    return ScreenUtilInit(builder: (context, child) {
      return Row(
        children: [
          // SizedBox(
          //   width: context.width / 20,
          // ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: notifire.darksColor),
          ),
          SizedBox(
            width: context.width / 80,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w900,
              fontFamily: 'Gilroy Medium',
              color: notifire.darksColor,
            ),
          ),
          const Spacer(),
          Icon(
            Icons.more_vert,
            color: notifire.darksColor,
          ),
          
        ],
      );
    });
  }
}
