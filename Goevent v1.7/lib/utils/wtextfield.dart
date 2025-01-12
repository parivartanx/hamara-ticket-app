import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Customtextfild3 {
  static Widget textField(textcolor, hinttext,wid,type,no,align) {
    return ScreenUtilInit(
      builder:  (BuildContext context, child) =>  Container(
        color: Colors.transparent,
        height: 45.h,
        width: wid,
        child: TextField(
        keyboardType: type,

  inputFormatters: [
  LengthLimitingTextInputFormatter(no),
  ],
          style: TextStyle(color: textcolor,fontSize: 13.sp),textAlign: align,
          decoration: InputDecoration(labelText: hinttext,
            labelStyle: const TextStyle(color: Colors.grey),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.sp),
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
