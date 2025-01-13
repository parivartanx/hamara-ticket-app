import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:goevent2/extensions/media_query_ext.dart';
import 'package:goevent2/providers/color_provider.dart';
import 'package:goevent2/utils/media.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'onbonding.dart';

class Splashscreen extends ConsumerStatefulWidget {
  static const routePath = '/splashscreen';
  static const routeName = 'splashscreen';
  const Splashscreen({Key? key}) : super(key: key);

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends ConsumerState<Splashscreen> {
  @override
  void initState() {
    super.initState();
    getdarkmodepreviousstate();
    // Timer(
    //   const Duration(seconds: 4),
    //   () => context.pushNamed(
    //       Onbonding.routeName,),
    // );
  }



  void getdarkmodepreviousstate() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previusstate = prefs.getBool("setIsDark");
    if (previusstate == null) {
      ref.read(colorProvider.notifier).setDarkMode(false);
    } else {
     ref.read(colorProvider.notifier).setDarkMode(previusstate);
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Splashscreen");
    final notifire = ref.watch(colorProvider);
 
    return ScreenUtilInit(
      designSize: const Size(1080, 2160),
      builder: (BuildContext context, child) => Scaffold(
        backgroundColor: notifire.primaryColor,
        body: Center(
          child: Container(
            color: notifire.primaryColor,
            child: Column(
              children: [
                SizedBox(
                  height: context.screenHeight / 2.5,
                ),
                Container(
                  color: Colors.transparent,
                  height: context.screenHeight / 7,
                  child: Image.asset("assets/image/getevent.png"),
                ),
                SizedBox(
                  height: context.screenHeight / 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Go",
                      style: TextStyle(
                        fontSize: 100.sp,
                        fontFamily: 'Gilroy ExtraBold',
                        color: notifire.textColor,
                      ),
                    ),
                    Text(
                      "Event",
                      style: TextStyle(
                        fontSize: 100.sp,
                        fontFamily: 'Gilroy ExtraBold',
                        color: notifire.text1Color,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
