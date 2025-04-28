import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../profile/presentation/providers/profile_provider.dart';
import '/extensions/media_query_ext.dart';

class SideMenuHeader extends ConsumerWidget {
  const SideMenuHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final userState = ref.watch(profileProvider);
    final userName = userState.when(
      data: (profile) => profile?.name,
      loading: () => null,
      error: (_, __) => null,
    );
    
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 30.r,
            backgroundColor: context.colorScheme.primaryContainer,
            child: Icon(
              Icons.person,
              size: 40.sp,
              color: context.colorScheme.onPrimaryContainer,
            ),
          ),
          SizedBox(height: context.height * .02),
          Text(
            userName ?? "Guest",
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