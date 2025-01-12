import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Customtextfild {
  static Widget textField(name1,clr,textcolor, img,) {
    return ScreenUtilInit(
      builder:  (BuildContext context, child) =>  Container(
        color: Colors.transparent,
        height: 45.h,
        //width: 300.w,
        child: TextField(
          style: TextStyle(color: textcolor),
          decoration: InputDecoration(
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.sp),
            ),
            labelText: name1,
            labelStyle: TextStyle(color: clr),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(17),
              child: Image.asset(img),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.sp),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xffdcdbdb), width: 1),
              borderRadius: BorderRadius.circular(10.sp),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xff5669FF), width: 1),
              borderRadius: BorderRadius.circular(10.sp),
            ),
          ),
        ),
      ),
    );
  }
}
