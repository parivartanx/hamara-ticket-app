// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:goevent2/booking/upcoming.dart';
import 'package:goevent2/home/bookmark.dart';
import 'package:goevent2/home/contact.dart';
import 'package:goevent2/home/event.dart';
import 'package:goevent2/home/faq.dart';
import 'package:goevent2/home/seeall.dart';
import 'package:goevent2/home/settings.dart';
import 'package:goevent2/home/upgrade.dart';
import 'package:goevent2/login_signup/login.dart';
import 'package:goevent2/organizer/message.dart';
import 'package:goevent2/profile/profile.dart';
import 'package:goevent2/utils/string.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../notification/notification.dart';
import '../utils/colornotifire.dart';
import '../utils/media.dart';

final ZoomDrawerController z = ZoomDrawerController();

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late ColorNotifire notifire;
  bool selected = false;

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
    return ZoomDrawer(
      controller: z,
      borderRadius: 24,
      style: DrawerStyle.style2,
      openCurve: Curves.bounceInOut,
      disableDragGesture: true,
      mainScreenTapClose: true,
      menuScreenTapClose: true,
      drawerShadowsBackgroundColor: Colors.black12,
      slideWidth: MediaQuery.of(context).size.width * 0.70,
      duration: const Duration(milliseconds: 500),
      menuBackgroundColor: Colors.white24,
      showShadow: true,
      angle: 0.0,
      clipMainScreen: true,
      mainScreen: const Body(),
      menuScreen: Theme(
        data: ThemeData.dark(),
        child: const Scaffold(
          body: Side(),
          //ListTile(title: Text('One-line ListTile')),
        ),
      ),
    );
  }
}

/*ZoomDrawer(
      controller: z,
      borderRadius: 24,
      style: DrawerStyle.Style1,
      openCurve: Curves.fastOutSlowIn,
      disableGesture: false,
      mainScreenTapClose: false,
      slideWidth: MediaQuery.of(context).size.width * 0.65,
      duration: const Duration(milliseconds: 500),
      backgroundColor: Colors.white24,
      showShadow: true,
      angle: 0.0,
      clipMainScreen: true,
      mainScreen: const Body(),
      menuScreen: Theme(
        data: ThemeData.dark(),
        child: const Scaffold(
          body: Side(),
          //ListTile(title: Text('One-line ListTile')),
        ),
      ),
    );*/

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  late AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 100),
    value: -1.0,
  );

  bool get isPanelVisible {
    final AnimationStatus status = controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

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
    return Scaffold(
      backgroundColor: notifire.getprimerycolor,
      body: TwoPanels(
        controller: controller,
      ),
    );
  }
}

class TwoPanels extends StatefulWidget {
  final AnimationController controller;

  const TwoPanels({Key? key, required this.controller}) : super(key: key);

  @override
  _TwoPanelsState createState() => _TwoPanelsState();
}

class _TwoPanelsState extends State<TwoPanels> with TickerProviderStateMixin {
  static const header_height = 32.0;
  late TabController tabController = TabController(length: 3, vsync: this);

  Animation<RelativeRect> getPanelAnimation(BoxConstraints constraints) {
    final height = constraints.biggest.height;
    final backPanelHeight = height - header_height;
    const frontPanelHeight = -header_height;

    return RelativeRectTween(
      begin: RelativeRect.fromLTRB(0.0, backPanelHeight, 0.0, frontPanelHeight),
      end: const RelativeRect.fromLTRB(0.0, 100, 0.0, 0.0),
    ).animate(
      CurvedAnimation(parent: widget.controller, curve: Curves.linear),
    );
  }

  late ColorNotifire notifire;
  bool selected = false;
  bool selected1 = false;
  bool selected2 = false;
  bool selected3 = false;
  bool selected4 = false;
  bool selected5 = false;
  bool selected6 = false;
  bool selected7 = false;
  bool selected8 = false;
  bool selected9 = false;
  bool selected0 = false;

  bool isChecked = false;
  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;
  bool isChecked4 = false;
  bool isChecked5 = false;
  bool isChecked6 = false;
  bool isChecked7 = false;
  bool isChecked8 = false;
  bool isChecked9 = false;

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

    return Scaffold(
      backgroundColor: notifire.getprimerycolor,
      body: LayoutBuilder(
        builder: (BuildContext ctx, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: notifire.gettopcolor,
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                        ),
                      ),
                      height: height / 4.2,
                      child: Column(
                        children: [
                          SizedBox(height: height / 12),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    z.toggle!();
                                  },
                                  child: Container(
                                    height: height / 25,
                                    color: Colors.transparent,
                                    child: Padding(
                                      padding: const EdgeInsets.all(7),
                                      child: Image.asset(
                                        "image/draw.png",
                                        height: height / 50,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: width / 3.9,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "Current Location",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10.sp,
                                        fontFamily: 'Gilroy Medium',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      "New Yourk, USA",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.sp,
                                        fontFamily: 'Gilroy Medium',
                                        fontWeight: FontWeight.w600,
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
                                        child: const Note(),
                                      ),
                                    );
                                  },
                                  child: Image.asset(
                                    "image/bell.png",
                                    height: height / 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: height / 50),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                Image.asset(
                                  "image/search.png",
                                  height: height / 30,
                                ),
                                SizedBox(width: width / 90),
                                Container(
                                  width: 1,
                                  height: height / 40,
                                  color: Colors.grey,
                                ),
                                SizedBox(width: width / 90),
                                Container(
                                  color: Colors.transparent,
                                  height: height / 20,
                                  width: width / 1.7,
                                  child: TextField(
                                    style: TextStyle(
                                        fontFamily: 'Gilroy Medium',
                                        color: Colors.white,
                                        fontSize: 15.sp),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      hintText: "Search...",
                                      hintStyle: TextStyle(
                                          fontFamily: 'Gilroy Medium',
                                          color: const Color(0xffd2d2db),
                                          fontSize: 15.sp),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(height: height / 4.9),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                games("image/music1.png", CustomStrings.musics),
                                games("image/paint1.png", CustomStrings.art),
                                games("image/sport1.png", CustomStrings.sport),
                                games("image/party1.png", CustomStrings.party),
                                games("image/paint1.png", CustomStrings.food),
                                games("image/other1.png", CustomStrings.others),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: height / 60),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      Text(
                        CustomStrings.upcoming,
                        style: TextStyle(
                            fontFamily: 'Gilroy Medium',
                            color: notifire.gettextcolor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: const All()));
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: Row(
                            children: [
                              Text(
                                CustomStrings.seeall,
                                style: TextStyle(
                                    fontFamily: 'Gilroy Medium',
                                    color: const Color(0xff747688),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                              const Icon(
                                Icons.arrow_right,
                                color: Color(0xff747688),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height / 60),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(width: 10),
                      events(
                          GestureDetector(
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.7),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                height: height / 25,
                                width: width / 12,
                                child: Padding(
                                    padding: const EdgeInsets.all(7),
                                    child: selected
                                        ? Image.asset("image/book1.png")
                                        : Image.asset(
                                            "image/book2.png",
                                            color: const Color(0xffF0635A),
                                          ))),
                          ),
                          "image/g1.png"),
                      SizedBox(
                        width: width / 100,
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
                                  color: Colors.white.withOpacity(0.7),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5)),
                                ),
                                height: height / 25,
                                width: width / 12,
                                child: Padding(
                                    padding: const EdgeInsets.all(7),
                                    child: selected1
                                        ? Image.asset("image/book1.png")
                                        : Image.asset(
                                            "image/book2.png",
                                            color: const Color(0xffF0635A),
                                          ))),
                          ),
                          "image/g2.png"),
                      SizedBox(
                        width: width / 100,
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
                                  color: Colors.white.withOpacity(0.7),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5)),
                                ),
                                height: height / 25,
                                width: width / 12,
                                child: Padding(
                                    padding: const EdgeInsets.all(7),
                                    child: selected2
                                        ? Image.asset("image/book1.png")
                                        : Image.asset(
                                            "image/book2.png",
                                            color: const Color(0xffF0635A),
                                          ))),
                          ),
                          "image/g3.png"),
                      SizedBox(
                        width: width / 100,
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
                                  color: Colors.white.withOpacity(0.7),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5)),
                                ),
                                height: height / 25,
                                width: width / 12,
                                child: Padding(
                                    padding: const EdgeInsets.all(7),
                                    child: selected3
                                        ? Image.asset("image/book1.png")
                                        : Image.asset(
                                            "image/book2.png",
                                            color: const Color(0xffF0635A),
                                          ))),
                          ),
                          "image/g4.png"),
                      SizedBox(
                        width: width / 100,
                      ),
                      events(
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selected4 = !selected4;
                              });
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.7),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5)),
                                ),
                                height: height / 25,
                                width: width / 12,
                                child: Padding(
                                    padding: const EdgeInsets.all(7),
                                    child: selected4
                                        ? Image.asset("image/book1.png")
                                        : Image.asset(
                                            "image/book2.png",
                                            color: const Color(0xffF0635A),
                                          ))),
                          ),
                          "image/g1.png"),
                      SizedBox(
                        width: width / 100,
                      ),
                      events(
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selected5 = !selected5;
                              });
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.7),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5)),
                                ),
                                height: height / 25,
                                width: width / 12,
                                child: Padding(
                                    padding: const EdgeInsets.all(7),
                                    child: selected5
                                        ? Image.asset("image/book1.png")
                                        : Image.asset(
                                            "image/book2.png",
                                            color: const Color(0xffF0635A),
                                          ))),
                          ),
                          "image/g2.png"),
                      SizedBox(width: 10),
                    ],
                  ),
                ),
                SizedBox(height: height / 60),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Container(
                    decoration: BoxDecoration(
                      color: notifire.getorangecolor,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    height: height / 6,
                    child: Row(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: height / 40,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: width / 30,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      CustomStrings.invites,
                                      style: TextStyle(
                                          fontFamily: 'Gilroy Medium',
                                          color: notifire.getdarkscolor,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(
                                      height: height / 90,
                                    ),
                                    Text(
                                      CustomStrings.get,
                                      style: TextStyle(
                                          fontFamily: 'Gilroy Medium',
                                          color: Colors.grey,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: height / 90,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet<dynamic>(
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(25.0),
                                                topRight:
                                                    Radius.circular(25.0)),
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
                                                      color:
                                                          notifire.getcardcolor,
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topLeft:
                                                            Radius.circular(
                                                                25.0),
                                                        topRight:
                                                            Radius.circular(
                                                          25.0,
                                                        ),
                                                      ),
                                                    ),
                                                    height: height / 1.08,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            SizedBox(
                                                              height:
                                                                  height / 80,
                                                            ),
                                                            Container(
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color:
                                                                    Colors.grey,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                    10,
                                                                  ),
                                                                ),
                                                              ),
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height /
                                                                  80,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  7,
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  height / 80,
                                                            ),
                                                            Container(
                                                              color: Colors
                                                                  .transparent,
                                                              height: 45.h,
                                                              width: 300.w,
                                                              child: TextField(
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Gilroy Medium',
                                                                    color: notifire
                                                                        .getdarkscolor),
                                                                decoration:
                                                                    InputDecoration(
                                                                  labelText:
                                                                      CustomStrings
                                                                          .search,
                                                                  labelStyle: const TextStyle(
                                                                      fontFamily:
                                                                          'Gilroy Medium',
                                                                      color: Colors
                                                                          .grey),
                                                                  disabledBorder:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20.sp),
                                                                  ),
                                                                  suffixIcon:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            17),
                                                                    child: Image
                                                                        .asset(
                                                                      "image/search2.png",
                                                                    ),
                                                                  ),
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20.sp),
                                                                  ),
                                                                  enabledBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide: const BorderSide(
                                                                        color: Color(
                                                                            0xff80818d),
                                                                        width:
                                                                            1),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20.sp),
                                                                  ),
                                                                  focusedBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide: const BorderSide(
                                                                        color: Color(
                                                                            0xff5669FF),
                                                                        width:
                                                                            1),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20.sp),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  height / 80,
                                                            ),
                                                            rights(
                                                              SizedBox(
                                                                width:
                                                                    width / 2.5,
                                                              ),
                                                              "Angelina Zolly",
                                                              "2k Followers",
                                                              "image/p1.png",
                                                              notifire
                                                                  .gettextcolor,
                                                              Center(
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      isChecked =
                                                                          !isChecked;
                                                                    });
                                                                  },
                                                                  child:
                                                                      Container(
                                                                          height: height /
                                                                              37,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: isChecked
                                                                                ? notifire.getbuttonscolor
                                                                                : notifire.getpinkcolor,
                                                                          ),
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(5.0),
                                                                              child: Image.asset("image/right.png"),
                                                                            ),
                                                                          )),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  height / 70,
                                                            ),
                                                            rights(
                                                              SizedBox(
                                                                width:
                                                                    width / 2.5,
                                                              ),
                                                              "Micheal Ulasi",
                                                              "56 Follwers",
                                                              "image/p2.png",
                                                              notifire
                                                                  .gettextcolor,
                                                              Center(
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      isChecked1 =
                                                                          !isChecked1;
                                                                    });
                                                                  },
                                                                  child:
                                                                      Container(
                                                                          height: height /
                                                                              37,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: isChecked1
                                                                                ? notifire.getbuttonscolor
                                                                                : notifire.getpinkcolor,
                                                                          ),
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(5.0),
                                                                              child: Image.asset("image/right.png"),
                                                                            ),
                                                                          )),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  height / 70,
                                                            ),
                                                            rights(
                                                              SizedBox(
                                                                width:
                                                                    width / 2.5,
                                                              ),
                                                              "Angelina Zolly",
                                                              "2k Followers",
                                                              "image/p3.png",
                                                              notifire
                                                                  .gettextcolor,
                                                              Center(
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      isChecked2 =
                                                                          !isChecked2;
                                                                    });
                                                                  },
                                                                  child:
                                                                      Container(
                                                                          height: height /
                                                                              37,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: isChecked2
                                                                                ? notifire.getbuttonscolor
                                                                                : notifire.getpinkcolor,
                                                                          ),
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(5.0),
                                                                              child: Image.asset("image/right.png"),
                                                                            ),
                                                                          )),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  height / 70,
                                                            ),
                                                            rights(
                                                              SizedBox(
                                                                width:
                                                                    width / 2.2,
                                                              ),
                                                              "Cristofer",
                                                              "300 Follwers",
                                                              "image/p4.png",
                                                              notifire
                                                                  .gettextcolor,
                                                              Center(
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      isChecked3 =
                                                                          !isChecked3;
                                                                    });
                                                                  },
                                                                  child:
                                                                      Container(
                                                                          height: height /
                                                                              37,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: isChecked3
                                                                                ? notifire.getbuttonscolor
                                                                                : notifire.getpinkcolor,
                                                                          ),
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(5.0),
                                                                              child: Image.asset("image/right.png"),
                                                                            ),
                                                                          )),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  height / 70,
                                                            ),
                                                            rights(
                                                              SizedBox(
                                                                width:
                                                                    width / 2.4,
                                                              ),
                                                              "David  Silbia",
                                                              "5k Follwers",
                                                              "image/p1.png",
                                                              notifire
                                                                  .gettextcolor,
                                                              Center(
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      isChecked4 =
                                                                          !isChecked4;
                                                                    });
                                                                  },
                                                                  child:
                                                                      Container(
                                                                          height: height /
                                                                              37,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: isChecked4
                                                                                ? notifire.getbuttonscolor
                                                                                : notifire.getpinkcolor,
                                                                          ),
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(5.0),
                                                                              child: Image.asset("image/right.png"),
                                                                            ),
                                                                          )),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  height / 70,
                                                            ),
                                                            rights(
                                                              SizedBox(
                                                                width:
                                                                    width / 2.5,
                                                              ),
                                                              "Ashfak Sayem",
                                                              "402 Follwers",
                                                              "image/p2.png",
                                                              notifire
                                                                  .gettextcolor,
                                                              Center(
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      isChecked5 =
                                                                          !isChecked5;
                                                                    });
                                                                  },
                                                                  child:
                                                                      Container(
                                                                          height: height /
                                                                              37,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: isChecked5
                                                                                ? notifire.getbuttonscolor
                                                                                : notifire.getpinkcolor,
                                                                          ),
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(5.0),
                                                                              child: Image.asset("image/right.png"),
                                                                            ),
                                                                          )),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  height / 70,
                                                            ),
                                                            rights(
                                                              SizedBox(
                                                                width:
                                                                    width / 2.9,
                                                              ),
                                                              "Rocks Velkeinjen ",
                                                              "893 Follwers",
                                                              "image/p3.png",
                                                              notifire
                                                                  .gettextcolor,
                                                              Center(
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      isChecked6 =
                                                                          !isChecked6;
                                                                    });
                                                                  },
                                                                  child:
                                                                      Container(
                                                                          height: height /
                                                                              37,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: isChecked6
                                                                                ? notifire.getbuttonscolor
                                                                                : notifire.getpinkcolor,
                                                                          ),
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(5.0),
                                                                              child: Image.asset("image/right.png"),
                                                                            ),
                                                                          )),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  height / 70,
                                                            ),
                                                            rights(
                                                              SizedBox(
                                                                width:
                                                                    width / 2.7,
                                                              ),
                                                              "Roman Kutepov",
                                                              "225 Follwers",
                                                              "image/p4.png",
                                                              notifire
                                                                  .gettextcolor,
                                                              Center(
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      isChecked7 =
                                                                          !isChecked7;
                                                                    });
                                                                  },
                                                                  child:
                                                                      Container(
                                                                          height: height /
                                                                              37,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: isChecked7
                                                                                ? notifire.getbuttonscolor
                                                                                : notifire.getpinkcolor,
                                                                          ),
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(5.0),
                                                                              child: Image.asset("image/right.png"),
                                                                            ),
                                                                          )),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  height / 70,
                                                            ),
                                                            rights(
                                                              SizedBox(
                                                                width:
                                                                    width / 2.7,
                                                              ),
                                                              "Cristofer Nolan ",
                                                              "322 Follwers",
                                                              "image/p1.png",
                                                              notifire
                                                                  .gettextcolor,
                                                              Center(
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      isChecked8 =
                                                                          !isChecked8;
                                                                    });
                                                                  },
                                                                  child:
                                                                      Container(
                                                                          height: height /
                                                                              37,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: isChecked8
                                                                                ? notifire.getbuttonscolor
                                                                                : notifire.getpinkcolor,
                                                                          ),
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(5.0),
                                                                              child: Image.asset("image/right.png"),
                                                                            ),
                                                                          )),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  height / 70,
                                                            ),
                                                            rights(
                                                              SizedBox(
                                                                width:
                                                                    width / 2.3,
                                                              ),
                                                              "Jhon Wick",
                                                              "2k Follwers",
                                                              "image/p2.png",
                                                              notifire
                                                                  .gettextcolor,
                                                              Center(
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      isChecked9 =
                                                                          !isChecked9;
                                                                    });
                                                                  },
                                                                  child:
                                                                      Container(
                                                                          height: height /
                                                                              37,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: isChecked9
                                                                                ? notifire.getbuttonscolor
                                                                                : notifire.getpinkcolor,
                                                                          ),
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(5.0),
                                                                              child: Image.asset("image/right.png"),
                                                                            ),
                                                                          )),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  height / 70,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              );
                                            });
                                          },
                                        );
                                      },
                                      child: Container(
                                        height: height / 30,
                                        width: width / 6,
                                        color: notifire.getbluecolor,
                                        child: Center(
                                          child: Text(
                                            CustomStrings.invite,
                                            style: TextStyle(
                                              fontFamily: 'Gilroy Medium',
                                              color: Colors.white,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              "image/invite.png",
                              height: height / 6,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: height / 60),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      Text(
                        "Nearby You",
                        style: TextStyle(
                            fontFamily: 'Gilroy Medium',
                            color: notifire.gettextcolor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              child: const All(),
                            ),
                          );
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: Row(
                            children: [
                              Text(
                                "See All",
                                style: TextStyle(
                                    fontFamily: 'Gilroy Medium',
                                    color: const Color(0xff747688),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                              const Icon(
                                Icons.arrow_right,
                                color: Color(0xff747688),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height / 60),
                conference(
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selected6 = !selected6;
                        });
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        height: height / 25,
                        width: width / 10,
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: selected6
                              ? Image.asset("image/book1.png")
                              : Image.asset(
                                  "image/book2.png",
                                  color: const Color(0xffF0635A),
                                ),
                        ),
                      ),
                    ),
                    "image/n1.png"),
                conference(
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selected7 = !selected7;
                        });
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        height: height / 25,
                        width: width / 10,
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: selected7
                              ? Image.asset("image/book1.png")
                              : Image.asset(
                                  "image/book2.png",
                                  color: const Color(0xffF0635A),
                                ),
                        ),
                      ),
                    ),
                    "image/n2.png"),
                conference(
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selected8 = !selected8;
                        });
                      },
                      child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          height: height / 25,
                          width: width / 10,
                          child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: selected8
                                  ? Image.asset("image/book1.png")
                                  : Image.asset(
                                      "image/book2.png",
                                      color: const Color(0xffF0635A),
                                    ))),
                    ),
                    "image/n3.png"),
                conference(
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selected9 = !selected9;
                        });
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        height: height / 25,
                        width: width / 10,
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: selected9
                              ? Image.asset("image/book1.png")
                              : Image.asset(
                                  "image/book2.png",
                                  color: const Color(0xffF0635A),
                                ),
                        ),
                      ),
                    ),
                    "image/n4.png"),

                conference(
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selected0 = !selected0;
                        });
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        height: height / 25,
                        width: width / 10,
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: selected0
                              ? Image.asset("image/book1.png")
                              : Image.asset(
                                  "image/book2.png",
                                  color: const Color(0xffF0635A),
                                ),
                        ),
                      ),
                    ),
                    "image/n5.png"),
                SizedBox(
                  height: height / 60,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Text(
                        "Event This Month",
                        style: TextStyle(
                            fontFamily: 'Gilroy Medium',
                            color: notifire.gettextcolor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              child: const All(),
                            ),
                          );
                        },
                        child: Text(
                          "See All",
                          style: TextStyle(
                              fontFamily: 'Gilroy Medium',
                              color: const Color(0xff747688),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height / 60,
                ),
                monthly("image/n1.png", "Halloween Festival"),

                monthly("image/n2.png", "Women's Festival"),

                monthly("image/n3.png", "Halloween Festival"),

                monthly("image/n4.png", "Women's Festival"),

                monthly("image/n5.png", "Halloween Festival"),
                SizedBox(
                  height: height / 60,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget monthly(img, name) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.fade, child: const Events()));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Card(
          elevation: 0,
          // color: notifire.getprimerycolor,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: notifire.getprimerycolor,
              border: Border.all(
                color: Color(0xffdcdbdb),
                width: 1,
              ),
            ),
            height: height / 7,
            width: width,
            child: Row(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, bottom: 5, top: 5),
                      child: Row(
                        children: [
                          Container(
                            width: width / 5,
                            height: height / 8,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              child: Image.asset(
                                img,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: height / 200,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: width / 50,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            name,
                                            style: TextStyle(
                                                fontFamily: 'Gilroy Medium',
                                                color: notifire.getdarkscolor,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: height / 100,
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            "image/location.png",
                                            height: height / 70,
                                          ),
                                          Text(
                                            " 36 Guild Street London , UK",
                                            style: TextStyle(
                                              fontFamily: 'Gilroy Medium',
                                              color: Colors.grey,
                                              fontSize: 10.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: height / 100,
                                      ),
                                      Stack(
                                        children: [
                                          Image.asset(
                                            "image/p1.png",
                                            height: height / 30,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: width / 20,
                                              ),
                                              Stack(
                                                children: [
                                                  Image.asset(
                                                    "image/p2.png",
                                                    height: height / 30,
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width: width / 20,
                                                      ),
                                                      Stack(
                                                        children: [
                                                          Image.asset(
                                                            "image/p3.png",
                                                            height: height / 30,
                                                          ),
                                                          Row(
                                                            children: [
                                                              SizedBox(
                                                                width:
                                                                    width / 20,
                                                              ),
                                                              Stack(
                                                                children: [
                                                                  Image.asset(
                                                                    "image/p4.png",
                                                                    height:
                                                                        height /
                                                                            30,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Text(" 250 + Joined",
                                                  style: TextStyle(
                                                    color:
                                                        const Color(0xffF0635A),
                                                    fontSize: 12.sp,
                                                    fontFamily: 'Gilroy Bold',
                                                  )),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height / 80,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    SizedBox(
                      height: height / 80,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: notifire.getpinkcolor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      height: height / 13,
                      width: width / 8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Feb",
                            style: TextStyle(
                                color: notifire.getdarkscolor,
                                fontSize: 14.sp,
                                fontFamily: 'Gilroy Bold',
                                fontWeight: FontWeight.bold),
                          ),
                          Text("12",
                              style: TextStyle(
                                  color: const Color(0xffF0635A),
                                  fontSize: 15.sp,
                                  fontFamily: 'Gilroy ExtraBold',
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: width / 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget rights(se, name1, name, img, txtcolor, ce) {
    return Row(
      // mainAxisAlignment : MainAxisAlignment.center,
      children: [
        Image.asset(
          img,
          height: height / 15,
        ),
        SizedBox(
          width: width / 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name1,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
                fontFamily: 'Gilroy Bold',
                color: txtcolor,
              ),
            ),
            Text(
              name,
              style: TextStyle(
                fontSize: 11.sp,
                fontFamily: 'Gilroy Normal',
                color: Colors.grey,
              ),
            ),
          ],
        ),
        se,
        ce,
      ],
    );
  }

  Widget conference(se, img) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: const Events(),
            ),
          );
        },
        child: Card(
          elevation: 0,
          /*color: notifire.getprimerycolor,*/
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: notifire.getprimerycolor,
              border: Border.all(
                color: Color(0xffdcdbdb),
                width: 1,
              ),
            ),
            height: height / 6.8,
            width: width,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 8, bottom: 5, top: 5),
              child: Row(
                children: [
                  Container(
                    width: width / 5,
                    height: height / 8,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: Image.asset(
                        img,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: height / 180,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: width / 50,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width*0.66,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "1 ST MAY - SAT -2:00 PM",
                                      style: TextStyle(
                                          fontFamily: 'Gilroy Medium',
                                          color: const Color(0xff4A43EC),
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w600),
                                    ),

                                    se,
                                  ],
                                ),
                              ),
                              Text(
                                "Women's leadership \n conference",
                                style: TextStyle(
                                    fontFamily: 'Gilroy Medium',
                                    color: notifire.getdarkscolor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: height / 200,
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    "image/location.png",
                                    height: height / 70,
                                  ),
                                  Text(
                                    " 36 Guild Street London , UK",
                                    style: TextStyle(
                                      fontFamily: 'Gilroy Medium',
                                      color: Colors.grey,
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height / 80,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget events(se, img) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade, child: const Events()));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: notifire.getprimerycolor,
                border: Border.all(
                  color: Color(0xffdcdbdb),
                  width: 1,
                ),
              ),

              width: width / 1.5,
              child: Card(
                elevation: 0,
                color: notifire.getprimerycolor,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: height / 5.5,
                            width: width / 1.7,
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
                                      height: height / 3.5,
                                    )),
                                Column(
                                  children: [
                                    SizedBox(
                                      height: height / 70,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: width / 70,
                                        ),
                                        const Spacer(),
                                        se,
                                        SizedBox(
                                          width: width / 40,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height / 40,
                          ),
                          Text(
                            "International Band Music...",
                            style: TextStyle(
                                fontFamily: 'Gilroy Medium',
                                color: notifire.getdarkscolor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: height / 40,
                          ),
                          Stack(
                            children: [
                              Image.asset(
                                "image/p1.png",
                                height: height / 30,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: width / 20,
                                  ),
                                  Stack(
                                    children: [
                                      Image.asset(
                                        "image/p2.png",
                                        height: height / 30,
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: width / 20,
                                          ),
                                          Stack(
                                            children: [
                                              Image.asset(
                                                "image/p3.png",
                                                height: height / 30,
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
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height / 50,
                          ),
                          Row(
                            children: [
                              Image.asset(
                                "image/location.png",
                                height: height / 40,
                              ),
                              Text(
                                " 36 Guild Street London , UK",
                                style: TextStyle(
                                  fontFamily: 'Gilroy Medium',
                                  color: Colors.grey,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: height / 6,
                          ),
                          Row(
                            children: [
                              const Spacer(),
                              Container(
                                decoration: BoxDecoration(
                                  color: notifire.getprimerycolor,
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(20)),
                                ),
                                height: height / 30,
                                width: width / 6,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "10 ",
                                      style: TextStyle(
                                          color: const Color(0xffF0635A),
                                          fontSize: 15.sp,
                                          fontFamily: 'Gilroy ExtraBold',
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "JUNE",
                                      style: TextStyle(
                                        color: const Color(0xffF0635A),
                                        fontSize: 10.sp,
                                        fontFamily: 'Gilroy Medium',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: width / 40,
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
        ),
      ],
    );
  }

  Widget games(img, name) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                child: const All(),
              ),
            );
          },
          child: Container(
            color: Colors.transparent,
            height: height / 5.9,
            width: width / 3.4,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: notifire.getprimerycolor,
              child: Column(
                children: [
                  SizedBox(
                    height: height / 100,
                  ),
                  Image.asset(
                    img,
                    height: height / 10,
                  ),
                  SizedBox(
                    height: height / 100,
                  ),
                  Container(
                    height: height / 40,
                    width: width / 6,
                    decoration: BoxDecoration(
                      color: notifire.gettopcolor,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        name,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: height / 70,
                          fontFamily: 'Gilroy Normal',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height / 100,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Side extends StatefulWidget {
  const Side({Key? key}) : super(key: key);

  @override
  _SideState createState() => _SideState();
}

class _SideState extends State<Side> {
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
    return Scaffold(
      backgroundColor: notifire.getbuttoncolor,
      body: SingleChildScrollView(
        child: ScreenUtilInit(
          builder: (BuildContext context, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height / 15),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "image/p1.png",
                      height: height / 10,
                    ),
                    SizedBox(height: height / 50),
                    Text(
                      "Ashfak Sayem",
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontFamily: 'Gilroy Medium',
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height / 30),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            child: const Profile(),
                          ),
                        );
                      },
                      child: lists("image/myprofile.png", "My Profile"),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            child: const Message(),
                          ),
                        );
                      },
                      child: lists("image/msg.png", "Message"),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            child: const Upcoming(),
                          ),
                        );
                      },
                      child: lists("image/calender.png", "My Booking"),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            child: const Bookmark(),
                          ),
                        );
                      },
                      child: lists("image/bookmark.png", "Bookmark"),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            child: const Contact(),
                          ),
                        );
                      },
                      child: lists("image/contact.png", "Contact Us"),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            child: const Setting(),
                          ),
                        );
                      },
                      child: lists("image/settings.png", "Settings"),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            child: const Faq(),
                          ),
                        );
                      },
                      child: lists("image/helps.png", "Helps & FAQs"),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            child: const Login(),
                          ),
                        );
                      },
                      child: lists("image/signout.png", "Sign Out"),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height / 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: const Membership(),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: notifire.getprocolor,
                    ),
                    height: height / 16,
                    width: width / 2.4,
                    child: Row(
                      children: [
                        SizedBox(
                          width: width / 20,
                        ),
                        Image.asset(
                          "image/pro.png",
                          height: height / 35,
                        ),
                        SizedBox(
                          width: width / 40,
                        ),
                        Text(
                          "Upgrade Pro",
                          style: TextStyle(
                            color: const Color(0xff00f8ff),
                            fontSize: 15.sp,
                            fontFamily: 'Gilroy Medium',
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget lists(img, txt) {
    return ListTile(
      title: Row(
        children: [
          Image.asset(
            img,
            height: height / 30,
          ),
          SizedBox(
            width: width / 50,
          ),
          Text(
            txt,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.sp,
              fontFamily: 'Gilroy Medium',
            ),
          ),
        ],
      ),
    );
  }
}
