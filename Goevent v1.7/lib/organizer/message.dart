import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goevent2/organizer/chat.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/colornotifire.dart';
import '../utils/media.dart';
import '../utils/string.dart';

class Message extends StatefulWidget {
  const Message({Key? key}) : super(key: key);

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height / 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: width / 25,
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
                    CustomStrings.msg,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Gilroy Medium',
                      color: notifire.getdarkscolor,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.more_vert,
                    color: notifire.getdarkscolor,
                  ),
                  SizedBox(
                    width: width / 20,
                  ),
                ],
              ),
              SizedBox(
                height: height / 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: serchfild(),
              ),
              SizedBox(
                height: height / 25,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: const Chat(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    height: height / 11,
                    width: width,
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        Image.asset(
                          "image/p1.png",
                          height: height / 15,
                        ),
                        SizedBox(
                          width: width / 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: height / 100,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Cristofer",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: 'Gilroy Medium',
                                    color: notifire.getdarkscolor,
                                  ),
                                ),
                                SizedBox(
                                  width: width / 2.6,
                                ),
                                Text(
                                  "Just Now",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontFamily: 'Gilroy Medium',
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            //SizedBox(height: height / 200,),
                            Row(
                              children: [
                                Text(
                                  "Hi:)",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontFamily: 'Gilroy Medium',
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(
                                  width: width / 1.65,
                                ),
                                Container(
                                  height: height / 25,
                                  width: width / 25,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xff29D697),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "2",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontFamily: 'Gilroy Medium',
                                        color: Colors.white,
                                      ),
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
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Divider(
                  color: Colors.grey,
                  thickness: 0.5,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade, child: const Chat()));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    height: height / 11,
                    width: width,
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        Image.asset(
                          "image/p2.png",
                          height: height / 15,
                        ),
                        SizedBox(
                          width: width / 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: height / 100,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Rocks Velkeinjen",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: 'Gilroy Medium',
                                    color: notifire.getdarkscolor,
                                  ),
                                ),
                                SizedBox(
                                  width: width / 4.3,
                                ),
                                Text(
                                  "Just Now",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontFamily: 'Gilroy Medium',
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            //SizedBox(height: height / 200,),
                            Row(
                              children: [
                                Text(
                                  "Hey, How are you?",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontFamily: 'Gilroy Medium',
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(
                                  width: width / 3.3,
                                ),
                                Container(
                                  height: height / 50,
                                  width: width / 15,
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    color: Color(0xff29D697),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "10",
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                        fontFamily: 'Gilroy Medium',
                                        color: Colors.white,
                                      ),
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
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Divider(
                  color: Colors.grey,
                  thickness: 0.5,
                ),
              ),
              chats(
                "image/p3.png",
                "David  Silbia",
                "Yeah Thanks!",
                SizedBox(
                  width: width / 3.2,
                ),
              ),
              chats(
                "image/p4.png",
                "David  Silbia",
                "Looking forward to it!",
                SizedBox(
                  width: width / 3.2,
                ),
              ),
              chats(
                "image/p1.png",
                "Rocks Velkeinjen",
                "You can take this up?",
                SizedBox(
                  width: width / 4.3,
                ),
              ),
              chats(
                "image/p2.png",
                "Roman Kutep",
                "Nothing man, cheers!",
                SizedBox(
                  width: width / 3.5,
                ),
              ),
              chats(
                "image/p3.png",
                "Alex Lee",
                "Okay, Bye!",
                SizedBox(
                  width: width / 2.7,
                ),
              ),
              chats(
                "image/p4.png",
                "Dianna",
                "Okay, Bye!",
                SizedBox(
                  width: width / 2.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget serchfild() {
    return Container(
      color: Colors.transparent,
      height: 40.h,
      child: TextField(
        style: TextStyle(color: notifire.getdarkscolor),
        decoration: InputDecoration(
          labelText: CustomStrings.find,
          labelStyle: const TextStyle(color: Colors.grey),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          suffixIcon: Padding(
              padding: const EdgeInsets.all(10),
              child: Icon(
                Icons.search,
                color: notifire.getbuttonscolor,
              )),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(20.sp),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: notifire.getbuttonscolor, width: 1),
            borderRadius: BorderRadius.circular(20.sp),
          ),
        ),
      ),
    );
  }

  Widget chats(img, name1, name2, siz) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                child: const Chat(),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              height: height / 12,
              width: width,
              color: Colors.transparent,
              child: Row(
                children: [
                  Image.asset(img, height: height / 15  ),
                  SizedBox(width: width / 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: height / 100),
                      Row(
                        children: [
                          Text(
                            name1,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Gilroy Medium',
                              color: notifire.getdarkscolor,
                            ),
                          ),
                          siz,
                          Text(
                            "Just Now",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: 'Gilroy Medium',
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        name2,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: 'Gilroy Medium',
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Divider(
            color: Colors.grey,
            thickness: 0.5,
          ),
        ),
      ],
    );
  }
}
