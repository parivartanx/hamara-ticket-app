import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../screens/see_all.dart';
import '/features/home/presentation/widgets/park_card.dart';
import '/features/home/data/park_data.dart';
import '/extensions/media_query_ext.dart';
import 'package:page_transition/page_transition.dart';

class BestRecommendationSection extends ConsumerWidget {
  const BestRecommendationSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {    
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Text(
                "Best Recommendations",
                style: TextStyle(
                  fontFamily: 'Gilroy Medium',
                  color: context.colorScheme.onSurface,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: const All(),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Text(
                      "See All",
                      style: TextStyle(
                        fontFamily: 'Gilroy Medium',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_right,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: context.height / 60),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Wrap(
            spacing: 5.w,
            children: [
               SizedBox(width: 5.w),
              ...List.generate(parks.length, (index) => [
                SizedBox(
                  width: context.width *.45,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return ParkCard(
                        park: parks[index],    
                      );
                    }
                  ),
                ),
                if (index < parks.length - 1) SizedBox(width: context.width * 0.04),
              ]).expand((widgets) => widgets),
            ],
          ),
        ),
      ],
    );
  }
}

class AttendeesList extends StatelessWidget {
  const AttendeesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/image/p1.png",
          height: context.height / 30,
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
              " + 20 Going",
              style: TextStyle(
                color: const Color(0xff5d56f3),
                fontSize: 11.sp,
                fontFamily: 'Gilroy Bold',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class LocationWidget extends StatelessWidget {
  const LocationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.location_on, size: 12.sp),
        Text(
          " 36 Guild Street London , UK",
          style: TextStyle(
            fontFamily: 'Gilroy Medium',
            color: Colors.grey,
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }
}

class DateOverlay extends StatelessWidget {
  const DateOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: context.height / 6),
        Row(
          children: [
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                color: context.colorScheme.surface,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              width: context.width / 6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "10 ",
                    style: TextStyle(
                      color: const Color(0xffF0635A),
                      fontSize: 15.sp,
                      fontFamily: 'Gilroy ExtraBold',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "JUNE",
                    style: TextStyle(
                      color: const Color(0xffF0635A),
                      fontSize: 10.sp,
                      fontFamily: 'Gilroy Medium',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: context.width / 40),
          ],
        ),
      ],
    );
  }
}