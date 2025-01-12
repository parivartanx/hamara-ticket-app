import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goevent2/home/home.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../payment/paymethod.dart';
import '../utils/botton.dart';
import '../utils/colornotifire.dart';
import '../utils/media.dart';
import '../utils/string.dart';

class Subscribe extends StatefulWidget {
  const Subscribe({Key? key}) : super(key: key);

  @override
  _SubscribeState createState() => _SubscribeState();
}

class _SubscribeState extends State<Subscribe> {
  late ColorNotifire notifire;
  int _groupValue = -1;

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
        floatingActionButton: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: SizedBox(
            height: 45.h,
            width: 410.w,
            child: FloatingActionButton(
              onPressed: () {
                _showMyDialog();
              },
              child: Custombutton.button(
                notifire.getbuttonscolor,
                "CHECKOUT",
                SizedBox(
                  width: width / 3,
                ),
                SizedBox(
                  width: width / 20,
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
                    child:
                        Icon(Icons.arrow_back, color: notifire.getdarkscolor),
                  ),
                  SizedBox(
                    width: width / 80,
                  ),
                  Text(
                    "Payment",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Gilroy Medium',
                      color: notifire.getdarkscolor,
                    ),
                  ),
                  const Spacer(),
                  Image.asset(
                    "image/scanner.png",
                    height: height / 30,
                  ),
                  SizedBox(
                    width: width / 20,
                  ),
                ],
              ),
              SizedBox(
                height: height / 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      CustomStrings.payment,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Gilroy Bold',
                        color: notifire.gettextcolor,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      CustomStrings.card,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Gilroy Normal',
                        color: notifire.getbuttonscolor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height / 40,
              ),
              method(0, CustomStrings.apple, "image/apple.png"),
              SizedBox(
                height: height / 60,
              ),
              method(1, CustomStrings.paypal, "image/paypal.png"),
              SizedBox(
                height: height / 60,
              ),
              method(2, CustomStrings.google, "image/google.png"),
              SizedBox(
                height: height / 60,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Radio(
                      activeColor: notifire.getbuttonscolor,
                      value: 3,
                      groupValue: _groupValue,
                      onChanged: (value) {
                        setState(() {
                          _groupValue = value as int;
                        });
                      },
                    ),
                    Text(
                      CustomStrings.pay,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Gilroy Normal',
                        color: notifire.getdarkscolor,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: height / 14,
                  width: width,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      border: Border.all(color: Colors.grey, width: 1)),
                  child: Row(
                    children: [
                      SizedBox(
                        width: width / 30,
                      ),
                      Image.asset(
                        "image/pay.png",
                        height: height / 35,
                      ),
                      SizedBox(
                        width: width / 30,
                      ),
                      Text(
                        "**** **** **** 0231",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Gilroy Normal',
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height / 60,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      CustomStrings.voucher,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Gilroy Normal',
                        color: notifire.getdarkscolor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height / 60,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: height / 14,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            Container(
                              color: Colors.transparent,
                              height: height / 20,
                              width: width / 1.78,
                              child: TextField(
                                style: TextStyle(
                                    color: notifire.getdarkscolor,
                                    fontSize: 15.sp),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  hintText: "VOUCHER CODE",
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 15.sp),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    child: const PayMethod(),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  color: notifire.getbuttonscolor,
                                ),
                                // width: width / 3.94,
                                height: height / 12,
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 30.sp),
                                  child: Center(
                                    child: Text(
                                      "APPLY",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Gilroy Normal',
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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
                color: notifire.getprimerycolor,
                height: height / 2.3,
                width: width / 1.1,
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Spacer(),
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.close,
                              color: Colors.grey,
                            )),
                      ],
                    ),
                    Image.asset("image/done.gif"),
                    Text(
                      CustomStrings.success,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontFamily: 'Gilroy Bold',
                        color: notifire.getdarkscolor,
                      ),
                    ),
                    SizedBox(height: height / 100),
                    Text(
                      CustomStrings.subtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: 'Gilroy Normal',
                        color: notifire.getdarkscolor,
                      ),
                    ),
                    // Text(CustomStrings.w2,style: TextStyle(
                    //   fontSize: 12.sp,
                    //   fontFamily: 'Gilroy Normal',
                    //   color: notifire.getdarkscolor,
                    // ),),
                    SizedBox(height: height / 50),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                child: const Home()));
                      },
                      child: Container(
                        height: height / 20,
                        width: width / 4,
                        decoration: BoxDecoration(
                          color: notifire.getbuttonscolor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Continue",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: 'Gilroy Bold',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
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
        );
      },
    );
  }

  Widget method(val, name, img) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: () {
          setState(
            () {
              _groupValue = val as int;
            },
          );
        },
        child: Container(
          height: height / 12,
          width: width,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              border: Border.all(color: Colors.grey, width: 1)),
          child: Row(
            children: [
              SizedBox(
                width: width / 30,
              ),
              Image.asset(
                img,
                height: height / 25,
              ),
              SizedBox(
                width: width / 30,
              ),
              Text(
                name,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Gilroy Normal',
                  color: notifire.getdarkscolor,
                ),
              ),
              const Spacer(),
              Radio(
                activeColor: notifire.getbuttonscolor,
                value: val as int,
                groupValue: _groupValue,
                onChanged: (value) {
                  setState(() {
                    _groupValue = value as int;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
