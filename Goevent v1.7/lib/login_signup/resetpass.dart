import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goevent2/providers/color_provider.dart';

import '../utils/botton.dart';
import '../utils/ctextfield.dart';
import '../utils/media.dart';

class Resetpassword extends ConsumerStatefulWidget {
  const Resetpassword({Key? key}) : super(key: key);

  @override
  _ResetpasswordState createState() => _ResetpasswordState();
}

class _ResetpasswordState extends ConsumerState<Resetpassword> {


  @override
  void initState() {
    super.initState();
    ref.read(colorProvider.notifier).getdarkmodepreviousstate();
  }

  @override
  Widget build(BuildContext context) {
    final notifire = ref.watch(colorProvider);
    return ScreenUtilInit(
      builder: (BuildContext context, child) =>  Scaffold(
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
                        child: Icon(Icons.arrow_back,
                            color: notifire.whiteColor)),
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
                          "Please enter your email address to",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: 'Gilroy Medium',
                            color: notifire.whiteColor,
                          ),
                        ),
                        SizedBox(height: height / 400,),
                        Text(
                          "request a password reset",
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
              SizedBox(height: height / 30,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Customtextfild.textField("Password",Colors.grey,notifire.whiteColor,
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
                    notifire.buttonsColor,
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
