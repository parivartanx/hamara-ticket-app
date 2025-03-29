import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/models/event/event_model.dart';
import '/extensions/media_query_ext.dart';

class AttendeesList extends StatelessWidget {
  final Event event;

  const AttendeesList({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(25),
      ),
      width: context.width / 1.4,
      height: context.height / 14,
      child: Card(
        color: context.colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Row(
          children: [
            SizedBox(width: context.width / 20),
            Text(
              "${event.maxCapacity} people",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                fontFamily: 'Gilroy Medium',
                color: context.colorScheme.onSurface,
              ),
            ),
            const Spacer(),
            Container(
              height: 30.h,
              width: 100.w,
              decoration: BoxDecoration(
                color: context.colorScheme.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  "View All",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Gilroy Medium',
                  ),
                ),
              ),
            ),
            SizedBox(width: context.width / 20),
          ],
        ),
      ),
    );
  }
}

class AttendeesContent extends StatelessWidget {

  const AttendeesContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: context.height / 80),
      child: Row(
        children: [
          SizedBox(width: context.width / 40),
          Stack(
            children: [
              Column(
                children: [
                  Image.asset(
                    "assets/image/p1.png",
                    height: context.height / 30,
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: context.width / 20),
                  Stack(
                    children: [
                      Image.asset(
                        "assets/image/p2.png",
                        height: context.height / 30,
                      ),
                      Row(
                        children: [
                          SizedBox(width: context.width / 20),
                          Stack(
                            children: [
                              Image.asset(
                                "assets/image/p3.png",
                                height: context.height / 30,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    "  + 20 Going",
                    style: TextStyle(
                      color: const Color(0xff5d56f3),
                      fontSize: 12.sp,
                      fontFamily: 'Gilroy Bold',
                    ),
                  ),
                  SizedBox(width: context.width / 10),
                  // const InviteButton(),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
