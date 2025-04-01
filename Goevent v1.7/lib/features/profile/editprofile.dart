import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/extensions/media_query_ext.dart';
import '/providers/color_provider.dart';
import '/utils/string.dart';

import '../../utils/botton.dart';
import '../../utils/wtextfield.dart';

class Edit extends ConsumerStatefulWidget {
  const Edit({Key? key}) : super(key: key);

  @override
  _EditState createState() => _EditState();
}

class _EditState extends ConsumerState<Edit> {

  

  @override
  void initState() {
    super.initState();
    ref.read(colorProvider.notifier).getdarkmodepreviousstate();
  }

  @override
  Widget build(BuildContext context) {
    final notifire = ref.watch(colorProvider);
    final height= context.height;
    final width = context.width;
    return ScreenUtilInit(
      builder:  (BuildContext context, child) =>  Scaffold(
        backgroundColor: notifire.primaryColor,
        floatingActionButton: Padding(
          padding: const EdgeInsets.fromLTRB(30,10,30,20),
          child: SizedBox(
            height: 45.h,
            width: 410.w,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Custombutton.button(
                notifire.buttonsColor,
                "SAVE",
                SizedBox(
                  width: width / 3.0,
                ),
                SizedBox(
                  width: width / 20,
                ),
              ),
            ),
          ),
        ),floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
                    Icon(Icons.arrow_back, color: notifire.darksColor),
                  ),
                  SizedBox(
                    width: width / 80,
                  ),
                  Text(
                    "Edit Profile",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Gilroy Medium',
                      color: notifire.darksColor,
                    ),
                  ),
                  const Spacer(),
                  Icon(Icons.more_vert,color: notifire.darksColor,),
                   SizedBox(width: width / 30 ,),
                ],
              ),
              SizedBox(
                height: height / 25,
              ),
              Stack(
                children: [
                  Center(
                    child: Image.asset(
                      "assets/image/p2.png",
                      height: height / 9,
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(height: height / 14,),
                      Padding(
                        padding:  EdgeInsets.only(left: width / 1.8),
                        child: Container(
                          height: height / 24,
                          decoration: BoxDecoration(
                            color: notifire.buttonsColor,
                            shape: BoxShape.circle
                          ),
                          child: Padding(
                            padding:  const EdgeInsets.all(8),
                            child: Image.asset("assets/image/camera.png"),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: height / 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    SizedBox(
                      height: height / 60,
                    ),
                    Customtextfild3.textField(notifire.whiteColor, "Name", width ,TextInputType.name,50,TextAlign.start),
                    SizedBox(
                      height: height / 40,
                    ),

                    SizedBox(
                      height: height / 60,
                    ),
                    Customtextfild3.textField(notifire.whiteColor,CustomStrings.birth, width ,TextInputType.name,50,TextAlign.start),
                    SizedBox(
                      height: height / 40,
                    ),

                    SizedBox(
                      height: height / 60,
                    ),
                    Customtextfild3.textField(notifire.whiteColor, CustomStrings.location2, width ,TextInputType.name,50,TextAlign.start),
                    SizedBox(
                      height: height / 40,
                    ),

                    SizedBox(
                      height: height / 60,
                    ),
                    Customtextfild3.textField(notifire.whiteColor,CustomStrings.fname, width ,TextInputType.name,50,TextAlign.start),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
