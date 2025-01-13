import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goevent2/providers/color_provider.dart';
import 'package:goevent2/utils/media.dart';

import '../utils/string.dart';

class About extends ConsumerStatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends ConsumerState<About> {


  @override
  void initState() {
    super.initState();
    ref.read(colorProvider.notifier).getdarkmodepreviousstate();
  }

  @override
  Widget build(BuildContext context) {
    final notifire = ref.watch(colorProvider);
    return ScreenUtilInit(
      builder:  (BuildContext context, child) =>
          Scaffold(
         backgroundColor: notifire.primaryColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: height / 30,),
              Text(
                CustomStrings.details, style: TextStyle(
                fontSize: 12.sp,
                fontFamily: 'Gilroy Normal',
                color: notifire.whiteColor,
              ),
              ),
              Text(
                CustomStrings.details, style: TextStyle(
                fontSize: 12.sp,
                fontFamily: 'Gilroy Normal',
                color: notifire.whiteColor,
              ),
              ),
              Text(
                CustomStrings.details, style: TextStyle(
                fontSize: 12.sp,
                fontFamily: 'Gilroy Normal',
                color: notifire.whiteColor,
              ),
              ),
              Text(
                CustomStrings.details, style: TextStyle(
                fontSize: 12.sp,
                fontFamily: 'Gilroy Normal',
                color: notifire.whiteColor,
              ),
              ),
              Text(
                CustomStrings.details, style: TextStyle(
                fontSize: 12.sp,
                fontFamily: 'Gilroy Normal',
                color: notifire.whiteColor,
              ),
              ),
              Text(
                CustomStrings.details, style: TextStyle(
                fontSize: 12.sp,
                fontFamily: 'Gilroy Normal',
                color: notifire.whiteColor,
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
