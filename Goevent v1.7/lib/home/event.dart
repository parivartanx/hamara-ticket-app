import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goevent2/home/ticket.dart';
import 'package:goevent2/organizer/oprofile.dart';
import 'package:goevent2/utils/media.dart';
import 'package:goevent2/utils/string.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/botton.dart';
import '../utils/colornotifire.dart';

class Events extends StatefulWidget {
  const Events({Key? key}) : super(key: key);

  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
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
        backgroundColor: notifire.getprimerycolor,
        floatingActionButton: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: SizedBox(
            height: 45.h,
            width: 410.w,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: const Ticket(),
                  ),
                );
              },
              child: Custombutton.button(
                notifire.getbuttonscolor,
                CustomStrings.buy,
                SizedBox(width: width / 4.5),
                SizedBox(width: width / 20),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    color: Colors.transparent,
                    width: width,
                    height: height / 4,
                    child: Image.asset(
                      "image/event.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(height: height / 20),
                      Row(
                        children: [
                          SizedBox(width: width / 20),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.arrow_back,
                                color: Colors.white),
                          ),
                          SizedBox(width: width / 80),
                          Text(
                            CustomStrings.events,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Gilroy Medium',
                              color: Colors.white,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            height: height / 25,
                            width: width / 12,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.20),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(7),
                              child: Image.asset(
                                "image/save.png",
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                        ],
                      ),
                      SizedBox(height: height / 8.5),
                      Container(
                        decoration: BoxDecoration(
                          color: notifire.getprimerycolor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                        width: width / 1.4,
                        height: height / 14,
                        child: Card(
                          color: notifire.getprimerycolor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(top: height / 80),
                            child: Row(
                              children: [
                                SizedBox(width: width / 40),
                                Stack(
                                  children: [
                                    Column(
                                      children: [
                                        Image.asset(
                                          "image/p1.png",
                                          height: height / 30,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: width / 20,
                                        ),
                                        Stack(
                                          children: [
                                            Image.asset(
                                              "image/p2.png",
                                              height: height / 30,
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: width / 20,
                                                ),
                                                Stack(
                                                  children: [
                                                    Image.asset(
                                                      "image/p3.png",
                                                      height: height / 30,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "  + 20 Going",
                                          style: TextStyle(
                                            color: const Color(0xff5d56f3),
                                            fontSize: 12.sp,
                                            fontFamily: 'Gilroy Bold',
                                          ),
                                        ),
                                        SizedBox(width: width / 10),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            height: height / 30,
                                            width: width / 6,
                                            color: const Color(0xff5669ff),
                                            child: Center(
                                              child: Text(
                                                "Invite",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12.sp,
                                                  fontFamily: 'Gilroy Bold',
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: height / 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  CustomStrings.music,
                  style: TextStyle(
                    fontSize: 35.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Gilroy Medium',
                    color: notifire.getdarkscolor,
                  ),
                ),
              ),
              SizedBox(height: height / 40),
              concert("image/date.png", "14 December, 2021",
                  "Tuesday, 4:00PM - 9:00PM"),
              SizedBox(height: height / 40),
              concert("image/direction.png", "Gala Convention Center",
                  "36 Guild Street London, UK"),
              SizedBox(height: height / 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: const Organize(),
                      ),
                    );
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        Container(
                          height: height / 15,
                          width: width / 7,
                          decoration: BoxDecoration(
                            color: notifire.getcardcolor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Image.asset("image/p1.png"),
                          ),
                        ),
                        SizedBox(width: width / 38),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Ashfak Sayem",
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Gilroy Medium',
                                color: notifire.getdarkscolor,
                              ),
                            ),
                            SizedBox(height: height / 300),
                            Text(
                              "Organizer",
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Gilroy Medium',
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: const Organize(),
                              ),
                            );
                          },
                          child: Container(
                            height: height / 30,
                            width: width / 6,
                            color: notifire.getcardcolor,
                            child: Center(
                              child: Text(
                                "Follow",
                                style: TextStyle(
                                  color: const Color(0xff5669ff),
                                  fontSize: 12.sp,
                                  fontFamily: 'Gilroy Bold',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: height / 40),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    Text(
                      "About Event",
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Gilroy Medium',
                        color: notifire.gettextcolor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height / 40),
              Container(
                color: Colors.transparent,
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height * 0.35,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 15),
                  child: Text(
                    "With the variability and ever-changing landscape of social media, there’s value in reaching our audience where they are most likely to see and read our messages. "
                    "That’s why we text,” notes Digital Marketing Specialist for the festival Kyle HuenderWith the variability and ever-changing landscape of social media, there’s value in reaching our audience With the variability and ever-changing landscape of"
                    "social media, there’s value in reaching our audience where they are most likely to see and read our messages. That’s why we text,” notes Digital Marketing Specialist "
                    "for the festival Kyle HuenderWith the variability and ever-changing landscape of social media, there’s value in reaching our audience",
                    style: TextStyle(
                      fontSize: 12.2.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Gilroy Medium',
                      color: Colors.grey,
                    ),
                    maxLines: 12,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              SizedBox(height: height / 60),
            ],
          ),
        ),
      ),
    );
  }

  Widget concert(img, name1, name2) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Container(
            height: height / 15,
            width: width / 7,
            decoration: BoxDecoration(
              color: notifire.getcardcolor,
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Image.asset(img),
            ),
          ),
          SizedBox(width: width / 40),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name1,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Gilroy Medium',
                  color: notifire.getdarkscolor,
                ),
              ),
              SizedBox(height: height / 300),
              Text(
                name2,
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Gilroy Medium',
                  color: Colors.grey,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
