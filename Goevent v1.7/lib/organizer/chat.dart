import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goevent2/providers/color_provider.dart';
import '../utils/media.dart';

class Chat extends ConsumerStatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends ConsumerState<Chat> {



  @override
  void initState() {
    super.initState();
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
                    child:
                        Icon(Icons.arrow_back, color: notifire.darksColor),
                  ),
                  SizedBox(
                    width: width / 80,
                  ),
                  Text(
                    "Zenifero Bolex",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Gilroy Medium',
                      color: notifire.darksColor,
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.more_vert),
                  SizedBox(
                    width: width / 20,
                  ),
                ],
              ),
              SizedBox(
                height: height / 50,
              ),
              Text(
                "Today",
                style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: 'Gilroy Medium',
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: height / 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "12:30 am",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: 'Gilroy Medium',
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height / 100,
                    ),
                    Container(
                      height: height / 10,
                      width: width / 1.5,
                      decoration: BoxDecoration(
                          color: notifire.pinkColor,
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15))),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.sp),
                        child: Center(
                            child: Text(
                                "Hi, Thanks for your message. The answer is yes!",
                              style: TextStyle(
                              fontSize: 15.sp,
                              fontFamily: 'Gilroy Medium',
                              color: notifire.textColor,
                            ),),),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "12:31 am",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: 'Gilroy Medium',
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height / 100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: height / 15,
                          width: width / 1.5,
                          decoration: BoxDecoration(
                              color: notifire.topColor,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15))),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.sp),
                            child: Center(
                              child: Text(
                                "Awesome, You are ready now?",
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontFamily: 'Gilroy Medium',
                                  color: Colors.white,
                                ),),),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "12:45 am",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: 'Gilroy Medium',
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height / 100,
                    ),
                    Container(
                      height: height / 8,
                      width: width / 1.5,
                      decoration: BoxDecoration(
                          color: notifire.pinkColor,
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15))),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.sp),
                        child: Center(
                          child: Text(
                            "Yeah I am ready to start! Please send me the required files and also please invite me on the campaign.",
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontFamily: 'Gilroy Medium',
                              color: notifire.textColor,
                            ),),),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "1:31 am",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: 'Gilroy Medium',
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height / 100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: height / 15,
                          width: width / 1.5,
                          decoration: BoxDecoration(
                              color: notifire.topColor,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15))),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.sp),
                            child: Center(
                              child: Text(
                                "Okay, I will do it tonight!",
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontFamily: 'Gilroy Medium',
                                  color: Colors.white,
                                ),),),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height / 100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Seen",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: 'Gilroy Medium',
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: height / 3.9,),
              Container(
                height: height / 10,
                width: width,
                color: notifire.pinkColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        height: height / 20,
                        width: width / 1.8,
                        child: Padding(
                          padding: EdgeInsets.only(left: width / 40),
                          child: TextField(
                            style: TextStyle(color: notifire.textColor),
                            decoration: const InputDecoration(
                                hintStyle: TextStyle(color: Colors.grey),
                                hintText: "Write a reply...",
                                border: InputBorder.none),
                          ),
                        ),
                      ),
                      SizedBox(width: width / 20,),
                      Image.asset("image/smile.png",height: height / 30,),
                      SizedBox(width: width / 30,),
                      Image.asset("image/gallary.png",height: height / 30,),
                      SizedBox(width: width / 30,),
                      Image.asset("image/clip.png",height: height / 30,),
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
}
