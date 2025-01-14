import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/extensions/media_query_ext.dart';
import '/notification/empty.dart';
import '/providers/color_provider.dart';
import 'package:page_transition/page_transition.dart';
import '../utils/string.dart';

class Note extends ConsumerStatefulWidget {
  const Note({Key? key}) : super(key: key);

  @override
  _NoteState createState() => _NoteState();
}

class _NoteState extends ConsumerState<Note> {

  

  @override
  void initState() {
    super.initState();
    ref.read(colorProvider.notifier).getdarkmodepreviousstate();
  }

  @override
  Widget build(BuildContext context) {
    final notifire = ref.watch(colorProvider);
    final height = context.height;
    final width = context.width;
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
                    CustomStrings.notification,
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
              SizedBox(height: height / 40),
              notifications( "David Silbia"," Invite Jo Malone","Just Now","London's Mother's","assets/image/p1.png",SizedBox(
                width: width / 18,
              ),notifire),
              SizedBox(height: height / 100),
              not( "Adan Safi"," Started","5 min ago","International Kids Safe","assets/image/p2.png",SizedBox(
                width: width / 4.5,
              ),notifire),SizedBox(height: height / 100),
              notifications( "Joan Baker"," Invite A virtual","20 min ago","Evening of smooth Jazz","assets/image/p3.png",SizedBox(
                width: width / 15,
              ),notifire),SizedBox(height: height / 100),not( "Ronald C.Kinch"," Like You","1 hr ago","events","assets/image/p4.png",SizedBox(
                width: width / 7,
              ),notifire),SizedBox(height: height / 100),not( "Clara Tolson"," Join Your","9 hr ago","Event Gala Music Festival","assets/image/p1.png",SizedBox(
                width: width / 6,
              ),notifire),SizedBox(height: height / 100),
              notifications( "Jennifer Fritz"," Invite You","Tue,5:10 pm","International Kids Safe","assets/image/p2.png",SizedBox(
                width: width / 9,
              ),notifire),SizedBox(height: height / 100),
              not( "Eric G.Prickett"," Started","Wen,3:30 pm","Following you","assets/image/p3.png",SizedBox(
                width: width / 10,
              ),notifire),SizedBox(height: height / 100),
            ],
          ),
        ),
      ),
    );
  }
  Widget notifications(name1,name2,name3,name4,img,wid,ColorState notifire){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: (){
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade,
                  child:  const Empty(),),);
        },
        child: Container(
          height: context.height / 8,
          width: context.width,
          color: Colors.transparent,
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 40.sp),
                child: Image.asset(
                  img,
                  height: context.height / 15,
                ),
              ),
              SizedBox(
                width: context.width / 30,
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
                          color: notifire.darksColor,
                        ),
                      ),
                      Text(
                        name2,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: 'Gilroy Medium',
                          color: notifire.textColor,
                        ),
                      ),
                      wid,
                      Text(
                        name3,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: 'Gilroy Medium',
                          color: notifire.textColor,
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
                          color: notifire.textColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: context.height / 100,
                  ),
                  Row(
                    children: [
                      Container(
                        height: context.height / 22,
                        width: context.width / 4,
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
                        width: context.width / 60,
                      ),
                      Container(
                        height: context.height / 22,
                        width: context.width / 4,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: notifire.buttonsColor),
                          color: notifire.buttonsColor,
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
  Widget not(name1,name2,name3,name4,img,wid,ColorState notifire){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: (){
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child:  const Empty(),),);
        },
        child: Container(
          height: context.height / 12,
          width: context.width,
          color: Colors.transparent,
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 10.sp),
                child: Image.asset(
                  img,
                  height: context.height / 15,
                ),
              ),
              SizedBox(
                width: context.width / 30,
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
                          color: notifire.darksColor,
                        ),
                      ),
                      Text(
                        name2,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: 'Gilroy Medium',
                          color: notifire.textColor,
                        ),
                      ),
                      wid,
                      Text(
                        name3,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: 'Gilroy Medium',
                          color: notifire.textColor,
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
                          color: notifire.textColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: context.height / 100,
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
