import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goevent2/profile/editprofile.dart';
import 'package:goevent2/utils/string.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/colornotifire.dart';
import '../utils/media.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
      builder:  (BuildContext context, child) =>  Scaffold(
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
                    "Profile",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Gilroy Medium',
                      color: notifire.getdarkscolor,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height / 25,
              ),
              Image.asset(
                "image/p2.png",
                height: height / 9,
              ),
              SizedBox(
                height: height / 40,
              ),
              Text(
                "Ashfak Sayem",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Gilroy Medium',
                  color: notifire.getdarkscolor,
                ),
              ),
              SizedBox(
                height: height / 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        "350",
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Gilroy Medium',
                          color: notifire.getdarkscolor,
                        ),
                      ),
                      SizedBox(
                        height: height / 120,
                      ),
                      Text(
                        "Following",
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontFamily: 'Gilroy Medium',
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: width / 30,
                  ),
                  Container(
                    height: height / 20,
                    color: Colors.grey,
                    width: width / 200,
                  ),
                  SizedBox(
                    width: width / 30,
                  ),
                  Column(
                    children: [
                      Text(
                        "346",
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Gilroy Medium',
                          color: notifire.getdarkscolor,
                        ),
                      ),
                      SizedBox(
                        height: height / 120,
                      ),
                      Text(
                        "Followers",
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontFamily: 'Gilroy Medium',
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: height / 40,
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          child: const Edit()));
                },
                child: Container(
                  height: height / 17,
                  width: width / 2.8,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      border: Border.all(
                          color: notifire.getbuttonscolor, width: 1.5)),
                  child: Row(
                    children: [
                      SizedBox(
                        width: width / 30,
                      ),
                      Image.asset(
                        "image/edit.png",
                        height: height / 35,
                      ),
                      SizedBox(
                        width: width / 30,
                      ),
                      Text(
                        "Edit Profile",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: 'Gilroy Medium',
                          color: notifire.getbuttonscolor,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height / 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      CustomStrings.about,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Gilroy Medium',
                        color: notifire.gettextcolor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height / 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        CustomStrings.readmore,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Gilroy Medium',
                          color: notifire.gettextcolor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height / 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      CustomStrings.interest,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Gilroy Medium',
                        color: notifire.gettextcolor,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      height: height / 30,
                      width: width / 5,
                      decoration: BoxDecoration(
                        color: notifire.getpinkcolor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            "image/edit1.png",
                            height: height / 50,
                          ),
                          Text(
                            "CHANGE",
                            style: TextStyle(
                              fontSize: 9.sp,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Gilroy Medium',
                              color: notifire.getbuttonscolor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height / 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    game(notifire.getbuttonscolor,"Games Online"),
                    game(const Color(0xffEE544A),"Concert"),
                    game(const Color(0xffFF8D5D),"Music"),
                    game(const Color(0xff7D67EE),"Art"),
                  ],
                ),
              ),
              SizedBox(
                height: height / 60,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    game(const Color(0xff29D697),"Movie"),
                    SizedBox(width: width / 30,),
                    game(const Color(0xff39D1F2),"Others"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget game(clr,name) {
    return Container(
      height: height / 25,
      decoration: BoxDecoration(
        color: clr,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Center(
          child: Text(
            name,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              fontFamily: 'Gilroy Medium',
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
