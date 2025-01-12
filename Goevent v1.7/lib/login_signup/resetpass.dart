import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/botton.dart';
import '../utils/colornotifire.dart';
import '../utils/ctextfield.dart';
import '../utils/media.dart';

class Resetpassword extends StatefulWidget {
  const Resetpassword({Key? key}) : super(key: key);

  @override
  _ResetpasswordState createState() => _ResetpasswordState();
}

class _ResetpasswordState extends State<Resetpassword> {
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
      builder: (BuildContext context, child) =>  Scaffold(
        backgroundColor: notifire.getprimerycolor,
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
                        color: notifire.getprimerycolor,
                        child: Icon(Icons.arrow_back,
                            color: notifire.getwhitecolor)),
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
                      "Reset Password",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy Medium',
                        color: notifire.getwhitecolor,
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
                          "Please enter your email address to",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: 'Gilroy Medium',
                            color: notifire.getwhitecolor,
                          ),
                        ),
                        SizedBox(height: height / 400,),
                        Text(
                          "request a password reset",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: 'Gilroy Medium',
                            color: notifire.getwhitecolor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: height / 30,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Customtextfild.textField("Password",Colors.grey,notifire.getwhitecolor,
                    "image/Lock.png",),
              ),
              SizedBox(height: height / 20,),
              GestureDetector(
                  onTap: () {
                   Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20,0,20,0),
                  child: Custombutton.button(
                    notifire.getbuttonscolor,
                    "SEND",
                    SizedBox(
                      width: width / 3,
                    ),SizedBox(
                    width: width / 20,
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
}
