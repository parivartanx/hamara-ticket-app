import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goevent2/login_signup/resetpass.dart';
import 'package:goevent2/payment/payment.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/colornotifire.dart';
import '../utils/media.dart';
import 'document.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  late ColorNotifire notifire;
  bool status = false;
  bool status1 = false;
  bool status2 = false;
  bool status3 = false;
  bool selectedindex = false;
  bool selectedindex1 = false;
  bool selectedindex2 = false;
  bool selectedindex3 = false;
  bool selectedindex4 = false;
  bool selectedindex5 = false;
  bool selectedindex6 = false;
  bool selectedindex7 = false;
  bool selectedindex8 = false;
  bool selectedindex9 = false;
  bool selectedindex10 = false;
  bool selectedindex11 = false;
  bool selectedindex12 = false;
  bool selectedindex13 = false;
  bool selectedindex14 = false;
  bool selectedindex15 = false;
  bool selectedindex16 = false;

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
                    width: width / 50,
                  ),
                  Text(
                    "Settings",
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
                child: Container(
                  height: height / 10,
                  width: width,
                  decoration: BoxDecoration(
                      color: notifire.getprimerycolor,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      border: Border.all(color: notifire.getbuttonscolor)),
                  child: Row(
                    children: [
                      SizedBox(
                        width: width / 30,
                      ),
                      Image.asset(
                        "image/p1.png",
                        height: height / 15,
                      ),
                      SizedBox(
                        width: width / 30,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: height / 35,
                          ),
                          Text(
                            "Jhon Smith",
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontFamily: 'Gilroy Bold',
                              color: notifire.getdarkscolor,
                            ),
                          ),
                          Text(
                            "Basic Member",
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontFamily: 'Gilroy Normal',
                              color: notifire.getbuttonscolor,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 14.sp,
                      ),
                      SizedBox(
                        width: width / 20,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height / 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: notifire.getprimerycolor,
                  child: Container(
                    decoration: BoxDecoration(
                        color: notifire.getprimerycolor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15))),
                    height: height / 4.5,
                    width: width,
                    child: Column(
                      children: [
                        Container(
                          height: height / 20,
                          width: width,
                          decoration: BoxDecoration(
                            color: notifire.getbuttonscolor,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(15),
                            ),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: width / 20,
                              ),
                              Text(
                                "Accounts",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontFamily: 'Gilroy Bold',
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: const Resetpassword(),
                              ),
                            );
                          },
                          child: lines("image/Lock.png", "Change Password"),
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: const Documents(),
                                ),
                              );
                            },
                            child: lines(
                                "image/document.png", "Document Management")),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: const Payment(),),);
                            },
                            child: lines("image/payment.png", "Payment")),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height / 60,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    "More Options",
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontFamily: 'Gilroy Bold',
                      color: notifire.getbuttonscolor,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height / 60,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: notifire.getprimerycolor,
                  child: Container(
                    decoration: BoxDecoration(
                        color: notifire.getprimerycolor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15))),
                    height: height / 3,
                    width: width,
                    child: Column(
                      children: [
                        line(
                          "image/newsletter.png",
                          "Newsletter",
                          Transform.scale(
                            scale: 0.7,
                            child: CupertinoSwitch(
                              activeColor: notifire.getbuttonscolor,
                              value: status,
                              onChanged: (value) {
                                setState(
                                  () {
                                    status = value;
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        line(
                          "image/mess.png",
                          "Text Message",
                          Transform.scale(
                            scale: 0.7,
                            child: CupertinoSwitch(
                              activeColor: notifire.getbuttonscolor,
                              value: status1,
                              onChanged: (value) {
                                setState(() {
                                  status1 = value;
                                });
                              },
                            ),
                          ),
                        ),
                        line(
                          "image/phone.png",
                          "Phone Call",
                          Transform.scale(
                            scale: 0.7,
                            child: CupertinoSwitch(
                              activeColor: notifire.getbuttonscolor,
                              value: status2,
                              onChanged: (value) {
                                setState(() {
                                  status2 = value;
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height / 100,
                        ),
                        GestureDetector(
                          onTap: () {
                            _showMyDialog();
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: width / 25,
                                ),
                                Image.asset(
                                  "image/currency.png",
                                  color: notifire.getdarkscolor,
                                  height: height / 35,
                                ),
                                SizedBox(
                                  width: width / 30,
                                ),
                                Text(
                                  "Currency",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Gilroy Normal',
                                    color: notifire.getdarkscolor,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  "\$USD",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Gilroy Normal',
                                    color: notifire.getdarkscolor,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: notifire.getdarkscolor,
                                  size: 14.sp,
                                ),
                                SizedBox(
                                  width: width / 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height / 60,
                        ),
                        GestureDetector(
                          onTap: () {
                            _showMyDialog2();
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: width / 25,
                                ),
                                Image.asset(
                                  "image/language.png",
                                  color: notifire.getdarkscolor,
                                  height: height / 35,
                                ),
                                SizedBox(
                                  width: width / 30,
                                ),
                                Text(
                                  "Language",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Gilroy Normal',
                                    color: notifire.getdarkscolor,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  "English",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Gilroy Normal',
                                    color: notifire.getdarkscolor,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: notifire.getdarkscolor,
                                  size: 14.sp,
                                ),
                                SizedBox(
                                  width: width / 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height / 100,
                        ),
                        line(
                          "image/darkmode.png",
                          "Dark Mode",
                          Transform.scale(
                            scale: 0.7,
                            child: CupertinoSwitch(
                              activeColor: notifire.getbuttonscolor,
                              value: notifire.getIsDark,
                              onChanged: (val) async {
                                final prefs =
                                    await SharedPreferences.getInstance();
                                setState(() {
                                  notifire.setIsDark = val;
                                  prefs.setBool("setIsDark", val);
                                });
                              },
                            ),
                            // CupertinoSwitch(
                            //   activeColor: notifire.getbuttonscolor,
                            //   value: status3,
                            //   onChanged: (value) {
                            //     setState(() {
                            //       status3 = value;
                            //     });
                            //   },
                            // ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _showMyDialog2() async {
    return showDialog(
      context: context, useRootNavigator: true,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: notifire.getprimerycolor,
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                color: Colors.transparent,
                height: height / 2,
                width: width / 1.1,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedindex7 = !selectedindex7;
                        });
                      },
                      child: locatename(
                          "English",
                          selectedindex7
                              ? notifire.getbuttonscolor
                              : Colors.transparent,
                          selectedindex7 ? notifire.getdarkscolor : Colors.grey,
                          selectedindex7
                              ? notifire.getdarkscolor
                              : Colors.grey),
                    ),
                    SizedBox(height: height / 100),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedindex8 = !selectedindex8;
                        });
                      },
                      child: locatename(
                          "Manchester",
                          selectedindex8
                              ? notifire.getbuttonscolor
                              : Colors.transparent,
                          selectedindex8 ? notifire.getdarkscolor : Colors.grey,
                          selectedindex8
                              ? notifire.getdarkscolor
                              : Colors.grey),
                    ),
                    SizedBox(height: height / 100),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedindex9 = !selectedindex9;
                        });
                      },
                      child: locatename(
                          "Edinburgh",
                          selectedindex9
                              ? notifire.getbuttonscolor
                              : Colors.transparent,
                          selectedindex9 ? notifire.getdarkscolor : Colors.grey,
                          selectedindex9
                              ? notifire.getdarkscolor
                              : Colors.grey),
                    ),
                    SizedBox(height: height / 100),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedindex10 = !selectedindex10;
                        });
                      },
                      child: locatename(
                          "Burmingham",
                          selectedindex10
                              ? notifire.getbuttonscolor
                              : Colors.transparent,
                          selectedindex10
                              ? notifire.getdarkscolor
                              : Colors.grey,
                          selectedindex10
                              ? notifire.getdarkscolor
                              : Colors.grey),
                    ),
                    SizedBox(height: height / 100),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedindex11 = !selectedindex11;
                        });
                      },
                      child: locatename(
                          "Bristol",
                          selectedindex11
                              ? notifire.getbuttonscolor
                              : Colors.transparent,
                          selectedindex11
                              ? notifire.getdarkscolor
                              : Colors.grey,
                          selectedindex11
                              ? notifire.getdarkscolor
                              : Colors.grey),
                    ),
                    SizedBox(height: height / 100),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedindex12 = !selectedindex12;
                        });
                      },
                      child: locatename(
                          "Liverpool",
                          selectedindex12
                              ? notifire.getbuttonscolor
                              : Colors.transparent,
                          selectedindex12
                              ? notifire.getdarkscolor
                              : Colors.grey,
                          selectedindex12
                              ? notifire.getdarkscolor
                              : Colors.grey),
                    ),
                    SizedBox(height: height / 100),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedindex13 = !selectedindex13;
                        });
                      },
                      child: locatename(
                          "Glasgow",
                          selectedindex13
                              ? notifire.getbuttonscolor
                              : Colors.transparent,
                          selectedindex13
                              ? notifire.getdarkscolor
                              : Colors.grey,
                          selectedindex13
                              ? notifire.getdarkscolor
                              : Colors.grey),
                    ),
                    SizedBox(height: height / 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              height: height / 30,
                              width: width / 5,
                              decoration: BoxDecoration(
                                color: notifire.getprimerycolor,
                                border:
                                    Border.all(color: notifire.getbuttonscolor),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "Cancle",
                                  style: TextStyle(
                                      color: notifire.getbuttonscolor,
                                      fontFamily: 'Gilroy Normal',
                                      fontSize: 12.sp),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width / 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              height: height / 30,
                              width: width / 5,
                              decoration: BoxDecoration(
                                color: notifire.getbuttonscolor,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "Submit",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Gilroy Normal',
                                      fontSize: 12.sp),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12.sp),
            ),
          ),
          title: Text(
            " Select ",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: notifire.getdarkscolor,
                fontFamily: 'Gilroy_Bold',
                fontSize: 17.sp),
          ),
        );
      },
    );
  }

  _showMyDialog() async {
    return showDialog(
      context: context, useRootNavigator: true,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: notifire.getprimerycolor,
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                color: Colors.transparent,
                height: height / 2,
                width: width / 1.1,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedindex = !selectedindex;
                        });
                      },
                      child: locatename(
                          "London",
                          selectedindex
                              ? notifire.getbuttonscolor
                              : Colors.transparent,
                          selectedindex ? notifire.getdarkscolor : Colors.grey,
                          selectedindex ? notifire.getdarkscolor : Colors.grey),
                    ),
                    SizedBox(height: height / 100),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedindex1 = !selectedindex1;
                        });
                      },
                      child: locatename(
                          "Manchester",
                          selectedindex1
                              ? notifire.getbuttonscolor
                              : Colors.transparent,
                          selectedindex1 ? notifire.getdarkscolor : Colors.grey,
                          selectedindex1
                              ? notifire.getdarkscolor
                              : Colors.grey),
                    ),
                    SizedBox(height: height / 100),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedindex2 = !selectedindex2;
                        });
                      },
                      child: locatename(
                          "Edinburgh",
                          selectedindex2
                              ? notifire.getbuttonscolor
                              : Colors.transparent,
                          selectedindex2 ? notifire.getdarkscolor : Colors.grey,
                          selectedindex2
                              ? notifire.getdarkscolor
                              : Colors.grey),
                    ),
                    SizedBox(height: height / 100),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedindex3 = !selectedindex3;
                        });
                      },
                      child: locatename(
                          "Burmingham",
                          selectedindex3
                              ? notifire.getbuttonscolor
                              : Colors.transparent,
                          selectedindex3 ? notifire.getdarkscolor : Colors.grey,
                          selectedindex3
                              ? notifire.getdarkscolor
                              : Colors.grey),
                    ),
                    SizedBox(height: height / 100),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedindex4 = !selectedindex4;
                        });
                      },
                      child: locatename(
                          "Bristol",
                          selectedindex4
                              ? notifire.getbuttonscolor
                              : Colors.transparent,
                          selectedindex4 ? notifire.getdarkscolor : Colors.grey,
                          selectedindex4
                              ? notifire.getdarkscolor
                              : Colors.grey),
                    ),
                    SizedBox(height: height / 100),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedindex5 = !selectedindex5;
                        });
                      },
                      child: locatename(
                          "Liverpool",
                          selectedindex5
                              ? notifire.getbuttonscolor
                              : Colors.transparent,
                          selectedindex5 ? notifire.getdarkscolor : Colors.grey,
                          selectedindex5
                              ? notifire.getdarkscolor
                              : Colors.grey),
                    ),
                    SizedBox(height: height / 100),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedindex6 = !selectedindex6;
                        });
                      },
                      child: locatename(
                          "Glasgow",
                          selectedindex6
                              ? notifire.getbuttonscolor
                              : Colors.transparent,
                          selectedindex6 ? notifire.getdarkscolor : Colors.grey,
                          selectedindex6
                              ? notifire.getdarkscolor
                              : Colors.grey),
                    ),
                    SizedBox(height: height / 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              height: height / 30,
                              width: width / 5,
                              decoration: BoxDecoration(
                                color: notifire.getprimerycolor,
                                border:
                                    Border.all(color: notifire.getbuttonscolor),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "Cancle",
                                  style: TextStyle(
                                      color: notifire.getbuttonscolor,
                                      fontFamily: 'Gilroy Normal',
                                      fontSize: 12.sp),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width / 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              height: height / 30,
                              width: width / 5,
                              decoration: BoxDecoration(
                                color: notifire.getbuttonscolor,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "Submit",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Gilroy Normal',
                                      fontSize: 12.sp),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12.sp),
            ),
          ),
          title: Text(
            " Select ",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: notifire.getdarkscolor,
                fontFamily: 'Gilroy_Bold',
                fontSize: 17.sp),
          ),
        );
      },
    );
  }

  Widget locatename(txt, iconcolor, textcolor, locationcolor) {
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 20.sp,
              color: locationcolor,
            ),
            SizedBox(width: width / 100),
            Text(
              txt,
              style: TextStyle(
                  fontFamily: 'Gilroy_Medium',
                  fontSize: 14.5.sp,
                  color: textcolor),
            ),
            const Spacer(),
            Icon(
              Icons.done,
              size: 17.sp,
              color: iconcolor,
            )
          ],
        ),
      ),
    );
  }

  Widget lines(img, name) {
    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
          SizedBox(
            height: height / 100,
          ),
          Row(
            children: [
              SizedBox(
                width: width / 25,
              ),
              Image.asset(
                img,
                color: notifire.getdarkscolor,
                height: height / 35,
              ),
              SizedBox(
                width: width / 30,
              ),
              Text(
                name,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Gilroy Normal',
                  color: notifire.getdarkscolor,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                color: notifire.getdarkscolor,
                size: 14.sp,
              ),
              SizedBox(
                width: width / 20,
              ),
            ],
          ),
          SizedBox(
            height: height / 100,
          ),
        ],
      ),
    );
  }

  Widget line(img, name, se) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: width / 25,
            ),
            Image.asset(
              img,
              color: notifire.getdarkscolor,
              height: height / 35,
            ),
            SizedBox(
              width: width / 30,
            ),
            Text(
              name,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                fontFamily: 'Gilroy Normal',
                color: notifire.getdarkscolor,
              ),
            ),
            const Spacer(),
            se,
            SizedBox(
              width: width / 20,
            ),
          ],
        ),
      ],
    );
  }
}
