import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/extensions/media_query_ext.dart';
import '/providers/color_provider.dart';
import 'package:page_transition/page_transition.dart';

import '../utils/botton.dart';

import '../utils/wtextfield.dart';
import 'interest.dart';

class Verification extends ConsumerStatefulWidget {
  const Verification({Key? key}) : super(key: key);

  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends ConsumerState<Verification> {
  late CountdownTimerController controller;
  int endTime = DateTime.now().millisecondsSinceEpoch + 7200 * 8;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

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
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: height / 20),
              Row(
                children: [
                  SizedBox(
                    width: width / 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      color: notifire.primaryColor,
                      child: Icon(
                        Icons.arrow_back,
                        color: notifire.whiteColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height / 100,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "Verification",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy Medium',
                        color: notifire.whiteColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height / 100,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "We've send you the verification",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: 'Gilroy Medium',
                            color: notifire.whiteColor,
                          ),
                        ),
                        SizedBox(
                          height: height / 400,
                        ),
                        Text(
                          "code on +12620 0323 7631",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: 'Gilroy Medium',
                            color: notifire.whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height / 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Customtextfild3.textField(notifire.whiteColor, "",
                      width / 7, TextInputType.number, 1, TextAlign.center),
                  Customtextfild3.textField(notifire.whiteColor, "",
                      width / 7, TextInputType.number, 1, TextAlign.center),
                  Customtextfild3.textField(notifire.whiteColor, "",
                      width / 7, TextInputType.number, 1, TextAlign.center),
                  Customtextfild3.textField(notifire.whiteColor, "",
                      width / 7, TextInputType.number, 1, TextAlign.center),
                ],
              ),
              SizedBox(
                height: height / 30,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: const Interest(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
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
              SizedBox(
                height: height / 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Re-send code in  ",
                      style: TextStyle(
                        color: notifire.whiteColor,
                        fontSize: 12.sp,
                        fontFamily: 'Gilroy Medium',
                      )),
                  Container(
                    color: Colors.transparent,
                    width: MediaQuery.of(context).size.width / 4,
                    child: CountdownTimer(
                      textStyle: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: 'Gilroy Medium',
                          color: const Color(0xff4e80fe),
                          fontWeight: FontWeight.w500),
                      endTime: endTime,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
