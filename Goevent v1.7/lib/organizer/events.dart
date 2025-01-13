import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goevent2/providers/color_provider.dart';

import '../utils/media.dart';

class Event extends ConsumerStatefulWidget {
  const Event({Key? key}) : super(key: key);

  @override
  _EventState createState() => _EventState();
}

class _EventState extends ConsumerState<Event> {

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
              SizedBox(
                height: height / 100,
              ),
              cards("image/n2.png",notifire),
              SizedBox(
                height: height / 100,
              ),
              cards("image/g1.png",notifire),
              SizedBox(
                height: height / 100,
              ),
              cards("image/n1.png",notifire),
              SizedBox(
                height: height / 100,
              ),
              cards("image/g1.png",notifire),
              SizedBox(
                height: height / 100,
              ),
              cards("image/n1.png",notifire),
              SizedBox(
                height: height / 100,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cards(img,ColorState notifire) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: notifire.cardColor,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          color: notifire.cardColor,
        ),
        height: height / 7.5,
        width: width,
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 5, top: 5),
          child: Row(
            children: [
              Container(
                width: width / 5,
                height: height / 8,
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
                  SizedBox(
                    height: height / 200,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: width / 50,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: height / 100,
                          ),
                          Row(
                            children: [
                              Text(
                                "1 ST MAY - SAT -2:00 PM",
                                style: TextStyle(
                                    fontFamily: 'Gilroy Medium',
                                    color: const Color(0xff4A43EC),
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height / 100,
                          ),
                          Text(
                            "Women's leadership \n conference",
                            style: TextStyle(
                                fontFamily: 'Gilroy Medium',
                                color: notifire.darksColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600),
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
    );
  }
}
