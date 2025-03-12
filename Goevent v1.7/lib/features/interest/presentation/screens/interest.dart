import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../provider/interest_provider.dart';
import '../widgets/interest_grid.dart';
import '../widgets/interest_header.dart';
import '../widgets/next_button.dart';
import '/extensions/media_query_ext.dart';

class Interest extends ConsumerWidget {
  const Interest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final interestState = ref.watch(interestProvider);

    return ScreenUtilInit(
      builder: (BuildContext context, child) => Scaffold(
        backgroundColor: context.colorScheme.surface,
        resizeToAvoidBottomInset: false,
        floatingActionButton: NextButton(
          enabled: ref.read(interestProvider.notifier).canProceed(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BackButton(),
                SizedBox(height: 20.h),
                InterestHeader(selectedCount: interestState.selectedCount),
                SizedBox(height: 30.h),
                InterestGrid(
                  selections: interestState.selections,
                  assets: interestState.assets,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BackButton extends StatelessWidget {
  const BackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: context.colorScheme.onSurface,
      ),
      onPressed: () => Navigator.pop(context),
    );
  }
}


