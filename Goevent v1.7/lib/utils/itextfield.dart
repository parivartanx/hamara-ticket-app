import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Customtextfild2 {
  static Widget textField(txt,name1,clr,textcolor, img, se,) {
    return ScreenUtilInit(
      builder: (BuildContext context, child) =>  Container(
        color: Colors.transparent,
        height: 45.h,
        //width: 350.w,
        child: TextField(
          obscureText: txt,
          style: TextStyle(color:textcolor),
          decoration: InputDecoration(
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.sp),
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(15),
              child: Image.asset(img),
            ),labelText: name1,
            labelStyle: TextStyle(color: clr),
            suffixIcon: Padding(
              padding: const EdgeInsets.all(10),
              child: se
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
