import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goevent2/providers/color_provider.dart';

import '../utils/media.dart';
import '../utils/string.dart';

class Empty extends ConsumerStatefulWidget {
  const Empty({Key? key}) : super(key: key);

  @override
  _EmptyState createState() => _EmptyState();
}

class _EmptyState extends ConsumerState<Empty> {

  @override
  void initState() {
    super.initState();
    ref.read(colorProvider.notifier).getdarkmodepreviousstate();
  }

  @override
  Widget build(BuildContext context) {
    final notifire = ref.watch(colorProvider);
    return ScreenUtilInit(builder:  (BuildContext context, child) =>  Scaffold(
      backgroundColor: notifire.primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height / 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: width / 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child:
                  Icon(Icons.arrow_back, color: notifire.darksColor),
                ),
                SizedBox(
                  width: width / 80,
                ),
                Text(
                  CustomStrings.notification,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Gilroy Medium',
                    color: notifire.darksColor,
                  ),
                ),
                const Spacer(),
                const Icon(Icons.more_vert),
                SizedBox(
                  width: width / 20,
                ),
              ],
            ),
            SizedBox(
              height: height / 7,
            ),
            Image.asset("image/notification.png",height: height / 3,),
            Text(CustomStrings.no, style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w900,
              fontFamily: 'Gilroy Medium',
              color: notifire.textColor,
            ),),
            SizedBox(
              height: height / 50,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(CustomStrings.notificationdetails,textAlign: TextAlign.center, style: TextStyle(
                  fontSize: 15.sp,
                  fontFamily: 'Gilroy Medium',
                  color: Colors.grey,
                ),),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
