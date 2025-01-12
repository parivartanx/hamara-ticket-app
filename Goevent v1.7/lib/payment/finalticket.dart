import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goevent2/booking/booking.dart';
import 'package:goevent2/utils/string.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/colornotifire.dart';
import '../utils/media.dart';

class Final extends StatefulWidget {
  const Final({Key? key}) : super(key: key);

  @override
  _FinalState createState() => _FinalState();
}

class _FinalState extends State<Final> {
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
      builder: (BuildContext context, child) => Scaffold(
        backgroundColor: notifire.getbuttoncolor,
        floatingActionButton: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: SizedBox(
            height: 45.h,
            width: 410.w,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: const Booking(),
                  ),
                );
              },
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    border:
                        Border.all(color: notifire.getbuttonscolor, width: 2),
                    // color: notifire.getbuttonscolor,
                    color: Colors.white,
                  ),
                  height: height / 15,
                  width: width / 1,
                  child: Row(
                    children: [
                      SizedBox(
                        width: width / 3.5,
                      ),
                      Text(
                        "My Booking",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: width / 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 9),
                        child: Image.asset("image/arrow.png"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
                    child: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  SizedBox(
                    width: width / 80,
                  ),
                  Text(
                    "Ticket",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Gilroy Medium',
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: width / 20,
                  ),
                ],
              ),
              Stack(
                children: [
                  Image.asset(
                    "image/cards.png",
                    color: notifire.getcardcolor,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: height / 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            color: Colors.transparent,
                            height: height / 4.7,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                "image/g3.png",
                                fit: BoxFit.cover,
                                height: height / 3.7,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height / 40,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 45.sp),
                        child: Text(
                          CustomStrings.music,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Gilroy Medium',
                            color: notifire.gettextcolor,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height / 40,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: width / 8,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "NAME",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Gilroy Medium',
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                height: height / 200,
                              ),
                              Text(
                                CustomStrings.name,
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontFamily: 'Gilroy Bold',
                                  color: notifire.gettextcolor,
                                ),
                              ),
                              SizedBox(
                                height: height / 40,
                              ),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "DATE",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Gilroy Medium',
                                          color: Colors.grey,
                                        ),
                                      ),
                                      SizedBox(
                                        height: height / 200,
                                      ),
                                      Text(
                                        CustomStrings.date,
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          fontFamily: 'Gilroy Bold',
                                          color: notifire.gettextcolor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: width / 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "TIME",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Gilroy Medium',
                                          color: Colors.grey,
                                        ),
                                      ),
                                      SizedBox(
                                        height: height / 200,
                                      ),
                                      Text(
                                        CustomStrings.time,
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          fontFamily: 'Gilroy Bold',
                                          color: notifire.gettextcolor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height / 40,
                              ),
                              Text(
                                "Location",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Gilroy Medium',
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                height: height / 200,
                              ),
                              Text(
                                CustomStrings.location,
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontFamily: 'Gilroy Bold',
                                  color: notifire.gettextcolor,
                                ),
                              ),
                              SizedBox(
                                height: height / 200,
                              ),
                              Text(
                                CustomStrings.location1,
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontFamily: 'Gilroy Normal',
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height / 90,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 45.sp),
                        child:
                            Divider(color: notifire.getpinkcolor, thickness: 1),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 45.sp),
                        child: Center(
                          child: Image.asset(
                            "image/code.png",
                            height: height / 10,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
