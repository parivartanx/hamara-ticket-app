import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/extensions/media_query_ext.dart';


class Custombutton {
  static Widget button(clr,text,siz,siz2){
    return ScreenUtilInit(
      builder: (BuildContext context, child) => Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            color: clr,
          ),
          height: context.height *.07,
          width: context.width,
          child: Row(
            children: [
              siz,
              Text(
                text,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,),
              ),
              siz2,
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 9),
                child: Image.asset("assets/image/arrow.png"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}