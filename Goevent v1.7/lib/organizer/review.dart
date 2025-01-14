import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/extensions/media_query_ext.dart';
import '/providers/color_provider.dart';

import '../utils/string.dart';

class Review extends ConsumerStatefulWidget {
  const Review({Key? key}) : super(key: key);

  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends ConsumerState<Review> {


  @override
  void initState() {
    super.initState();
    ref.read(colorProvider.notifier).getdarkmodepreviousstate();
  }

  @override
  Widget build(BuildContext context) {
    final notifire = ref.watch(colorProvider);
    final height = context.height;
    return ScreenUtilInit(
      builder: (BuildContext context, child) =>  Scaffold(
        backgroundColor: notifire.primaryColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height / 70,
              ),
              revies(CustomStrings.rocks, "assets/image/p2.png",notifire),
              SizedBox(
                height: height / 100,
              ),
              revies(CustomStrings.angelina, "assets/image/p3.png",notifire),
              SizedBox(
                height: height / 100,
              ),
              revies(CustomStrings.zenifero, "assets/image/p4.png",notifire),
              SizedBox(
                height: height / 100,
              ),
              revies(CustomStrings.rocks, "assets/image/p1.png",notifire),
              SizedBox(
                height: height / 100,
              ),
              revies(CustomStrings.angelina, "assets/image/p2.png",notifire),
              SizedBox(
                height: height / 100,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget revies(name, img,ColorState notifire) {
    return Container(
      height: context.height / 5.5,
      color: Colors.transparent,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: context.height / 13),
            child: Image.asset(
              img,
              height: context.height / 20,
            ),
          ),
          SizedBox(width: context.width / 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: context.height / 100),
              Text(
                name,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontFamily: 'Gilroy Bold',
                  color: notifire.darksColor,
                ),
              ),
              const Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Color(0xffFBBE47),
                  ),
                  Icon(
                    Icons.star,
                    color: Color(0xffFBBE47),
                  ),
                  Icon(
                    Icons.star,
                    color: Color(0xffFBBE47),
                  ),
                  Icon(
                    Icons.star,
                    color: Color(0xffFBBE47),
                  ),
                ],
              ),
              SizedBox(height: context.height / 100),
              Text(
                CustomStrings.review,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: 'Gilroy Normal',
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(bottom: context.height / 11),
            child: Text(
              CustomStrings.feb,
              style: TextStyle(
                fontSize: 13.sp,
                fontFamily: 'Gilroy Normal',
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
