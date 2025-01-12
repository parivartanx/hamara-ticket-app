import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/colornotifire.dart';
import '../utils/media.dart';
import '../utils/string.dart';

class Documents extends StatefulWidget {
  const Documents({Key? key}) : super(key: key);

  @override
  _DocumentsState createState() => _DocumentsState();
}

class _DocumentsState extends State<Documents> {
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
                    child:
                    Icon(Icons.arrow_back, color: notifire.getdarkscolor),
                  ),
                  SizedBox(
                    width: width / 80,
                  ),
                  Text(
                    "Document Management",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Gilroy Medium',
                      color: notifire.getdarkscolor,
                    ),
                  ),
                  const Spacer(),
                  Icon(Icons.more_vert,color: notifire.getdarkscolor,),
                  SizedBox(
                    width: width / 20,
                  ),
                ],
              ),
              SizedBox(
                height: height / 25,
              ),
              Text(CustomStrings.working,  style: TextStyle(
                color: notifire.getdarkscolor,
                fontSize: 15.sp,
                fontFamily: 'Gilroy Bold',
              ),),
              SizedBox(
                height: height / 60,
              ),
              Text(CustomStrings.ever,  style: TextStyle(
                color: notifire.getdarkscolor,
                fontSize: 12.sp,
                fontFamily: 'Gilroy Normal',
              ),),
              SizedBox(
                height: height / 100,
              ),
              Text(CustomStrings.ever,  style: TextStyle(
                color: notifire.getdarkscolor,
                fontSize: 12.sp,
                fontFamily: 'Gilroy Normal',
              ),),
              SizedBox(
                height: height / 100,
              ),
              Text(CustomStrings.ever,  style: TextStyle(
                color: notifire.getdarkscolor,
                fontSize: 12.sp,
                fontFamily: 'Gilroy Normal',
              ),),
            ],
          ),
        ),
      ),
    );
  }
}
