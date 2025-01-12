import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goevent2/notification/empty.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/colornotifire.dart';
import '../utils/media.dart';
import '../utils/string.dart';

class Note extends StatefulWidget {
  const Note({Key? key}) : super(key: key);

  @override
  _NoteState createState() => _NoteState();
}

class _NoteState extends State<Note> {
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
                    CustomStrings.notification,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Gilroy Medium',
                      color: notifire.getdarkscolor,
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.more_vert),
                  SizedBox(
                    width: width / 20,
                  ),
                ],
              ),
              SizedBox(height: height / 40),
              notifications( "David Silbia"," Invite Jo Malone","Just Now","London's Mother's","image/p1.png",SizedBox(
                width: width / 18,
              ),),
              SizedBox(height: height / 100),
              not( "Adan Safi"," Started","5 min ago","International Kids Safe","image/p2.png",SizedBox(
                width: width / 4.5,
              ),),SizedBox(height: height / 100),
              notifications( "Joan Baker"," Invite A virtual","20 min ago","Evening of smooth Jazz","image/p3.png",SizedBox(
                width: width / 15,
              ),),SizedBox(height: height / 100),not( "Ronald C.Kinch"," Like You","1 hr ago","events","image/p4.png",SizedBox(
                width: width / 7,
              ),),SizedBox(height: height / 100),not( "Clara Tolson"," Join Your","9 hr ago","Event Gala Music Festival","image/p1.png",SizedBox(
                width: width / 6,
              ),),SizedBox(height: height / 100),
              notifications( "Jennifer Fritz"," Invite You","Tue,5:10 pm","International Kids Safe","image/p2.png",SizedBox(
                width: width / 9,
              ),),SizedBox(height: height / 100),
              not( "Eric G.Prickett"," Started","Wen,3:30 pm","Following you","image/p3.png",SizedBox(
                width: width / 10,
              ),),SizedBox(height: height / 100),
            ],
          ),
        ),
      ),
    );
  }
  Widget notifications(name1,name2,name3,name4,img,wid){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: (){
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade,
                  child:  const Empty(),),);
        },
        child: Container(
          height: height / 8,
          width: width,
          color: Colors.transparent,
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 40.sp),
                child: Image.asset(
                  img,
                  height: height / 15,
                ),
              ),
              SizedBox(
                width: width / 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                       name1,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Gilroy Medium',
                          color: notifire.getdarkscolor,
                        ),
                      ),
                      Text(
                        name2,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: 'Gilroy Medium',
                          color: notifire.gettextcolor,
                        ),
                      ),
                      wid,
                      Text(
                        name3,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: 'Gilroy Medium',
                          color: notifire.gettextcolor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        name4,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: 'Gilroy Medium',
                          color: notifire.gettextcolor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height / 100,
                  ),
                  Row(
                    children: [
                      Container(
                        height: height / 22,
                        width: width / 4,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          color: Colors.transparent,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            "Reject",
                            style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Gilroy Medium',
                                fontSize: 15),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width / 60,
                      ),
                      Container(
                        height: height / 22,
                        width: width / 4,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: notifire.getbuttonscolor),
                          color: notifire.getbuttonscolor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            "Accept",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Gilroy Medium',
                                fontSize: 15),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget not(name1,name2,name3,name4,img,wid){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: (){
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child:  const Empty(),),);
        },
        child: Container(
          height: height / 12,
          width: width,
          color: Colors.transparent,
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 10.sp),
                child: Image.asset(
                  img,
                  height: height / 15,
                ),
              ),
              SizedBox(
                width: width / 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        name1,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Gilroy Medium',
                          color: notifire.getdarkscolor,
                        ),
                      ),
                      Text(
                        name2,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: 'Gilroy Medium',
                          color: notifire.gettextcolor,
                        ),
                      ),
                      wid,
                      Text(
                        name3,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: 'Gilroy Medium',
                          color: notifire.gettextcolor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        name4,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: 'Gilroy Medium',
                          color: notifire.gettextcolor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height / 100,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
