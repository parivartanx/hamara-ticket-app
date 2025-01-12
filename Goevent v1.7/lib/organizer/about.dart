import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goevent2/utils/media.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/colornotifire.dart';
import '../utils/string.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
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
    return ScreenUtilInit(
      builder:  (BuildContext context, child) =>
          Scaffold(
         backgroundColor: notifire.getprimerycolor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: height / 30,),
              Text(
                CustomStrings.details, style: TextStyle(
                fontSize: 12.sp,
                fontFamily: 'Gilroy Normal',
                color: notifire.getwhitecolor,
              ),
              ),
              Text(
                CustomStrings.details, style: TextStyle(
                fontSize: 12.sp,
                fontFamily: 'Gilroy Normal',
                color: notifire.getwhitecolor,
              ),
              ),
              Text(
                CustomStrings.details, style: TextStyle(
                fontSize: 12.sp,
                fontFamily: 'Gilroy Normal',
                color: notifire.getwhitecolor,
              ),
              ),
              Text(
                CustomStrings.details, style: TextStyle(
                fontSize: 12.sp,
                fontFamily: 'Gilroy Normal',
                color: notifire.getwhitecolor,
              ),
              ),
              Text(
                CustomStrings.details, style: TextStyle(
                fontSize: 12.sp,
                fontFamily: 'Gilroy Normal',
                color: notifire.getwhitecolor,
              ),
              ),
              Text(
                CustomStrings.details, style: TextStyle(
                fontSize: 12.sp,
                fontFamily: 'Gilroy Normal',
                color: notifire.getwhitecolor,
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
