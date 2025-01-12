import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goevent2/payment/finalticket.dart';
import 'package:goevent2/payment/paymethod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/botton.dart';
import '../utils/colornotifire.dart';
import '../utils/media.dart';
import '../utils/string.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
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
        resizeToAvoidBottomInset: false,
        floatingActionButton: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: SizedBox(
            height: 45.h,
            width: 410.w,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: const Final(),
                  ),
                );
              },
              child: Custombutton.button(
                notifire.getbuttonscolor,
                "CHECKOUT",
                SizedBox(
                  width: width / 3.5,
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
                      border: Border.all(color: Color(0xffdcdbdb), width: 1)),
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
                      color: Color(0xffdcdbdb),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Row(
                          children: [
                            Container(
                              color: Colors.transparent,
                              height: height / 20,
                              width: width / 1.8,
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
                                  EdgeInsets.symmetric(horizontal: 20.sp),
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
              border: Border.all(color: Color(0xffdcdbdb), width: 1)),
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
