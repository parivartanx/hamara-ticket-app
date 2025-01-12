import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goevent2/organizer/about.dart';
import 'package:goevent2/organizer/events.dart';
import 'package:goevent2/organizer/message.dart';
import 'package:goevent2/organizer/review.dart';
import 'package:goevent2/utils/string.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/colornotifire.dart';
import '../utils/media.dart';

class Organize extends StatefulWidget {
  const Organize({Key? key}) : super(key: key);

  @override
  _OrganizeState createState() => _OrganizeState();
}

class _OrganizeState extends State<Organize> with SingleTickerProviderStateMixin  {

  TabController? controller;
  List<Widget> tabs = const [
    About(),
    Event(),
    Review(),
  ];
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
    controller = TabController(length: 3, vsync: this);
  }

  late ColorNotifire notifire;

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return ScreenUtilInit(
      builder:  (BuildContext context, child) =>  Scaffold(
        backgroundColor: notifire.getprimerycolor,
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
                    child: Icon(Icons.arrow_back, color: notifire.getdarkscolor),
                  ),
                  SizedBox(
                    width: width / 80,
                  ),
                  const Spacer(),
                  const Icon(Icons.more_vert),
                  SizedBox(
                    width: width / 20,
                  ),
                ],
              ),
              SizedBox(
                height: height / 25,
              ),
              Image.asset(
                "image/p1.png",
                height: height / 9,
              ),
              SizedBox(
                height: height / 40,
              ),
              Text(
                CustomStrings.devid,
                style: TextStyle(
                  fontSize: 19.sp,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Gilroy Medium',
                  color: notifire.getdarkscolor,
                ),
              ),
              SizedBox(
                height: height / 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        "350",
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Gilroy Medium',
                          color: notifire.getdarkscolor,
                        ),
                      ),
                      SizedBox(
                        height: height / 120,
                      ),
                      Text(
                        "Following",
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontFamily: 'Gilroy Medium',
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: width / 30,
                  ),
                  Container(
                    height: height / 20,
                    color: Colors.grey,
                    width: width / 200,
                  ),
                  SizedBox(
                    width: width / 30,
                  ),
                  Column(
                    children: [
                      Text(
                        "346",
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Gilroy Medium',
                          color: notifire.getdarkscolor,
                        ),
                      ),
                      SizedBox(
                        height: height / 120,
                      ),
                      Text(
                        "Followers",
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontFamily: 'Gilroy Medium',
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: height / 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buttons("image/user-plus.png","Follow",notifire.getbuttonscolor,Colors.white,Border.all(color: notifire.getbuttonscolor),SizedBox(
                      width: width /
                          10,
                    ),),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                child: const Message()));
                      },
                      child: buttons("image/mes.png","Message",Colors.white,notifire.getbuttonscolor,Border.all(color: notifire.getbuttonscolor),SizedBox(
                        width: width /
                            12,
                      ),),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: height / 1.7,
                  color: Colors.transparent,
                  child: Column(
                    children: <Widget>[
                      TabBar(
                        indicatorColor: notifire.getbuttonscolor,
                        indicatorSize: TabBarIndicatorSize.label,
                        controller: controller,
                        labelColor: notifire.getbuttonscolor,
                        unselectedLabelColor: Colors.grey,
                        tabs: const [
                          Tab(text: "ABOUT"),
                          Tab(text: "EVENT"),
                          Tab(text: "REVIEW"),
                        ],
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.transparent,
                          child: TabBarView(
                            controller: controller,
                            children: tabs.map((tab) => tab).toList(),
                          ),
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
  Widget buttons (img,name,clr,clr1,bor,siz){
    return Container(
      height: height / 18,
      width: width / 2.5,
      decoration: BoxDecoration(
        border: bor,
        color: clr,
        borderRadius: const BorderRadius.all(Radius.circular(10),),
      ),
      child:  Center(
        child: Row(
          children: [
            siz,
            Image.asset(
              img, color: clr1,
              height:
              height /
                  50,
            ),
            SizedBox(
              width: width /
                  40,
            ),
             Text(
              name,
              style:  TextStyle(
                  color: clr1,
                  fontFamily: 'Gilroy Medium',
                  fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}

