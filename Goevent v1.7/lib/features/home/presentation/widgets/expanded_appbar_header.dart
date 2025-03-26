// Expanded App Bar Header Widget
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/extensions/media_query_ext.dart';
import '/features/home/presentation/screens/home.dart';
import '/notification/notification.dart';
import 'package:page_transition/page_transition.dart';

import 'search_bar_widget.dart';

class ExpandedAppBarHeader extends StatelessWidget {
  final String greeting;
  final String userName;
  
  const ExpandedAppBarHeader({Key? key, required this.greeting, required this.userName}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.primary,
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: context.height / 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      z.toggle!();
                    },
                    child: Container(
                      height: context.height / 25,
                      color: Colors.transparent,
                      child: const Padding(
                        padding: EdgeInsets.all(7),
                        child: ImageIcon(
                          AssetImage("assets/image/draw.png"),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: context.width * .05),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontFamily: 'Gilroy Medium',
                            ),
                            children: [
                              TextSpan(
                                text: "$greeting, ",
                                style: const TextStyle(fontWeight: FontWeight.w500),
                              ),
                              TextSpan(
                                text: userName,
                                style: const TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "New York, USA",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.sp,
                                fontFamily: 'Gilroy Medium',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: const Note(),
                        ),
                      );
                    },
                    child: const Icon(Icons.notifications , color: Colors.white,))
                ],
              ),
            ),
            SizedBox(height: context.height / 30),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SearchBarWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
