import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goevent2/extensions/media_query_ext.dart';
import 'package:goevent2/login_signup/resetpass.dart';
import 'package:goevent2/payment/payment.dart';
import 'package:goevent2/providers/color_provider.dart';
import 'package:page_transition/page_transition.dart';

import 'document.dart';

class Setting extends ConsumerStatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends ConsumerState<Setting> {
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

 
  @override
  void initState() {
    super.initState();
    ref.read(colorProvider.notifier).getdarkmodepreviousstate();
  }

  @override
  Widget build(BuildContext context) {
    final notifire = ref.watch(colorProvider);
    final height = context.height;
    final width = context.width;
    
    return ScreenUtilInit(
      builder:  (BuildContext context, child) =>  Scaffold(
        backgroundColor: notifire.primaryColor,
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
                        Icon(Icons.arrow_back, color: notifire.darksColor),
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
                      color: notifire.darksColor,
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
                      color: notifire.primaryColor,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      border: Border.all(color: notifire.buttonsColor)),
                  child: Row(
                    children: [
                      SizedBox(
                        width: width / 30,
                      ),
                      Image.asset(
                        "assets/image/p1.png",
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
                              color: notifire.darksColor,
                            ),
                          ),
                          Text(
                            "Basic Member",
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontFamily: 'Gilroy Normal',
                              color: notifire.buttonsColor,
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
                  color: notifire.primaryColor,
                  child: Container(
                    decoration: BoxDecoration(
                        color: notifire.primaryColor,
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
                            color: notifire.buttonsColor,
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
                          child: lines("assets/image/Lock.png", "Change Password",notifire),
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
                                "assets/image/document.png", "Document Management",notifire)),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: const Payment(),),);
                            },
                            child: lines("assets/image/payment.png", "Payment",notifire)),
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
                      color: notifire.buttonsColor,
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
                  color: notifire.primaryColor,
                  child: Container(
                    decoration: BoxDecoration(
                        color: notifire.primaryColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15))),
                    height: height / 3,
                    width: width,
                    child: Column(
                      children: [
                        line(
                          "assets/image/newsletter.png",
                          "Newsletter",
                          Transform.scale(
                            scale: 0.7,
                            child: CupertinoSwitch(
                              activeTrackColor: notifire.buttonsColor,
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
                          notifire,
                        ),
                        line(
                          "assets/image/mess.png",
                          "Text Message",
                          Transform.scale(
                            scale: 0.7,
                            child: CupertinoSwitch(
                              activeTrackColor: notifire.buttonsColor,
                              value: status1,
                              onChanged: (value) {
                                setState(() {
                                  status1 = value;
                                });
                              },
                            ),
                          ),
                          notifire
                        ),
                        line(
                          "assets/image/phone.png",
                          "Phone Call",
                          Transform.scale(
                            scale: 0.7,
                            child: CupertinoSwitch(
                              activeTrackColor: notifire.buttonsColor,
                              value: status2,
                              onChanged: (value) {
                                setState(() {
                                  status2 = value;
                                });
                              },
                            ),
                          ),
                          notifire
                        ),
                        SizedBox(
                          height: height / 100,
                        ),
                        GestureDetector(
                          onTap: () {
                            _showMyDialog(notifire);
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: width / 25,
                                ),
                                Image.asset(
                                  "assets/image/currency.png",
                                  color: notifire.darksColor,
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
                                    color: notifire.darksColor,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  "\₹INR",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Gilroy Normal',
                                    color: notifire.darksColor,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: notifire.darksColor,
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
                            _showMyDialog2(notifire);
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: width / 25,
                                ),
                                Image.asset(
                                  "assets/image/language.png",
                                  color: notifire.darksColor,
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
                                    color: notifire.darksColor,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  "English",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Gilroy Normal',
                                    color: notifire.darksColor,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: notifire.darksColor,
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
                          "assets/image/darkmode.png",
                          "Dark Mode",
                          Transform.scale(
                            scale: 0.7,
                            child: CupertinoSwitch(
                              activeTrackColor: notifire.buttonsColor,
                              value: notifire.isDark,
                              onChanged: (val) async {
                                // final prefs =
                                //     await SharedPreferences.getInstance();
                                // setState(() {
                                //   notifire.setIsDark = val;
                                //   prefs.setBool("setIsDark", val);
                                // });
                              },
                            ),
                            // CupertinoSwitch(
                            //   activeColor: notifire.buttonsColor,
                            //   value: status3,
                            //   onChanged: (value) {
                            //     setState(() {
                            //       status3 = value;
                            //     });
                            //   },
                            // ),
                          ),
                          notifire
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

  _showMyDialog2(ColorState notifire,) async {
    return showDialog(
      context: context, useRootNavigator: true,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: notifire.primaryColor,
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                color: Colors.transparent,
                height: context.height / 2,
                width: context.width / 1.1,
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
                              ? notifire.buttonsColor
                              : Colors.transparent,
                          selectedindex7 ? notifire.darksColor : Colors.grey,
                          selectedindex7
                              ? notifire.darksColor
                              : Colors.grey),
                    ),
                    SizedBox(height: context.height / 100),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedindex8 = !selectedindex8;
                        });
                      },
                      child: locatename(
                          "Manchester",
                          selectedindex8
                              ? notifire.buttonsColor
                              : Colors.transparent,
                          selectedindex8 ? notifire.darksColor : Colors.grey,
                          selectedindex8
                              ? notifire.darksColor
                              : Colors.grey),
                    ),
                    SizedBox(height: context.height / 100),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedindex9 = !selectedindex9;
                        });
                      },
                      child: locatename(
                          "Edinburgh",
                          selectedindex9
                              ? notifire.buttonsColor
                              : Colors.transparent,
                          selectedindex9 ? notifire.darksColor : Colors.grey,
                          selectedindex9
                              ? notifire.darksColor
                              : Colors.grey),
                    ),
                    SizedBox(height: context.height / 100),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedindex10 = !selectedindex10;
                        });
                      },
                      child: locatename(
                          "Burmingham",
                          selectedindex10
                              ? notifire.buttonsColor
                              : Colors.transparent,
                          selectedindex10
                              ? notifire.darksColor
                              : Colors.grey,
                          selectedindex10
                              ? notifire.darksColor
                              : Colors.grey),
                    ),
                    SizedBox(height: context.height / 100),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedindex11 = !selectedindex11;
                        });
                      },
                      child: locatename(
                          "Bristol",
                          selectedindex11
                              ? notifire.buttonsColor
                              : Colors.transparent,
                          selectedindex11
                              ? notifire.darksColor
                              : Colors.grey,
                          selectedindex11
                              ? notifire.darksColor
                              : Colors.grey),
                    ),
                    SizedBox(height: context.height / 100),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedindex12 = !selectedindex12;
                        });
                      },
                      child: locatename(
                          "Liverpool",
                          selectedindex12
                              ? notifire.buttonsColor
                              : Colors.transparent,
                          selectedindex12
                              ? notifire.darksColor
                              : Colors.grey,
                          selectedindex12
                              ? notifire.darksColor
                              : Colors.grey),
                    ),
                    SizedBox(height: context.height / 100),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedindex13 = !selectedindex13;
                        });
                      },
                      child: locatename(
                          "Glasgow",
                          selectedindex13
                              ? notifire.buttonsColor
                              : Colors.transparent,
                          selectedindex13
                              ? notifire.darksColor
                              : Colors.grey,
                          selectedindex13
                              ? notifire.darksColor
                              : Colors.grey),
                    ),
                    SizedBox(height: context.height / 40),
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
                              height: context.height / 30,
                              width: context.width / 5,
                              decoration: BoxDecoration(
                                color: notifire.primaryColor,
                                border:
                                    Border.all(color: notifire.buttonsColor),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "Cancle",
                                  style: TextStyle(
                                      color: notifire.buttonsColor,
                                      fontFamily: 'Gilroy Normal',
                                      fontSize: 12.sp),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: context.width / 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              height: context.height / 30,
                              width: context.width / 5,
                              decoration: BoxDecoration(
                                color: notifire.buttonsColor,
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
                color: notifire.darksColor,
                fontFamily: 'Gilroy_Bold',
                fontSize: 17.sp),
          ),
        );
      },
    );
  }

  _showMyDialog(ColorState notifire) async {
    return showDialog(
      context: context, useRootNavigator: true,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: notifire.primaryColor,
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                color: Colors.transparent,
                height: context.height / 2,
                width: context.width / 1.1,
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
                              ? notifire.buttonsColor
                              : Colors.transparent,
                          selectedindex ? notifire.darksColor : Colors.grey,
                          selectedindex ? notifire.darksColor : Colors.grey),
                    ),
                    SizedBox(height: context.height / 100),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedindex1 = !selectedindex1;
                        });
                      },
                      child: locatename(
                          "Manchester",
                          selectedindex1
                              ? notifire.buttonsColor
                              : Colors.transparent,
                          selectedindex1 ? notifire.darksColor : Colors.grey,
                          selectedindex1
                              ? notifire.darksColor
                              : Colors.grey),
                    ),
                    SizedBox(height: context.height / 100),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedindex2 = !selectedindex2;
                        });
                      },
                      child: locatename(
                          "Edinburgh",
                          selectedindex2
                              ? notifire.buttonsColor
                              : Colors.transparent,
                          selectedindex2 ? notifire.darksColor : Colors.grey,
                          selectedindex2
                              ? notifire.darksColor
                              : Colors.grey),
                    ),
                    SizedBox(height: context.height / 100),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedindex3 = !selectedindex3;
                        });
                      },
                      child: locatename(
                          "Burmingham",
                          selectedindex3
                              ? notifire.buttonsColor
                              : Colors.transparent,
                          selectedindex3 ? notifire.darksColor : Colors.grey,
                          selectedindex3
                              ? notifire.darksColor
                              : Colors.grey),
                    ),
                    SizedBox(height: context.height / 100),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedindex4 = !selectedindex4;
                        });
                      },
                      child: locatename(
                          "Bristol",
                          selectedindex4
                              ? notifire.buttonsColor
                              : Colors.transparent,
                          selectedindex4 ? notifire.darksColor : Colors.grey,
                          selectedindex4
                              ? notifire.darksColor
                              : Colors.grey),
                    ),
                    SizedBox(height: context.height / 100),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedindex5 = !selectedindex5;
                        });
                      },
                      child: locatename(
                          "Liverpool",
                          selectedindex5
                              ? notifire.buttonsColor
                              : Colors.transparent,
                          selectedindex5 ? notifire.darksColor : Colors.grey,
                          selectedindex5
                              ? notifire.darksColor
                              : Colors.grey),
                    ),
                    SizedBox(height: context.height / 100),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedindex6 = !selectedindex6;
                        });
                      },
                      child: locatename(
                          "Glasgow",
                          selectedindex6
                              ? notifire.buttonsColor
                              : Colors.transparent,
                          selectedindex6 ? notifire.darksColor : Colors.grey,
                          selectedindex6
                              ? notifire.darksColor
                              : Colors.grey),
                    ),
                    SizedBox(height: context.height / 40),
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
                              height: context.height / 30,
                              width: context.width / 5,
                              decoration: BoxDecoration(
                                color: notifire.primaryColor,
                                border:
                                    Border.all(color: notifire.buttonsColor),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "Cancle",
                                  style: TextStyle(
                                      color: notifire.buttonsColor,
                                      fontFamily: 'Gilroy Normal',
                                      fontSize: 12.sp),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: context.width / 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              height: context.height / 30,
                              width: context.width / 5,
                              decoration: BoxDecoration(
                                color: notifire.buttonsColor,
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
                color: notifire.darksColor,
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
            SizedBox(width: context.width / 10),
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

  Widget lines(img, name,ColorState notifire) {
    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
          SizedBox(
            height: context.height / 100,
          ),
          Row(
            children: [
              SizedBox(
                width: context.width / 25,
              ),
              Image.asset(
                img,
                color: notifire.darksColor,
                height: context.height / 35,
              ),
              SizedBox(
                width: context.width / 30,
              ),
              Text(
                name,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Gilroy Normal',
                  color: notifire.darksColor,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                color: notifire.darksColor,
                size: 14.sp,
              ),
              SizedBox(
                width: context.width / 20,
              ),
            ],
          ),
          SizedBox(
            height: context.height / 100,
          ),
        ],
      ),
    );
  }

  Widget line(img, name, se,ColorState notifire) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: context.width / 25,
            ),
            Image.asset(
              img,
              color: notifire.darksColor,
              height: context.height / 35,
            ),
            SizedBox(
              width: context.width / 30,
            ),
            Text(
              name,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                fontFamily: 'Gilroy Normal',
                color: notifire.darksColor,
              ),
            ),
            const Spacer(),
            se,
            SizedBox(
              width: context.width / 20,
            ),
          ],
        ),
      ],
    );
  }
}
