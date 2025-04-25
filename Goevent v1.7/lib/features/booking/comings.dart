import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/extensions/media_query_ext.dart';
import '/providers/color_provider.dart';
import 'package:page_transition/page_transition.dart';

import 'presentation/screens/booking.dart';


class Comings extends ConsumerStatefulWidget {
  const Comings({Key? key}) : super(key: key);

  @override
  _ComingsState createState() => _ComingsState();
}

class _ComingsState extends ConsumerState<Comings> {
  bool selected = false;
  bool selected1 = false;
  bool selected2 = false;
  bool selected3 = false;

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
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height / 60,
              ),
              events(
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selected = !selected;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: notifire.primaryColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                      ),
                      height: height / 25,
                      width: width / 10,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: selected
                            ? Image.asset("assets/image/book1.png")
                            : Image.asset(
                                "assets/image/book2.png",
                                color: const Color(0xffF0635A),
                              ),
                      ),
                    ),
                  ),
                  "assets/image/p11.png",notifire),
              SizedBox(
                height: height / 60,
              ),
              events(
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selected1 = !selected1;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: notifire.primaryColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                      ),
                      height: height / 25,
                      width: width / 10,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: selected1
                            ? Image.asset("assets/image/book1.png")
                            : Image.asset(
                                "assets/image/book2.png",
                                color: const Color(0xffF0635A),
                              ),
                      ),
                    ),
                  ),
                  "assets/image/p10.png",notifire),
              SizedBox(
                height: height / 60,
              ),
              events(
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selected2 = !selected2;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: notifire.primaryColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                      ),
                      height: height / 25,
                      width: width / 10,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: selected2
                            ? Image.asset("assets/image/book1.png")
                            : Image.asset(
                                "assets/image/book2.png",
                                color: const Color(0xffF0635A),
                              ),
                      ),
                    ),
                  ),
                  "assets/image/p11.png",notifire),
              SizedBox(
                height: height / 60,
              ),
              events(
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selected3 = !selected3;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: notifire.primaryColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                      ),
                      height: height / 25,
                      width: width / 10,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: selected3
                            ? Image.asset("assets/image/book1.png")
                            : Image.asset(
                                "assets/image/book2.png",
                                color: const Color(0xffF0635A),
                              ),
                      ),
                    ),
                  ),
                  "assets/image/p10.png",notifire),
              SizedBox(
                height: height / 60,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget events(se, img,ColorState notifire) {
    return Stack(
      children: [
        GestureDetector(
          onTap: (){
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade,
                    child: const Booking()));
          },
          child: Container(
            decoration: BoxDecoration(
                color: notifire.primaryColor,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  width: 1,
                  color: const Color(0xffdcdbdb),
                )
            ),
            width: context.width,
            child: Card(
              elevation: 0,
              color: notifire.primaryColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: context.height / 5.5,
                          width: context.width,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: Colors.transparent,
                          ),
                          child: Stack(
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.asset(
                                    img,
                                    fit: BoxFit.cover,
                                    height: context.height / 3.5,
                                    width: context.width,
                                  )),
                              Column(
                                children: [
                                  SizedBox(
                                    height: context.height / 70,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: context.height / 40,
                        ),
                        Text(
                          "Women's Leadership Conference",
                          style: TextStyle(
                              color: notifire.darksColor,
                              fontSize: 16.sp,fontFamily: 'Gilroy Medium',
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: context.height / 120,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "assets/image/location.png",
                              height: context.height / 40,
                            ),
                            Text(
                              " 36 Guild Street London , UK",
                              style: TextStyle(
                                color: Colors.grey,fontFamily: 'Gilroy Medium',
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: context.height / 100,
                        ),
                        Stack(
                          children: [
                            Image.asset(
                              "assets/image/p1.png",
                              height: context.height / 28,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: context.width / 20,
                                ),
                                Stack(
                                  children: [
                                    Image.asset(
                                      "assets/image/p2.png",
                                      height: context.height / 30,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: context.width / 20,
                                        ),
                                        Stack(
                                          children: [
                                            Image.asset(
                                              "assets/image/p3.png",
                                              height: context.height / 30,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Text(
                                  " + 20 Going",
                                  style: TextStyle(
                                    color: const Color(0xff5d56f3),
                                    fontSize: 11.sp,
                                    fontFamily: 'Gilroy Bold',
                                  ),
                                ),
                                const Spacer(),
                                se,
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
