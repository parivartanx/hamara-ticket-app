// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import '/booking/upcoming.dart';
import '/extensions/media_query_ext.dart';
import '/home/bookmark.dart';
import '/home/contact.dart';
import '/home/event.dart';
import '/home/faq.dart';
import '/home/seeall.dart';
import '/home/settings.dart';
import '/home/upgrade.dart';
import '/login_signup/login.dart';
import '/organizer/message.dart';
import '/profile/profile.dart';
import '/providers/color_provider.dart';
import '/utils/string.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../notification/notification.dart';

final ZoomDrawerController z = ZoomDrawerController();

class Home extends ConsumerStatefulWidget {
  static const routePath = '/';
  static const routeName = 'home';
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {

  bool selected = false;

  getdarkmodepreviousstate() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previusstate = prefs.getBool("setIsDark");
    if (previusstate == null) {
      ref.read(colorProvider.notifier).setDarkMode(false);
    } else {
      ref.read(colorProvider.notifier).setDarkMode(previusstate);
    }
  }

  @override
  void initState() {
    super.initState();
    getdarkmodepreviousstate();
  }

  @override
  Widget build(BuildContext context) {
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

class Body extends ConsumerStatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  ConsumerState<Body> createState() => _BodyState();
}

class _BodyState extends ConsumerState<Body> with SingleTickerProviderStateMixin {
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


 

  @override
  void initState() {
    super.initState();
    ref.read(colorProvider.notifier).getdarkmodepreviousstate();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = ref.watch(colorProvider).primaryColor;
    return Scaffold(
      backgroundColor: primaryColor,
      body: TwoPanels(
        controller: controller,
      ),
    );
  }
}

class TwoPanels extends ConsumerStatefulWidget {
  final AnimationController controller;

  const TwoPanels({Key? key, required this.controller}) : super(key: key);

  @override
  _TwoPanelsState createState() => _TwoPanelsState();
}

class _TwoPanelsState extends ConsumerState<TwoPanels> with TickerProviderStateMixin {
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

  //  getdarkmodepreviousstate() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   bool? previusstate = prefs.getBool("setIsDark");
  //   if (previusstate == null) {
  //     ref.read(colorProvider.notifier).setDarkMode(false);
  //   } else {
  //    ref.read(colorProvider.notifier).setDarkMode(previusstate);
  //   }
  // }

  @override
  void initState() {
    super.initState();
    ref.read(colorProvider.notifier).getdarkmodepreviousstate();
  }

  @override
  Widget build(BuildContext context) {
    final width = context.width;

    final primaryColor = ref.watch(colorProvider).primaryColor;
    final topColor = ref.watch(colorProvider).topColor;
    final textColor = ref.watch(colorProvider).textColor;
    final notifire = ref.watch(colorProvider);
    return Scaffold(
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: topColor,
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    ),
                  ),
                  height: context.height / 4.2,
                  child: Column(
                    children: [
                      SizedBox(height: context.height / 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                z.toggle!();
                              },
                              child: Container(
                                height: context.height / 25,
                                color: Colors.transparent,
                                child: Padding(
                                  padding: const EdgeInsets.all(7),
                                  child: Image.asset(
                                    "assets/image/draw.png",
                                    height: context.height / 50,
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
                                  "New York, USA",
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
                                "assets/image/bell.png",
                                height: context.height / 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: context.height / 50),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/image/search.png",
                              height: context.height / 30,
                            ),
                            SizedBox(width: width / 90),
                            Container(
                              width: 1,
                              height: context.height / 40,
                              color: Colors.grey,
                            ),
                            SizedBox(width: width / 90),
                            Container(
                              color: Colors.transparent,
                              height: context.height / 20,
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
                    SizedBox(height: context.height / 4.9),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            games("assets/image/music1.png", CustomStrings.musics,notifire),
                            games("assets/image/paint1.png", CustomStrings.art,notifire),
                            games("assets/image/sport1.png", CustomStrings.sport,notifire),
                            games("assets/image/party1.png", CustomStrings.party,notifire),
                            games("assets/image/paint1.png", CustomStrings.food,notifire),
                            games("assets/image/other1.png", CustomStrings.others,notifire),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: context.height*.02),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Text(
                    CustomStrings.upcoming,
                    style: TextStyle(
                        fontFamily: 'Gilroy Medium',
                        color: textColor,
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
            SizedBox(height: context.height / 60),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  events(
                      GestureDetector(
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.7),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            height: context.height / 25,
                            width: width / 12,
                            child: Padding(
                                padding: const EdgeInsets.all(7),
                                child: selected
                                    ? Image.asset("assets/image/book1.png")
                                    : Image.asset(
                                        "assets/image/book2.png",
                                        color: const Color(0xffF0635A),
                                      ))),
                      ),
                      "assets/image/g1.png",notifire,context.width),
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
                              color: Colors.white.withAlpha(100),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(5)),
                            ),
                            height: context.height / 25,
                            width: width / 12,
                            child: Padding(
                                padding: const EdgeInsets.all(7),
                                child: selected1
                                    ? Image.asset("assets/image/book1.png")
                                    : Image.asset(
                                        "assets/image/book2.png",
                                        color: const Color(0xffF0635A),
                                      ))),
                      ),
                      "assets/image/g2.png",notifire,context.width),
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
                            height: context.height / 25,
                            width: width / 12,
                            child: Padding(
                                padding: const EdgeInsets.all(7),
                                child: selected2
                                    ? Image.asset("assets/image/book1.png")
                                    : Image.asset(
                                        "assets/image/book2.png",
                                        color: const Color(0xffF0635A),
                                      ))),
                      ),
                      "assets/image/g3.png",notifire,context.width),
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
                            height: context.height / 25,
                            width: width / 12,
                            child: Padding(
                                padding: const EdgeInsets.all(7),
                                child: selected3
                                    ? Image.asset("assets/image/book1.png")
                                    : Image.asset(
                                        "assets/image/book2.png",
                                        color: const Color(0xffF0635A),
                                      ))),
                      ),
                      "assets/image/g4.png",notifire,context.width),
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
                              color: Colors.white.withAlpha(7),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(5)),
                            ),
                            height: context.height / 25,
                            width: width / 12,
                            child: Padding(
                                padding: const EdgeInsets.all(7),
                                child: selected4
                                    ? Image.asset("assets/image/book1.png")
                                    : Image.asset(
                                        "assets/image/book2.png",
                                        color: const Color(0xffF0635A),
                                      ))),
                      ),
                      "assets/image/g1.png",notifire,context.width),
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
                              color: Colors.white.withAlpha(7),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(5)),
                            ),
                            height: context.height / 25,
                            width: width / 12,
                            child: Padding(
                                padding: const EdgeInsets.all(7),
                                child: selected5
                                    ? Image.asset("assets/image/book1.png")
                                    : Image.asset(
                                        "assets/image/book2.png",
                                        color: const Color(0xffF0635A),
                                      ))),
                      ),
                      "assets/image/g2.png",notifire,context.width),
                  const SizedBox(width: 10),
                ],
              ),
            ),
            SizedBox(height: context.height / 60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Container(
                decoration: BoxDecoration(
                  color: notifire.orangeColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                height: context.height / 6,
                child: Row(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: context.height / 40,
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
                                      color: notifire.darksColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: context.height / 90,
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
                                  height: context.height / 90,
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
                                                      notifire.cardColor,
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
                                                height: context.height / 1.08,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        SizedBox(
                                                          height:
                                                              context.height / 80,
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
                                                              context.height / 80,
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
                                                                    .darksColor),
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
                                                                  "assets/image/search2.png",
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
                                                              context.height / 80,
                                                        ),
                                                        rights(
                                                          SizedBox(
                                                            width:
                                                                width / 2.5,
                                                          ),
                                                          "Angelina Zolly",
                                                          "2k Followers",
                                                          "assets/image/p1.png",
                                                          notifire
                                                              .textColor,
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
                                                                      height: context.height /
                                                                          37,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        shape:
                                                                            BoxShape.circle,
                                                                        color: isChecked
                                                                            ? notifire.buttonsColor
                                                                            : notifire.pinkColor,
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
                                                              context.height / 70,
                                                        ),
                                                        rights(
                                                          SizedBox(
                                                            width:
                                                                width / 2.5,
                                                          ),
                                                          "Micheal Ulasi",
                                                          "56 Follwers",
                                                          "assets/image/p2.png",
                                                          notifire
                                                              .textColor,
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
                                                                      height: context.height /
                                                                          37,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        shape:
                                                                            BoxShape.circle,
                                                                        color: isChecked1
                                                                            ? notifire.buttonsColor
                                                                            : notifire.pinkColor,
                                                                      ),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets.all(5.0),
                                                                          child: Image.asset("assets/image/right.png"),
                                                                        ),
                                                                      )),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              context.height / 70,
                                                        ),
                                                        rights(
                                                          SizedBox(
                                                            width:
                                                                width / 2.5,
                                                          ),
                                                          "Angelina Zolly",
                                                          "2k Followers",
                                                          "assets/image/p3.png",
                                                          notifire
                                                              .textColor,
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
                                                                      height: context.height /
                                                                          37,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        shape:
                                                                            BoxShape.circle,
                                                                        color: isChecked2
                                                                            ? notifire.buttonsColor
                                                                            : notifire.pinkColor,
                                                                      ),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets.all(5.0),
                                                                          child: Image.asset("assets/image/right.png"),
                                                                        ),
                                                                      )),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              context.height / 70,
                                                        ),
                                                        rights(
                                                          SizedBox(
                                                            width:
                                                                width / 2.2,
                                                          ),
                                                          "Cristofer",
                                                          "300 Follwers",
                                                          "assets/image/p4.png",
                                                          notifire
                                                              .textColor,
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
                                                                      height: context.height /
                                                                          37,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        shape:
                                                                            BoxShape.circle,
                                                                        color: isChecked3
                                                                            ? notifire.buttonsColor
                                                                            : notifire.pinkColor,
                                                                      ),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets.all(5.0),
                                                                          child: Image.asset("assets/image/right.png"),
                                                                        ),
                                                                      )),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              context.height / 70,
                                                        ),
                                                        rights(
                                                          SizedBox(
                                                            width:
                                                                width / 2.4,
                                                          ),
                                                          "David  Silbia",
                                                          "5k Follwers",
                                                          "assets/image/p1.png",
                                                          notifire
                                                              .textColor,
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
                                                                      height: context.height /
                                                                          37,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        shape:
                                                                            BoxShape.circle,
                                                                        color: isChecked4
                                                                            ? notifire.buttonsColor
                                                                            : notifire.pinkColor,
                                                                      ),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets.all(5.0),
                                                                          child: Image.asset("assets/image/right.png"),
                                                                        ),
                                                                      )),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              context.height / 70,
                                                        ),
                                                        rights(
                                                          SizedBox(
                                                            width:
                                                                width / 2.5,
                                                          ),
                                                          "Ashfak Sayem",
                                                          "402 Follwers",
                                                          "assets/image/p2.png",
                                                          notifire
                                                              .textColor,
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
                                                                      height: context.height /
                                                                          37,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        shape:
                                                                            BoxShape.circle,
                                                                        color: isChecked5
                                                                            ? notifire.buttonsColor
                                                                            : notifire.pinkColor,
                                                                      ),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets.all(5.0),
                                                                          child: Image.asset("assets/image/right.png"),
                                                                        ),
                                                                      )),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              context.height / 70,
                                                        ),
                                                        rights(
                                                          SizedBox(
                                                            width:
                                                                width / 2.9,
                                                          ),
                                                          "Rocks Velkeinjen ",
                                                          "893 Follwers",
                                                          "assets/image/p3.png",
                                                          notifire
                                                              .textColor,
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
                                                                      height: context.height /
                                                                          37,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        shape:
                                                                            BoxShape.circle,
                                                                        color: isChecked6
                                                                            ? notifire.buttonsColor
                                                                            : notifire.pinkColor,
                                                                      ),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets.all(5.0),
                                                                          child: Image.asset("assets/image/right.png"),
                                                                        ),
                                                                      )),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              context.height / 70,
                                                        ),
                                                        rights(
                                                          SizedBox(
                                                            width:
                                                                width / 2.7,
                                                          ),
                                                          "Roman Kutepov",
                                                          "225 Follwers",
                                                          "assets/image/p4.png",
                                                          notifire
                                                              .textColor,
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
                                                                      height: context.height /
                                                                          37,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        shape:
                                                                            BoxShape.circle,
                                                                        color: isChecked7
                                                                            ? notifire.buttonsColor
                                                                            : notifire.pinkColor,
                                                                      ),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets.all(5.0),
                                                                          child: Image.asset("assets/image/right.png"),
                                                                        ),
                                                                      )),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              context.height / 70,
                                                        ),
                                                        rights(
                                                          SizedBox(
                                                            width:
                                                                width / 2.7,
                                                          ),
                                                          "Cristofer Nolan ",
                                                          "322 Follwers",
                                                          "assets/image/p1.png",
                                                          notifire
                                                              .textColor,
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
                                                                      height: context.height /
                                                                          37,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        shape:
                                                                            BoxShape.circle,
                                                                        color: isChecked8
                                                                            ? notifire.buttonsColor
                                                                            : notifire.pinkColor,
                                                                      ),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets.all(5.0),
                                                                          child: Image.asset("assets/image/right.png"),
                                                                        ),
                                                                      )),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              context.height / 70,
                                                        ),
                                                        rights(
                                                          SizedBox(
                                                            width:
                                                                width / 2.3,
                                                          ),
                                                          "Jhon Wick",
                                                          "2k Follwers",
                                                          "assets/image/p2.png",
                                                          notifire
                                                              .textColor,
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
                                                                      height: context.height /
                                                                          37,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        shape:
                                                                            BoxShape.circle,
                                                                        color: isChecked9
                                                                            ? notifire.buttonsColor
                                                                            : notifire.pinkColor,
                                                                      ),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets.all(5.0),
                                                                          child: Image.asset("assets/image/right.png"),
                                                                        ),
                                                                      )),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              context.height / 70,
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
                                    height: context.height / 30,
                                    width: width / 6,
                                    color: notifire.blueColor,
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
                          "assets/image/invite.png",
                          height: context.height / 6,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: context.height / 60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Text(
                    "Nearby You",
                    style: TextStyle(
                        fontFamily: 'Gilroy Medium',
                        color: notifire.textColor,
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
            SizedBox(height: context.height / 60),
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
                    height: context.height / 25,
                    width: context.width*.1,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: selected6
                          ? Image.asset("assets/image/book1.png")
                          : Image.asset(
                              "assets/image/book2.png",
                              color: const Color(0xffF0635A),
                            ),
                    ),
                  ),
                ),
                "assets/image/n1.png",notifire),
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
                    height: context.height / 25,
                    width: context.width / 10,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: selected7
                          ? Image.asset("assets/image/book1.png")
                          : Image.asset(
                              "assets/image/book2.png",
                              color: const Color(0xffF0635A),
                            ),
                    ),
                  ),
                ),
                "assets/image/n2.png",notifire),
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
                      height: context.height / 25,
                      width: context.width / 10,
                      child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: selected8
                              ? Image.asset("assets/image/book1.png")
                              : Image.asset(
                                  "assets/image/book2.png",
                                  color: const Color(0xffF0635A),
                                ))),
                ),
                "assets/image/n3.png",notifire),
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
                    height: context.height / 25,
                    width: context.width / 10,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: selected9
                          ? Image.asset("assets/image/book1.png")
                          : Image.asset(
                              "assets/image/book2.png",
                              color: const Color(0xffF0635A),
                            ),
                    ),
                  ),
                ),
                "assets/image/n4.png",notifire),
      
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
                    height: context.height / 25,
                    width: context.width / 10,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: selected0
                          ? Image.asset("assets/image/book1.png")
                          : Image.asset(
                              "assets/image/book2.png",
                              color: const Color(0xffF0635A),
                            ),
                    ),
                  ),
                ),
                "assets/image/n5.png",notifire),
            SizedBox(
              height: context.height / 60,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    "Event This Month",
                    style: TextStyle(
                        fontFamily: 'Gilroy Medium',
                        color: notifire.textColor,
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
              height: context.height / 60,
            ),
            monthly("assets/image/n1.png", "Halloween Festival",notifire ,context.width),
      
            monthly("assets/image/n2.png", "Women's Festival",notifire,context.width),
      
            monthly("assets/image/n3.png", "Halloween Festival",notifire,context.width),
      
            monthly("assets/image/n4.png", "Women's Festival",notifire , context.width),
      
            monthly("assets/image/n5.png", "Halloween Festival",notifire,context.width),
            SizedBox(
              height: context.height / 60,
            ),
          ],
        ),
      ),
    );
  }

  Widget monthly(img, name,ColorState notifire,double width) {

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
              color: notifire.primaryColor,
              border: Border.all(
                color: const Color(0xffdcdbdb),
                width: 1,
              ),
            ),
            height: context.height / 7,
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
                            height: context.height / 8,
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
                                height: context.height / 200,
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
                                                color: notifire.darksColor,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: context.height / 100,
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            "assets/image/location.png",
                                            height: context.height / 70,
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
                                        height: context.height / 100,
                                      ),
                                      Stack(
                                        children: [
                                          Image.asset(
                                            "assets/image/p1.png",
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
                                                    "assets/image/p2.png",
                                                    height: context.height / 30,
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width: width / 20,
                                                      ),
                                                      Stack(
                                                        children: [
                                                          Image.asset(
                                                            "assets/image/p3.png",
                                                            height: context.height / 30,
                                                          ),
                                                          Row(
                                                            children: [
                                                              SizedBox(
                                                                width:
                                                                    context.width / 20,
                                                              ),
                                                              Stack(
                                                                children: [
                                                                  Image.asset(
                                                                    "assets/image/p4.png",
                                                                    height:
                                                                        context.height /
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
                                height: context.height / 80,
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
                      height: context.height / 80,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: notifire.pinkColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      height: context.height / 13,
                      width: context.width / 8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Feb",
                            style: TextStyle(
                                color: notifire.darksColor,
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

  Widget rights(se, name1, name, img, txtcolor, ce,) {
    return Row(
      // mainAxisAlignment : MainAxisAlignment.center,
      children: [
        Image.asset(
          img,
          height: context.height / 15,
        ),
        SizedBox(
          width: context.width / 20,
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

  Widget conference(se, img,ColorState notifire) {
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
              color: notifire.primaryColor,
              border: Border.all(
                color: const Color(0xffdcdbdb),
                width: 1,
              ),
            ),
            height: context.height*.14,
            width: context.width,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 8, bottom: 5, top: 5),
              child: Row(
                children: [
                  Container(
                    width: context.width / 5,
                    height: context.height / 8,
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
                      Row(
                        children: [
                          SizedBox(width: context.width*.04,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(

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
                                    color: notifire.darksColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: context.height*.01,
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/image/location.png",
                                    height: context.height / 70,
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

  Widget events(se, img,ColorState notifire,width) {
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
                color: notifire.primaryColor,
                border: Border.all(
                  color: const Color(0xffdcdbdb),
                  width: 1,
                ),
              ),

              width: width / 1.5,
              child: Card(
                elevation: 0,
                color: notifire.primaryColor,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: context.height / 5.5,
                            width: context.width / 1.7,
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
                                    )),
                                Column(
                                  children: [
                                    SizedBox(
                                      height: context.height / 70,
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
                            height: context.height / 40,
                          ),
                          Text(
                            "International Band Music...",
                            style: TextStyle(
                                fontFamily: 'Gilroy Medium',
                                color: notifire.darksColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: context.height / 40,
                          ),
                          Stack(
                            children: [
                              Image.asset(
                                "assets/image/p1.png",
                                height: context.height / 30,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: width / 20,
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
                                            width: width / 20,
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
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: context.height / 50,
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
                            height: context.height / 6,
                          ),
                          Row(
                            children: [
                              const Spacer(),
                              Container(
                                decoration: BoxDecoration(
                                  color: notifire.primaryColor,
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(20)),
                                ),
                                // height: context.height / 3,
                                width: context.width / 6,
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

  Widget games(img, name ,ColorState notifire) {
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
            height: context.height / 5.9,
            width: context.width / 3.4,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: notifire.primaryColor,
              child: Column(
                children: [
                  SizedBox(
                    height: context.height*.02,
                  ),
                  Image.asset(
                    img,
                    height: context.height*.07,
                  ),
                  SizedBox(
                    height: context.height*.02,
                  ),
                  Container(
                    height: context.height*.04,
                    width: context.width / 6,
                    decoration: BoxDecoration(
                      color: notifire.topColor,
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
                          fontSize: context.height / 70,
                          fontFamily: 'Gilroy Normal',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: context.height / 100,
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

class Side extends ConsumerStatefulWidget {
  const Side({Key? key}) : super(key: key);

  @override
  _SideState createState() => _SideState();
}

class _SideState extends ConsumerState<Side> {
  // late ColorNotifire notifire;

  // getdarkmodepreviousstate() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   bool? previusstate = prefs.getBool("setIsDark");
  //   if (previusstate == null) {
  //     ref.read(colorProvider.notifier).setDarkMode(false);
  //   } else {
  //    ref.read(colorProvider.notifier).setDarkMode(previusstate);
  //   }
  // }

  @override
  void initState() {
    super.initState();
    ref.read(colorProvider.notifier).getdarkmodepreviousstate();
  }

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    // notifire = Provider.of<ColorNotifire>(context, listen: true);
    final buttonColor = ref.watch(colorProvider).buttonColor;
    final proColor = ref.watch(colorProvider).proColor;
    return Scaffold(
      backgroundColor:buttonColor,
      body: SingleChildScrollView(
        child: ScreenUtilInit(
          designSize: Size(context.width, context.height),
          builder: (BuildContext context, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: context.height / 15),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/image/p1.png",
                      height: context.height*.1,
                    ),
                    SizedBox(height: context.height*.02),
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
              SizedBox(height: context.height / 30),
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
                      child: lists("assets/image/myprofile.png", "My Profile"),
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
                      child: lists("assets/image/msg.png", "Message"),
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
                      child: lists("assets/image/calender.png", "My Booking"),
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
                      child: lists("assets/image/bookmark.png", "Bookmark"),
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
                      child: lists("assets/image/contact.png", "Contact Us"),
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
                      child: lists("assets/image/settings.png", "Settings"),
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
                      child: lists("assets/image/helps.png", "Helps & FAQs"),
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
                      child: lists("assets/image/signout.png", "Sign Out"),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: context.height / 20,
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
                      color: proColor,
                    ),
                    height: context.height / 16,
                    width: width / 2.4,
                    child: Row(
                      children: [
                        SizedBox(
                          width: width / 20,
                        ),
                        Image.asset(
                          "assets/image/pro.png",
                          height: context.height / 35,
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
            height: context.height / 30,
          ),
          SizedBox(
            width: context.width*.04,
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
