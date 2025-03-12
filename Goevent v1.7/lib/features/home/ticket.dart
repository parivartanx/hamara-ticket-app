import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/extensions/media_query_ext.dart';
import '/providers/color_provider.dart';
import '/utils/botton.dart';
import '/utils/string.dart';
import 'package:page_transition/page_transition.dart';

import '../../payment/payment.dart';

class Ticket extends ConsumerStatefulWidget {
  const Ticket({Key? key}) : super(key: key);

  @override
  _TicketState createState() => _TicketState();
}

class _TicketState extends ConsumerState<Ticket> {
  bool selected = false;
  int _counter = 00;
  bool _select = false;
  bool isChecked = false;


  @override
  void initState() {
    super.initState();
    ref.read(colorProvider.notifier).getdarkmodepreviousstate();
  }

  @override
  Widget build(BuildContext context) {
    final notifire = ref.watch(colorProvider);
    final height =  context.height;
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
                showModalBottomSheet<dynamic>(
                  elevation: 0,
                  backgroundColor: notifire.primaryColor,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext bc) {
                    return StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                      return Wrap(
                        children: <Widget>[
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25.0),
                                topRight: Radius.circular(25.0),
                              ),
                            ),
                            height: height / 1.15,
                            child: Container(
                              decoration: BoxDecoration(
                                color: notifire.primaryColor,
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(30),
                                  topLeft: Radius.circular(30),
                                ),
                              ),
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
                                    height:
                                        MediaQuery.of(context).size.height / 80,
                                    width:
                                        MediaQuery.of(context).size.width / 7,
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
                                          color: notifire.darksColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height / 50,
                                  ),
                                  Image.asset(
                                    "assets/image/protection.png",
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
                                          color: notifire.darksColor,
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
                                            padding:
                                                EdgeInsets.only(bottom: 30.sp),
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
                                            padding:
                                                EdgeInsets.only(bottom: 20.sp),
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Row(
                                      children: <Widget>[
                                        //SizedBox
                                        Checkbox(
                                          checkColor: Colors.white,
                                          fillColor:
                                              MaterialStateProperty.resolveWith(
                                                  (states) =>
                                                      notifire.buttonsColor),
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
                                            color: notifire.textColor,
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
                                            child: const Payment()),
                                      );
                                    },
                                    child: Center(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          color: notifire.buttonsColor,
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
                                              style: TextStyle(
                                                  fontFamily: 'Gilroy Medium',
                                                  color: Colors.white,
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(
                                              width: width / 7,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 9),
                                              child: Image.asset(
                                                  "assets/image/arrow.png"),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height / 200,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    });
                  },
                );
              },
              child: Custombutton.button(
                notifire.buttonsColor,
                "CONTINUE",
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
                        Icon(Icons.arrow_back, color: notifire.darksColor),
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
                      color: notifire.darksColor,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.more_vert,
                    color: notifire.darksColor,
                  ),
                  SizedBox(
                    width: width / 20,
                  ),
                ],
              ),
              SizedBox(
                height: height / 20,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "Ticket Type",
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Gilroy Bold',
                        color: notifire.darksColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height / 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            _select = !_select;
                          });
                        },
                        child: tic(
                          _select ? Colors.white : notifire.buttonsColor,
                          "VIP",
                          _select ? notifire.buttonsColor : Colors.white,
                        )),
                    const Spacer(),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            _select = !_select;
                          });
                        },
                        child: tic(
                          _select ? notifire.buttonsColor : Colors.white,
                          "ECONOMY",
                          _select ? Colors.white : const Color(0xff5669ff),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: height / 40,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "Seat",
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontFamily: 'Gilroy Bold',
                        color: notifire.darksColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height / 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: height / 12,
                  width: width,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      border: Border.all(color: const Color(0xffdcdbdb), width: 1)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _counter--;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Container(
                            width: width / 7,
                            height: height,
                            decoration: BoxDecoration(
                              color: notifire.pinkColor,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "-",
                                style: TextStyle(
                                    fontFamily: 'Gilroy Medium',
                                    fontSize: 40.sp,
                                    color: const Color(0xff5669ff),),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        '$_counter',
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontFamily: 'Gilroy Normal',
                            color: notifire.darksColor,
                            fontWeight: FontWeight.w600,),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _counter++;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Container(
                            width: width / 7,
                            height: height,
                            decoration: BoxDecoration(
                              color: notifire.pinkColor,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "+",
                                style: TextStyle(
                                    fontFamily: 'Gilroy Medium',
                                    fontSize: 20.sp,
                                    color: const Color(0xff5669ff),),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height / 2.5,
              ),
              Text(
                "Total: \$150.00",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontFamily: 'Gilroy Bold',
                  color: notifire.darksColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget tic(clr, name, color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        border: Border.all(width: 1, color:const Color(0xffdcdbdb)),
      ),
      height: context.height / 12,
      width: context.width / 2.5,
      child: Center(
        child: Text(
          name,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            fontFamily: 'Gilroy Medium',
            color: clr,
          ),
        ),
      ),
    );
  }
}
