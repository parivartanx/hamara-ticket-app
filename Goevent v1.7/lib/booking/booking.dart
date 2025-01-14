import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goevent2/extensions/media_query_ext.dart';
import 'package:goevent2/payment/finalticket.dart';
import 'package:goevent2/providers/color_provider.dart';
import 'package:page_transition/page_transition.dart';

import '../organizer/oprofile.dart';
import '../utils/botton.dart';
import '../utils/string.dart';

class Booking extends ConsumerStatefulWidget {
  const Booking({Key? key}) : super(key: key);

  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends ConsumerState<Booking> {

 

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
      builder: (BuildContext context, child) => Scaffold(
        backgroundColor: notifire.primaryColor,
        floatingActionButton: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: SizedBox(
            height: 45.h,
            width: 410.w,
            child: FloatingActionButton(
              onPressed: () {
                showModalBottomSheet<dynamic>(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0),
                    ),
                  ),
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext bc) {
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
                          height: height / 1.1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: notifire.primaryColor,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                              ),
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: notifire.cardColor,
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        topRight: Radius.circular(25),
                                      ),
                                    ),
                                    height: height / 12,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: height / 80,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: notifire.textColor,
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              80,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              7,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: width / 15,
                                            ),
                                            Text(
                                              CustomStrings.msg,
                                              style: TextStyle(
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.w800,
                                                fontFamily: 'Gilroy Medium',
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: height / 50,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Row(
                                      children: [
                                        Text(
                                          CustomStrings.music,
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontFamily: 'Gilroy Bold',
                                            color: notifire.darksColor,
                                          ),
                                        ),
                                        const Spacer(),
                                        Icon(
                                          Icons.more_vert,
                                          color: notifire.darksColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: height / 50,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                              "assets/image/p1.png",
                                              height: height / 20,
                                            ),
                                            SizedBox(
                                              width: width / 50,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Zara Cla",
                                                  style: TextStyle(
                                                    fontSize: 13.sp,
                                                    fontWeight: FontWeight.w800,
                                                    fontFamily: 'Gilroy Medium',
                                                    color:
                                                        notifire.darksColor,
                                                  ),
                                                ),
                                                Text(
                                                  "1m ago",
                                                  style: TextStyle(
                                                    fontSize: 11.sp,
                                                    fontFamily: 'Gilroy Medium',
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: height / 100,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              height: height / 10,
                                              width: width / 1.5,
                                              decoration: BoxDecoration(
                                                color: notifire.pinkColor,
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topRight: Radius.circular(15),
                                                  bottomLeft:
                                                      Radius.circular(15),
                                                  bottomRight:
                                                      Radius.circular(15),
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.sp),
                                                child: Center(
                                                  child: Text(
                                                    CustomStrings.thanks,
                                                    style: TextStyle(
                                                      fontSize: 15.sp,
                                                      fontFamily:
                                                          'Gilroy Medium',
                                                      color:
                                                          notifire.textColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              "12:31 am",
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontFamily: 'Gilroy Medium',
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: height / 100,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              height: height / 15,
                                              width: width / 1.5,
                                              decoration: BoxDecoration(
                                                  color: notifire.cardColor,
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          topLeft: Radius
                                                              .circular(15),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  15),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  15))),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.sp),
                                                child: Center(
                                                  child: Text(
                                                    CustomStrings.awesome,
                                                    style: TextStyle(
                                                      fontSize: 15.sp,
                                                      fontFamily:
                                                          'Gilroy Medium',
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: height / 100,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/image/p1.png",
                                          height: height / 20,
                                        ),
                                        SizedBox(
                                          width: width / 50,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Zara Cla",
                                              style: TextStyle(
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w800,
                                                fontFamily: 'Gilroy Medium',
                                                color: notifire.darksColor,
                                              ),
                                            ),
                                            Text(
                                              "1m ago",
                                              style: TextStyle(
                                                fontSize: 11.sp,
                                                fontFamily: 'Gilroy Medium',
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: height / 100,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/image/b1.png",
                                          height: height / 13,
                                        ),
                                        SizedBox(
                                          width: width / 30,
                                        ),
                                        Image.asset(
                                          "assets/image/b2.png",
                                          height: height / 13,
                                        ),
                                        SizedBox(
                                          width: width / 30,
                                        ),
                                        Image.asset(
                                          "assets/image/b3.png",
                                          height: height / 13,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: height / 100,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/image/p2.png",
                                          height: height / 20,
                                        ),
                                        SizedBox(
                                          width: width / 50,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Jhon Eick",
                                              style: TextStyle(
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w800,
                                                fontFamily: 'Gilroy Medium',
                                                color: notifire.darksColor,
                                              ),
                                            ),
                                            Text(
                                              "1m ago",
                                              style: TextStyle(
                                                fontSize: 11.sp,
                                                fontFamily: 'Gilroy Medium',
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: height / 100,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: height / 8,
                                          width: width / 1.5,
                                          decoration: BoxDecoration(
                                              color: notifire.pinkColor,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(15),
                                                      bottomLeft:
                                                          Radius.circular(15),
                                                      bottomRight:
                                                          Radius.circular(15))),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.sp),
                                            child: Center(
                                              child: Text(
                                                CustomStrings.yeah,
                                                style: TextStyle(
                                                  fontSize: 15.sp,
                                                  fontFamily: 'Gilroy Medium',
                                                  color: notifire.textColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              "1:31 am",
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontFamily: 'Gilroy Medium',
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: height / 100,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              height: height / 15,
                                              width: width / 1.5,
                                              decoration: BoxDecoration(
                                                  color: notifire
                                                      .buttonsColor,
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          topLeft: Radius
                                                              .circular(15),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  15),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  15))),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.sp),
                                                child: Center(
                                                  child: Text(
                                                    CustomStrings.doit,
                                                    style: TextStyle(
                                                      fontSize: 15.sp,
                                                      fontFamily:
                                                          'Gilroy Medium',
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: height / 100,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: height / 10,
                                    width: width,
                                    color: notifire.pinkColor,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Row(
                                        children: [
                                          Container(
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                            height: height / 20,
                                            width: width / 1.8,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: width / 40),
                                              child: TextField(
                                                style: TextStyle(
                                                    color:
                                                        notifire.textColor),
                                                decoration:
                                                    const InputDecoration(
                                                        hintStyle:
                                                            TextStyle(
                                                                color: Colors
                                                                    .grey),
                                                        hintText:
                                                            "Write a reply...",
                                                        border:
                                                            InputBorder.none),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: width / 20,
                                          ),
                                          Image.asset(
                                            "assets/image/smile.png",
                                            height: height / 30,
                                          ),
                                          SizedBox(
                                            width: width / 30,
                                          ),
                                          Image.asset(
                                            "assets/image/gallary.png",
                                            height: height / 30,
                                          ),
                                          SizedBox(
                                            width: width / 30,
                                          ),
                                          Image.asset(
                                            "assets/image/clip.png",
                                            height: height / 30,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Custombutton.button(
                notifire.buttonsColor,
                CustomStrings.msg,
                SizedBox(
                  width: width / 3.5,
                ),
                SizedBox(
                  width: width / 22,
                ),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    color: Colors.transparent,
                    width: width,
                    height: height / 4,
                    child: Image.asset(
                      "assets/image/event.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Column(
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
                            child: const Icon(Icons.arrow_back,
                                color: Colors.white),
                          ),
                          SizedBox(
                            width: width / 80,
                          ),
                          Text(
                            "My Booking",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Gilroy Medium',
                              color: Colors.white,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            height: height / 25,
                            width: width / 12,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.5),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(7),
                              child: Image.asset(
                                "assets/image/save.png",
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height / 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: notifire.cardColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15))),
                        width: width / 1.2,
                        height: height / 8,
                        child: Card(
                          color: notifire.cardColor,
                          elevation: 15,
                          shadowColor: notifire.cardColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                child: Container(
                                  color: notifire.cardColor,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: height / 100,
                                      ),
                                      Image.asset(
                                        "assets/image/Call.png",
                                        height: height / 17,
                                      ),
                                      SizedBox(
                                        height: height / 100,
                                      ),
                                      Text(
                                        CustomStrings.call,
                                        style: TextStyle(
                                          fontSize: height / 50,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Gilroy Medium',
                                          color: notifire.textColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                color: notifire.cardColor,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: height / 100,
                                    ),
                                    Image.asset(
                                      "assets/image/Directions.png",
                                      height: height / 17,
                                    ),
                                    SizedBox(
                                      height: height / 100,
                                    ),
                                    Text(
                                      CustomStrings.dire,
                                      style: TextStyle(
                                        fontSize: height / 50,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Gilroy Medium',
                                        color: notifire.textColor,
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
                                        child: const Final()),
                                  );
                                },
                                child: Container(
                                  color: notifire.cardColor,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: height / 100,
                                      ),
                                      Image.asset(
                                        "assets/image/Ticket.png",
                                        height: height / 17,
                                      ),
                                      SizedBox(
                                        height: height / 100,
                                      ),
                                      Text(
                                        CustomStrings.ticket,
                                        style: TextStyle(
                                          fontSize: height / 50,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Gilroy Medium',
                                          color: notifire.textColor,
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
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: height / 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  CustomStrings.music,
                  style: TextStyle(
                    fontSize: 35.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Gilroy Medium',
                    color: notifire.darksColor,
                  ),
                ),
              ),
              SizedBox(
                height: height / 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            child: const Organize()));
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        Container(
                          height: height / 15,
                          width: width / 7,
                          decoration: BoxDecoration(
                            color: notifire.cardColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Image.asset("assets/image/p4.png"),
                          ),
                        ),
                        SizedBox(
                          width: width / 38,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Ashfak Sayem",
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Gilroy Medium',
                                color: notifire.darksColor,
                              ),
                            ),
                            SizedBox(
                              height: height / 300,
                            ),
                            Text(
                              "Organizer",
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Gilroy Medium',
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: const Organize(),
                              ),
                            );
                          },
                          child: Container(
                            height: height / 30,
                            width: width / 6,
                            color: notifire.cardColor,
                            child: Center(
                              child: Text(
                                "Follow",
                                style: TextStyle(
                                  color: const Color(0xff5669ff),
                                  fontSize: 12.sp,
                                  fontFamily: 'Gilroy Bold',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height / 40,
              ),
              concert("assets/image/date.png", "14 December, 2021",
                  "Tuesday, 4:00PM - 9:00PM",notifire),
              SizedBox(
                height: height / 40,
              ),
              concert("assets/image/direction.png", "Gala Convention Center",
                  "36 Guild Street London, UK",notifire),
              SizedBox(
                height: height / 40,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Row(
                  children: [
                    Text(
                      "Members",
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Gilroy Medium',
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height / 60,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/image/p1.png",
                      height: height / 15,
                    ),
                    SizedBox(
                      width: width / 30,
                    ),
                    Image.asset(
                      "assets/image/p2.png",
                      height: height / 15,
                    ),
                    SizedBox(
                      width: width / 30,
                    ),
                    Image.asset(
                      "assets/image/p3.png",
                      height: height / 15,
                    ),
                    SizedBox(
                      width: width / 30,
                    ),
                    Container(
                      height: height / 17,
                      width: width / 7,
                      decoration: BoxDecoration(
                        color: notifire.buttonsColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          "+10",
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Gilroy Medium',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height / 60),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Row(
                  children: [
                    Text(
                      "About Event",
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Gilroy Medium',
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height / 40),
              Container(
                color: Colors.transparent,
                height: MediaQuery.of(context).size.height * 0.18,
                width: double.maxFinite,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: Text(
                    CustomStrings.ever,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Gilroy Medium',
                      color: Colors.grey,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 10,
                  ),
                ),
              ),
              SizedBox(
                height: height / 60,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget concert(img, name1, name2,ColorState notifire) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Container(
            height: context.height / 15,
            width: context.width / 7,
            decoration: BoxDecoration(
              color: notifire.cardColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Image.asset(img),
            ),
          ),
          SizedBox(
            width: context.width / 40,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name1,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Gilroy Medium',
                  color: notifire.darksColor,
                ),
              ),
              SizedBox(
                height: context.height / 300,
              ),
              Text(
                name2,
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Gilroy Medium',
                  color: Colors.grey,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

/* onTap: () {
                                  showModalBottomSheet<dynamic>(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(25.0),
                                          topRight: Radius.circular(25.0)),
                                    ),
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (BuildContext bc) {
                                      return StatefulBuilder(builder:
                                          (BuildContext context,
                                              StateSetter setState) {
                                        return Wrap(
                                          children: <Widget>[
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: notifire.cardColor,
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  25.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  25.0))),
                                              height: height / 1.2,
                                              child: DialPad(
                                                enableDtmf: true,
                                                outputMask: "(91)0000000000",
                                                backspaceButtonIconColor:
                                                    Colors.red,
                                                buttonTextColor:
                                                    notifire.darksColor,
                                                dialOutputTextColor:
                                                    notifire.darksColor,
                                                keyPressed: (value) {},
                                                makeCall: (number) {},
                                              ),
                                            ),
                                          ],
                                        );
                                      });
                                    },
                                  );
                                },*/
