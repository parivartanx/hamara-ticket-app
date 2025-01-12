import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goevent2/utils/media.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'onbonding.dart';
import 'utils/colornotifire.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    getdarkmodepreviousstate();
    Timer(
      const Duration(seconds: 4),
      () => Navigator.pushReplacement(
          context,
          PageTransition(
              type: PageTransitionType.fade, child: const Onbonding())),
    );
  }

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
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return ScreenUtilInit(
      designSize: Size(1080, 2160),
      builder: (BuildContext context, child) => Scaffold(
        backgroundColor: notifire.getprimerycolor,
        body: Center(
          child: Container(
            color: notifire.getprimerycolor,
            child: Column(
              children: [
                SizedBox(
                  height: height / 2.5,
                ),
                Container(
                  color: Colors.transparent,
                  height: height / 7,
                  child: Image.asset("image/getevent.png"),
                ),
                SizedBox(
                  height: height / 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Go",
                      style: TextStyle(
                        fontSize: 100.sp,
                        fontFamily: 'Gilroy ExtraBold',
                        color: notifire.gettextcolor,
                      ),
                    ),
                    Text(
                      "Event",
                      style: TextStyle(
                        fontSize: 100.sp,
                        fontFamily: 'Gilroy ExtraBold',
                        color: notifire.gettext1color,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
