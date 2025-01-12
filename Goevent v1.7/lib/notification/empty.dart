import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/colornotifire.dart';
import '../utils/media.dart';
import '../utils/string.dart';

class Empty extends StatefulWidget {
  const Empty({Key? key}) : super(key: key);

  @override
  _EmptyState createState() => _EmptyState();
}

class _EmptyState extends State<Empty> {
  late ColorNotifire notifire;

  getdarkmodepreviousstate() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previusstate = prefs.getBool("setIsDark");
    if (previusstate == null) {
      notifire.setIsDark = false;
    } else {
      notifire.setIsDark = previusstate;
    }
  }

  @override
  void initState() {
    super.initState();
    getdarkmodepreviousstate();
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return ScreenUtilInit(builder:  (BuildContext context, child) =>  Scaffold(
      backgroundColor: notifire.getprimerycolor,
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
                  Icon(Icons.arrow_back, color: notifire.getdarkscolor),
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
                    color: notifire.getdarkscolor,
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
              color: notifire.gettextcolor,
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
