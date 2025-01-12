import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goevent2/home/subscribe.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/botton.dart';
import '../utils/colornotifire.dart';
import '../utils/media.dart';

class Membership extends StatefulWidget {
  const Membership({Key? key}) : super(key: key);

  @override
  _MembershipState createState() => _MembershipState();
}

class _MembershipState extends State<Membership> {
  late ColorNotifire notifire;

  bool isChecked = false;
  bool isChecked1 = false;
  bool isChecked2 = false;

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
                    "Membership",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Gilroy Medium',
                      color: notifire.getdarkscolor,
                    ),
                  ),
                  SizedBox(
                    width: width / 20,
                  ),
                ],
              ),
              SizedBox(
                height: height / 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Container(
                      height: height / 6,
                      width: width,
                      decoration: BoxDecoration(
                        color: notifire.getbuttonscolor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "image/head.png",
                            height: height / 12,
                          ),
                          SizedBox(
                            width: width / 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: height / 17,
                              ),
                              Text(
                                "Join Our Premium",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Gilroy Bold',
                                    fontSize: 18.sp),
                              ),
                              Text(
                                "Unlimited Features",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Gilroy Normal',
                                    fontSize: 14.sp),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height / 60,
                    ),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            isChecked = !isChecked;
                          });
                        },
                        child: choice(
                            "Weekly",
                            "Pay for 7 days",
                            "\$9,99",
                            "",
                            isChecked
                                ? notifire.getbuttonscolor
                                : notifire.getpinkcolor,
                            isChecked ? Colors.white : Colors.black,
                            isChecked ? Colors.white : Colors.black,
                            isChecked ? Colors.white : Colors.black,
                            isChecked
                                ? notifire.getpinkcolor
                                : notifire.getbuttonscolor,
                            isChecked
                                ? notifire.getbuttonscolor
                                : notifire.getprimerycolor)),
                    SizedBox(
                      height: height / 60,
                    ),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            isChecked1 = !isChecked1;
                          });
                        },
                        child: choice(
                            "Monthly",
                            "Pay Monthly get features",
                            "\$19,99",
                            "Most Popular",
                            isChecked1
                                ? notifire.getbuttonscolor
                                : notifire.getpinkcolor,
                            isChecked1 ? Colors.white : Colors.black,
                            isChecked1 ? Colors.white : Colors.black,
                            isChecked1 ? Colors.white : Colors.black,
                            isChecked1
                                ? notifire.getpinkcolor
                                : notifire.getbuttonscolor,
                            isChecked1
                                ? notifire.getbuttonscolor
                                : notifire.getprimerycolor)),
                    SizedBox(
                      height: height / 60,
                    ),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            isChecked2 = !isChecked2;
                          });
                        },
                        child: choice(
                            "Weekly",
                            "Per for a full yearly",
                            "\$49,99",
                            "Save 12%",
                            isChecked2
                                ? notifire.getbuttonscolor
                                : notifire.getpinkcolor,
                            isChecked2 ? Colors.white : Colors.black,
                            isChecked2 ? Colors.white : Colors.black,
                            isChecked2 ? Colors.white : Colors.black,
                            isChecked2
                                ? notifire.getpinkcolor
                                : notifire.getbuttonscolor,
                            isChecked2
                                ? notifire.getbuttonscolor
                                : notifire.getprimerycolor)),
                    SizedBox(
                      height: height / 60,
                    ),
                    Text("No Commitment . Cancel anytime***",
                        style: TextStyle(
                            color: notifire.getdarkscolor,
                            fontFamily: 'Gilroy Bold',
                            fontSize: 15.sp)),
                    SizedBox(
                      height: height / 60,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                child: const Subscribe()));
                      },
                      child: Custombutton.button(
                        notifire.getbuttonscolor,
                        "Subscribe Now",
                        SizedBox(
                          width: width / 5,
                        ),
                        SizedBox(
                          width: width / 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height / 60,
                    ),
                    Text("By continue, you have agreed to our",
                        style: TextStyle(
                            color: notifire.getdarkscolor,
                            fontFamily: 'Gilroy Bold',
                            fontSize: 12.sp)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("and ",
                            style: TextStyle(
                                color: notifire.getdarkscolor,
                                fontFamily: 'Gilroy Bold',
                                fontSize: 12.sp)),
                        Text("Terms of Service Privacy Policy",
                            style: TextStyle(
                                color: notifire.getbuttonscolor,
                                fontFamily: 'Gilroy Bold',
                                fontSize: 12.sp)),
                      ],
                    ),
                    SizedBox(
                      height: height / 30,
                    ),
                    Text(
                      "EULA   |   Privacy Policy   |   Restore",
                      style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Gilroy Normal',
                          fontSize: 15.sp),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget choice(
      name1, name2, name3, name4, clr1, clr2, clr3, clr4, clr5, clr6) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 15,
      child: Container(
        decoration: BoxDecoration(
          color: clr6,
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        height: height / 10,
        width: width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.sp),
          child: Row(
            children: [
              Container(
                height: height / 37,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  shape: BoxShape.circle,
                  color: notifire.getpinkcolor,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Image.asset(
                      "image/right.png",
                      color: clr1,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: width / 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height / 35,
                  ),
                  Text(
                    name1,
                    style: TextStyle(
                      color: clr2,
                      fontSize: 14.sp,
                      fontFamily: 'Gilroy Bold',
                    ),
                  ),
                  Text(
                    name2,
                    style: TextStyle(
                      color: clr3,
                      fontSize: 12.sp,
                      fontFamily: 'Gilroy Medium',
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: height / 25,
                  ),
                  Text(
                    name3,
                    style: TextStyle(
                      color: clr4,
                      fontSize: 14.sp,
                      fontFamily: 'Gilroy Bold',
                    ),
                  ),
                  Text(
                    name4,
                    style: TextStyle(
                      color: clr5,
                      fontSize: 11.sp,
                      fontFamily: 'Gilroy Bold',
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
