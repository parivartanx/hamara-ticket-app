import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/colornotifire.dart';
import '../utils/media.dart';
import '../utils/string.dart';

class Review extends StatefulWidget {
  const Review({Key? key}) : super(key: key);

  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
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
      builder: (BuildContext context, child) =>  Scaffold(
        backgroundColor: notifire.getprimerycolor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height / 70,
              ),
              revies(CustomStrings.rocks, "image/p2.png"),
              SizedBox(
                height: height / 100,
              ),
              revies(CustomStrings.angelina, "image/p3.png"),
              SizedBox(
                height: height / 100,
              ),
              revies(CustomStrings.zenifero, "image/p4.png"),
              SizedBox(
                height: height / 100,
              ),
              revies(CustomStrings.rocks, "image/p1.png"),
              SizedBox(
                height: height / 100,
              ),
              revies(CustomStrings.angelina, "image/p2.png"),
              SizedBox(
                height: height / 100,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget revies(name, img) {
    return Container(
      height: height / 5.5,
      color: Colors.transparent,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: height / 13),
            child: Image.asset(
              img,
              height: height / 20,
            ),
          ),
          SizedBox(width: width / 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height / 100),
              Text(
                name,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontFamily: 'Gilroy Bold',
                  color: notifire.getdarkscolor,
                ),
              ),
              const Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Color(0xffFBBE47),
                  ),
                  Icon(
                    Icons.star,
                    color: Color(0xffFBBE47),
                  ),
                  Icon(
                    Icons.star,
                    color: Color(0xffFBBE47),
                  ),
                  Icon(
                    Icons.star,
                    color: Color(0xffFBBE47),
                  ),
                ],
              ),
              SizedBox(height: height / 100),
              Text(
                CustomStrings.review,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: 'Gilroy Normal',
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(bottom: height / 11),
            child: Text(
              CustomStrings.feb,
              style: TextStyle(
                fontSize: 13.sp,
                fontFamily: 'Gilroy Normal',
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
