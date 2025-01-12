import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../payment/payment.dart';
import '../utils/colornotifire.dart';
import '../utils/media.dart';
import '../utils/string.dart';

class Safe extends StatefulWidget {
  const Safe({Key? key}) : super(key: key);

  @override
  _SafeState createState() => _SafeState();
}

class _SafeState extends State<Safe> {
  late ColorNotifire notifire;
  bool isChecked = false;

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
        backgroundColor: Colors.transparent.withOpacity(0.5),
        body: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  height: height / 4.8,
                  color: Colors.transparent,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: notifire.getprimerycolor,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: height / 50,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      height: MediaQuery.of(context).size.height / 80,
                      width: MediaQuery.of(context).size.width / 7,
                    ),
                    SizedBox(
                      height: height / 70,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width / 20,
                        ),
                        Text(
                          CustomStrings.safe,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Gilroy Bold',
                            color: notifire.getdarkscolor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height / 50,
                    ),
                    Image.asset(
                      "image/protection.png",
                      height: height / 5,
                    ),
                    SizedBox(
                      height: height / 50,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width / 20,
                        ),
                        Text(
                          CustomStrings.covid,
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Gilroy Bold',
                            color: notifire.getdarkscolor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height / 50,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width / 20,
                        ),
                        Flexible(
                          child: Text(
                            CustomStrings.details,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: 'Gilroy Normal',
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height / 60,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width / 20,
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 30.sp),
                              child: Icon(
                                Icons.circle,
                                color: Colors.black,
                                size: 10.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: width / 40,
                        ),
                        Text(
                          CustomStrings.detail,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: 'Gilroy Normal',
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height / 60,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width / 20,
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 20.sp),
                              child: Icon(
                                Icons.circle,
                                color: Colors.black,
                                size: 10.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: width / 40,
                        ),
                        Text(
                          CustomStrings.detail,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: 'Gilroy Normal',
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height / 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: <Widget>[
                          //SizedBox
                          Checkbox(
                            checkColor: Colors.white,
                            fillColor: MaterialStateProperty.resolveWith(
                                (states) => notifire.getbuttonscolor),
                            value: isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked = value!;
                              });
                            },
                          ),
                          Text(
                            "I Confirm that I am healty",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: 'Gilroy Normal',
                              color: notifire.gettextcolor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height / 200,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                child: const Payment()));
                      },
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            color: notifire.getbuttonscolor,
                          ),
                          height: height / 15,
                          width: width / 1.5,
                          child: Row(
                            children: [
                              SizedBox(
                                width: width / 5,
                              ),
                              Text(
                                "CONTINUE",
                                style: TextStyle(fontFamily: 'Gilroy Medium',
                                    color: Colors.white,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                width: width / 7,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 9),
                                child: Image.asset("image/arrow.png"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height / 40,
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
}
