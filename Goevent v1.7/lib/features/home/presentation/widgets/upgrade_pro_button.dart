import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/features/home/upgrade.dart';
import 'package:page_transition/page_transition.dart';
import '/extensions/media_query_ext.dart';

class UpgradeProButton extends StatelessWidget {
  final Color proColor;

  const UpgradeProButton({
    Key? key,
    required this.proColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: const Membership(),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            color: proColor,
          ),
          height: context.height / 16,
          width: context.width / 2.4,
          child: Row(
            children: [
              SizedBox(width: context.width / 20),
              Image.asset(
                "assets/image/pro.png",
                height: context.height / 35,
              ),
              SizedBox(width: context.width / 40),
              Text(
                "Upgrade Pro",
                style: TextStyle(
                  color: const Color(0xff00f8ff),
                  fontSize: 15.sp,
                  fontFamily: 'Gilroy Medium',
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}