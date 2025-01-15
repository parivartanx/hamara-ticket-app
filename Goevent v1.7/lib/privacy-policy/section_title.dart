import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamaraticket/providers/color_provider.dart';

class SectionTitle extends ConsumerWidget {
  final String title;
  final bool isSubsection;

  const SectionTitle({required this.title, this.isSubsection = false, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(colorProvider);
    return ScreenUtilInit(
      builder: (context,child) {
        return Text(
          title,
          style: TextStyle(
            color:isSubsection?notifier.proColor: notifier.buttonColor ,
            fontSize: isSubsection ? 18.sp : 20.sp,
            fontWeight: isSubsection ? FontWeight.w500 : FontWeight.bold,
          ),
        );
      }
    );
  }
}

