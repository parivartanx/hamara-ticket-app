import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goevent2/organizer/about.dart';
import 'package:goevent2/organizer/events.dart';
import 'package:goevent2/organizer/message.dart';
import 'package:goevent2/organizer/review.dart';
import 'package:goevent2/providers/color_provider.dart';
import 'package:goevent2/utils/string.dart';
import 'package:page_transition/page_transition.dart';

import '../utils/media.dart';

class Organize extends ConsumerStatefulWidget {
  const Organize({Key? key}) : super(key: key);

  @override
  _OrganizeState createState() => _OrganizeState();
}

class _OrganizeState extends ConsumerState<Organize> with SingleTickerProviderStateMixin  {

  TabController? controller;
  List<Widget> tabs = const [
    About(),
    Event(),
    Review(),
  ];

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
    ref.read(colorProvider.notifier).getdarkmodepreviousstate();
  }


  @override
  Widget build(BuildContext context) {
    final notifire = ref.watch(colorProvider);
    return ScreenUtilInit(
      builder:  (BuildContext context, child) =>  Scaffold(
        backgroundColor: notifire.primaryColor,
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
                    child: Icon(Icons.arrow_back, color: notifire.darksColor),
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
                  color: notifire.darksColor,
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
                          color: notifire.darksColor,
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
                          color: notifire.darksColor,
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
                    buttons("image/user-plus.png","Follow",notifire.buttonsColor,Colors.white,Border.all(color: notifire.buttonsColor),SizedBox(
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
                      child: buttons("image/mes.png","Message",Colors.white,notifire.buttonsColor,Border.all(color: notifire.buttonsColor),SizedBox(
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
                        indicatorColor: notifire.buttonsColor,
                        indicatorSize: TabBarIndicatorSize.label,
                        controller: controller,
                        labelColor: notifire.buttonsColor,
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

