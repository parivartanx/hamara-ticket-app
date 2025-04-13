// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import '/extensions/media_query_ext.dart';
import '/features/home/presentation/widgets/home_body.dart';
import '/features/home/presentation/widgets/side_menu.dart';
import '/providers/color_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final ZoomDrawerController z = ZoomDrawerController();

class Home extends ConsumerStatefulWidget {
  static const routePath = '/';
  static const routeName = 'home';
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  void initState() {
    super.initState();
    _initDarkMode();
  }

  Future<void> _initDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    final previousState = prefs.getBool("setIsDark");
    ref.read(colorProvider.notifier).setDarkMode(previousState ?? false);
  }

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: z,
      borderRadius: 24,
      style: DrawerStyle.style1,
      openCurve: Curves.bounceInOut,
      disableDragGesture: true,
      mainScreenTapClose: true,
      menuScreenTapClose: true,
      slideWidth: context.width * 0.70,
      duration: const Duration(milliseconds: 500),
      showShadow: true,
      angle: 0.0,
      clipMainScreen: true,
      mainScreen: const HomeBody(),
      menuScreen: Theme(
        data: ThemeData.dark(),
        child: const Scaffold(
          body: Side(),
        ),
      ),
    );
  }
}


// class Side extends ConsumerStatefulWidget {
//   const Side({Key? key}) : super(key: key);

//   @override
//   _SideState createState() => _SideState();
// }

// class _SideState extends ConsumerState<Side> {
//   // late ColorNotifire notifire;

//   // getdarkmodepreviousstate() async {
//   //   final prefs = await SharedPreferences.getInstance();
//   //   bool? previusstate = prefs.getBool("setIsDark");
//   //   if (previusstate == null) {
//   //     ref.read(colorProvider.notifier).setDarkMode(false);
//   //   } else {
//   //    ref.read(colorProvider.notifier).setDarkMode(previusstate);
//   //   }
//   // }

//   @override
//   void initState() {
//     super.initState();
//     ref.read(colorProvider.notifier).getdarkmodepreviousstate();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final width = context.width;
//     final buttonColor = ref.watch(colorProvider).buttonColor;
//     final proColor = ref.watch(colorProvider).proColor;
    
//     return Scaffold(
//       backgroundColor:buttonColor,
//       body: SingleChildScrollView(
//         child: ScreenUtilInit(
//           designSize: Size(context.width, context.height),
//           builder: (BuildContext context, child) => Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: context.height / 15),
//               Padding(
//                 padding: const EdgeInsets.only(left: 20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Image.asset(
//                       "assets/image/p1.png",
//                       height: context.height*.1,
//                     ),
//                     SizedBox(height: context.height*.02),
//                     Text(
//                       "Ashfak Sayem",
//                       style: TextStyle(
//                         fontSize: 15.sp,
//                         fontFamily: 'Gilroy Medium',
//                         color: Colors.white,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: context.height / 30),
//               Padding(
//                 padding: const EdgeInsets.only(left: 25),
//                 child: Column(
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           PageTransition(
//                             type: PageTransitionType.fade,
//                             child: const Profile(),
//                           ),
//                         );
//                       },
//                       child: lists("assets/image/myprofile.png", "My Profile"),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           PageTransition(
//                             type: PageTransitionType.fade,
//                             child: const Message(),
//                           ),
//                         );
//                       },
//                       child: lists("assets/image/msg.png", "Message"),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           PageTransition(
//                             type: PageTransitionType.fade,
//                             child: const Upcoming(),
//                           ),
//                         );
//                       },
//                       child: lists("assets/image/calender.png", "My Booking"),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           PageTransition(
//                             type: PageTransitionType.fade,
//                             child: const Bookmark(),
//                           ),
//                         );
//                       },
//                       child: lists("assets/image/bookmark.png", "Bookmark"),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           PageTransition(
//                             type: PageTransitionType.fade,
//                             child: const Contact(),
//                           ),
//                         );
//                       },
//                       child: lists("assets/image/contact.png", "Contact Us"),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           PageTransition(
//                             type: PageTransitionType.fade,
//                             child: const Setting(),
//                           ),
//                         );
//                       },
//                       child: lists("assets/image/settings.png", "Settings"),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           PageTransition(
//                             type: PageTransitionType.fade,
//                             child: const Faq(),
//                           ),
//                         );
//                       },
//                       child: lists("assets/image/helps.png", "Helps & FAQs"),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           PageTransition(
//                             type: PageTransitionType.fade,
//                             child: const PrivacyPolicy(),
//                           ),
//                         );
//                       },
//                       child: lists("assets/image/privacy-policy.png", "Privacy Policy"),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           PageTransition(
//                             type: PageTransitionType.fade,
//                             child: const Login(),
//                           ),
//                         );
//                       },
//                       child: lists("assets/image/signout.png", "Sign Out"),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: context.height / 20,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 25),
//                 child: GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       PageTransition(
//                         type: PageTransitionType.fade,
//                         child: const Membership(),
//                       ),
//                     );
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: const BorderRadius.all(
//                         Radius.circular(10),
//                       ),
//                       color: proColor,
//                     ),
//                     height: context.height / 16,
//                     width: width / 2.4,
//                     child: Row(
//                       children: [
//                         SizedBox(
//                           width: width / 20,
//                         ),
//                         Image.asset(
//                           "assets/image/pro.png",
//                           height: context.height / 35,
//                         ),
//                         SizedBox(
//                           width: width / 40,
//                         ),
//                         Text(
//                           "Upgrade Pro",
//                           style: TextStyle(
//                             color: const Color(0xff00f8ff),
//                             fontSize: 15.sp,
//                             fontFamily: 'Gilroy Medium',
//                             fontWeight: FontWeight.w600,
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget lists(img, txt) {
//     return ListTile(
//       title: Row(
//         children: [
//           Image.asset(
//             img,
//             height: context.height / 30,
//           ),
//           SizedBox(
//             width: context.width*.04,
//           ),
//           Text(
//             txt,
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 15.sp,
//               fontFamily: 'Gilroy Medium',
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
