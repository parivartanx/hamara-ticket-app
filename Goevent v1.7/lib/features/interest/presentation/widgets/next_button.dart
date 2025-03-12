import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/extensions/media_query_ext.dart';
import '../../../home/presentation/screens/home.dart';
import 'package:page_transition/page_transition.dart';

class NextButton extends ConsumerWidget {
  final bool enabled;

  const NextButton({Key? key, required this.enabled}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton.extended(
      onPressed: enabled
          ? () => Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: const Home(),
                ),
              )
          : null,
      backgroundColor: context.colorScheme.primary,
      label: Text(
        'NEXT',
        style: TextStyle(
          color: context.colorScheme.onPrimary,
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}