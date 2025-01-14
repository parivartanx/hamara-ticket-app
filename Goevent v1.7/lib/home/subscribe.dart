import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goevent2/extensions/media_query_ext.dart';
import 'package:goevent2/home/home.dart';
import 'package:page_transition/page_transition.dart';

import '../payment/paymethod.dart';
import '../providers/color_provider.dart';
import '../utils/botton.dart';
import '../utils/string.dart';

class Subscribe extends ConsumerStatefulWidget {
  const Subscribe({Key? key}) : super(key: key);

  @override
  _SubscribeState createState() => _SubscribeState();
}

class _SubscribeState extends ConsumerState<Subscribe> {
  int _groupValue = -1;

  

  @override
  void initState() {
    super.initState();
    ref.read(colorProvider.notifier).getdarkmodepreviousstate();
  }

  @override
  Widget build(BuildContext context) {
    final notifire = ref.watch(colorProvider);
    final height=  context.height;
    final width = context.width;

    return ScreenUtilInit(
      builder:  (BuildContext context, child) =>  Scaffold(
        backgroundColor: notifire.primaryColor,
        floatingActionButton: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: SizedBox(
            height: 45.h,
            width: 410.w,
            child: FloatingActionButton(
              onPressed: () {
                _showMyDialog(notifire);
              },
              child: Custombutton.button(
                notifire.buttonsColor,
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
                        Icon(Icons.arrow_back, color: notifire.darksColor),
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
                      color: notifire.darksColor,
                    ),
                  ),
                  const Spacer(),
                  Image.asset(
                    "assets/image/scanner.png",
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
                        color: notifire.textColor,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      CustomStrings.card,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Gilroy Normal',
                        color: notifire.buttonsColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height / 40,
              ),
              method(0, CustomStrings.apple, "assets/image/apple.png",notifire),
              SizedBox(
                height: height / 60,
              ),
              method(1, CustomStrings.paypal, "assets/image/paypal.png",notifire),
              SizedBox(
                height: height / 60,
              ),
              method(2, CustomStrings.google, "assets/image/google.png",notifire),
              SizedBox(
                height: height / 60,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Radio(
                      activeColor: notifire.buttonsColor,
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
                        color: notifire.darksColor,
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
                        "assets/image/pay.png",
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
                        color: notifire.darksColor,
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
                                    color: notifire.darksColor,
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
                                  color: notifire.buttonsColor,
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
                                        fontSize: 14.sp,
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

  _showMyDialog(ColorState notifire) async {
    return showDialog(
      context: context, useRootNavigator: true,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        final height= context.height;
        final width = context.width;
        return AlertDialog(
          backgroundColor: notifire.primaryColor,
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                color: notifire.primaryColor,
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
                    Image.asset("assets/image/done.gif"),
                    Text(
                      CustomStrings.success,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontFamily: 'Gilroy Bold',
                        color: notifire.darksColor,
                      ),
                    ),
                    SizedBox(height: height / 100),
                    Text(
                      CustomStrings.subtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: 'Gilroy Normal',
                        color: notifire.darksColor,
                      ),
                    ),
                    // Text(CustomStrings.w2,style: TextStyle(
                    //   fontSize: 12.sp,
                    //   fontFamily: 'Gilroy Normal',
                    //   color: notifire.darksColor,
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
                          color: notifire.buttonsColor,
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

  Widget method(val, name, img, ColorState notifire) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: () {
          setState(
            () {
              _groupValue = val;
            },
          );
        },
        child: Container(
          height: context.height / 12,
          width: context.width,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              border: Border.all(color: Colors.grey, width: 1)),
          child: Row(
            children: [
              SizedBox(
                width: context.width / 30,
              ),
              Image.asset(
                img,
                height: context.height / 25,
              ),
              SizedBox(
                width: context.width / 30,
              ),
              Text(
                name,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Gilroy Normal',
                  color: notifire.darksColor,
                ),
              ),
              const Spacer(),
              Radio(
                activeColor: notifire.buttonsColor,
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
