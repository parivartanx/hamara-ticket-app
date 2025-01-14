import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goevent2/extensions/media_query_ext.dart';
import 'package:goevent2/providers/color_provider.dart';

import '../utils/string.dart';

class Documents extends ConsumerStatefulWidget {
  const Documents({Key? key}) : super(key: key);

  @override
  _DocumentsState createState() => _DocumentsState();
}

class _DocumentsState extends ConsumerState<Documents> {

  
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
                    "Document Management",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Gilroy Medium',
                      color: notifire.darksColor,
                    ),
                  ),
                  const Spacer(),
                  Icon(Icons.more_vert,color: notifire.darksColor,),
                  SizedBox(
                    width: width / 20,
                  ),
                ],
              ),
              SizedBox(
                height: height / 25,
              ),
              Text(CustomStrings.working,  style: TextStyle(
                color: notifire.darksColor,
                fontSize: 15.sp,
                fontFamily: 'Gilroy Bold',
              ),),
              SizedBox(
                height: height / 60,
              ),
              Text(CustomStrings.ever,  style: TextStyle(
                color: notifire.darksColor,
                fontSize: 12.sp,
                fontFamily: 'Gilroy Normal',
              ),),
              SizedBox(
                height: height / 100,
              ),
              Text(CustomStrings.ever,  style: TextStyle(
                color: notifire.darksColor,
                fontSize: 12.sp,
                fontFamily: 'Gilroy Normal',
              ),),
              SizedBox(
                height: height / 100,
              ),
              Text(CustomStrings.ever,  style: TextStyle(
                color: notifire.darksColor,
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
