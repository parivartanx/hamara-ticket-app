import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/botton.dart';
import '../utils/colornotifire.dart';
import '../utils/media.dart';
import '../utils/string.dart';
import 'finalticket.dart';

class PayMethod extends StatefulWidget {
  const PayMethod({Key? key}) : super(key: key);

  @override
  _PayMethodState createState() => _PayMethodState();
}

class _PayMethodState extends State<PayMethod> {
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
        floatingActionButton: Padding(
          padding: const EdgeInsets.fromLTRB(20,0,20,10),
          child: SizedBox(
            height: 45.h,
            width: 410.w,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: const Final(),),);
              },
              child:  Custombutton.button(
                notifire.getbuttonscolor,
                "CONFIRM",
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
                    "Ticket",
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
                  ],
                ),
              ),
              SizedBox(
                height: height / 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Image.asset("image/method.png"),
              ),
              SizedBox(
                height: height / 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      CustomStrings.vouchers,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Gilroy Bold',
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
                child: Container(
                  height: height / 10,
                  decoration:  BoxDecoration(
                    color: notifire.getpinkcolor,
                    borderRadius: const BorderRadius.all(Radius.circular(10))
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: height / 50,),
                      Row(
                        children: [
                          SizedBox(width: width / 30,),
                         Text(CustomStrings.applied,
                           style: TextStyle(
                             fontSize: 12.sp,
                             fontWeight: FontWeight.w400,
                             fontFamily: 'Gilroy Normal',
                             color: Colors.grey,
                           ),),
                          const Spacer(),
                          const Icon(Icons.close,color: Colors.grey,size: 20,),
                          SizedBox(width: width / 30,),
                        ],
                      ),
                      SizedBox(height: height / 100,),
                      Row(
                        children: [
                          SizedBox(width: width / 30,),
                          Text(CustomStrings.event,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: 'Gilroy Bold',
                              color: notifire.gettextcolor,
                            ),),
                          SizedBox(width: width / 30,),
                          Container(
                            height: height / 35,
                              width: width / 7,
                              decoration:  const BoxDecoration(
                                  color: Color(0xffF0635A),
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                              ),
                            child: Center(
                              child: Text("25 % off",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontFamily: 'Gilroy Bold',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height / 4.5,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
