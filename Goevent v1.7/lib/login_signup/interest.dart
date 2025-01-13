import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goevent2/home/home.dart';
import 'package:page_transition/page_transition.dart';

import '../providers/color_provider.dart';
import '../utils/botton.dart';
import '../utils/media.dart';

class Interest extends ConsumerStatefulWidget {
  const Interest({Key? key}) : super(key: key);

  @override
  _InterestState createState() => _InterestState();
}

class _InterestState extends ConsumerState<Interest> {
  bool selected1 = false;
  bool selected2 = false;
  bool selected3 = false;
  bool selected4 = false;
  bool selected5 = false;
  bool selected6 = false;
  bool selected7 = false;
  bool selected8 = false;
  bool selected9 = false;
  bool selected10 = false;
  bool selected11 = false;
  bool selected12 = false;

  

  @override
  void initState() {
    super.initState();
    ref.read(colorProvider.notifier).getdarkmodepreviousstate();
  }
  // void _handleURLButtonPress(BuildContext context, String url) {
  //   Navigator.push(context,
  //       MaterialPageRoute(builder: (context) => WebViewContainer(url)));
  // }
  @override
  Widget build(BuildContext context) {
    final notifire = ref.watch(colorProvider);
    return ScreenUtilInit(
      builder:  (BuildContext context, child) =>  Scaffold(
        backgroundColor: notifire.primaryColor,
        resizeToAvoidBottomInset: false,
        floatingActionButton: Padding(
          padding: const EdgeInsets.fromLTRB(20,0,20,20),
          child: SizedBox(
            height: 45.h,
            width: 410.w,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade, child: const Home(),),
                );
              },
                //   _handleURLButtonPress(
                // context, 'http://www.googlemaps.com/'),
              child: Custombutton.button(
                notifire.buttonsColor,
                "NEXT",
                SizedBox(
                  width: width / 3,
                ),SizedBox(
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
                        child: Icon(Icons.arrow_back,
                            color: notifire.whiteColor)),
                  ),
                ],
              ),
              SizedBox(height: height / 100),
              Text(
                "Select 5 your Interest",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Gilroy Medium',
                  color: notifire.whiteColor,
                ),
              ),
              SizedBox(height: height / 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selected1 = !selected1;
                      });
                    },
                    child: interest(
                        "image/music.png","image/music1.png",
                        "Music",
                        selected1
                            ? const Color(0xff4e80fe)
                            : Colors.transparent,notifire),
                  ),
                  SizedBox(
                    width: width / 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selected2 = !selected2;
                      });
                    },
                    child: interest(
                        "image/paint.png","image/paint1.png",
                        "Art",
                        selected2
                            ? const Color(0xff4e80fe)
                            : Colors.transparent,notifire),
                  ),
                ],
              ),
              SizedBox(height: height / 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selected3 = !selected3;
                      });
                    },
                    child: interest(
                        "image/sports.png","image/sport1.png",
                        "Sport",
                        selected3
                            ? const Color(0xff4e80fe)
                            : Colors.transparent,notifire),
                  ),
                  SizedBox(
                    width: width / 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selected4 = !selected4;
                      });
                    },
                    child: interest(
                        "image/sports.png","image/party1.png",
                        "Party",
                        selected4
                            ? const Color(0xff4e80fe)
                            : Colors.transparent,notifire),
                  ),
                ],
              ),
              SizedBox(height: height / 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selected5 = !selected5;
                      });
                    },
                    child: interest(
                        "image/paint.png","image/paint1.png",
                        "Food",
                        selected5
                            ? const Color(0xff4e80fe)
                            : Colors.transparent,notifire),
                  ),
                  SizedBox(
                    width: width / 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selected6 = !selected6;
                      });
                    },
                    child: interest(
                        "image/music.png","image/other1.png",
                        "Others",
                        selected6
                            ? const Color(0xff4e80fe)
                            : Colors.transparent,notifire),
                  ),
                ],
              ),
              SizedBox(height: height / 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget interest(img1,img2, name, clr,ColorState notifire) {
    return Column(
      children: [
        Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(
                width: 2,
                color: clr,
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  img1,
                  height: height / 6,
                ),
                Center(
                  child: Image.asset(
                   img2,
                    height: height / 10,
                  ),
                ),
              ],
            )),
        SizedBox(
          height: height / 40,
        ),
        Text(name, style: TextStyle(
          color: notifire.whiteColor,
          fontSize: 12.sp,
          fontFamily: 'Gilroy Medium',
        ),),
      ],
    );
  }
}
