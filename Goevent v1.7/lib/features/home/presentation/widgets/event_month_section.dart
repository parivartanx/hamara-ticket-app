import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../screens/see_all.dart';
import '/extensions/media_query_ext.dart';
import 'package:page_transition/page_transition.dart';
import '../../../../../providers/color_provider.dart';

class EventMonthSection extends ConsumerWidget {
  final ColorState notifire;

  const EventMonthSection({Key? key, required this.notifire}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        SectionHeader(notifire: notifire),
        SizedBox(height: context.height / 60),
        EventsList(notifire: notifire),
      ],
    );
  }
}

class SectionHeader extends StatelessWidget {
  final ColorState notifire;

  const SectionHeader({Key? key, required this.notifire}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Text(
            "Event This Month",
            style: TextStyle(
              fontFamily: 'Gilroy Medium',
              color: notifire.textColor,
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
            child: Text(
              "See All",
              style: TextStyle(
                fontFamily: 'Gilroy Medium',
                color: const Color(0xff747688),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EventsList extends StatelessWidget {
  final ColorState notifire;

  const EventsList({Key? key, required this.notifire}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EventCard(notifire: notifire, img: "assets/image/n1.png", name: "Halloween Festival"),
        EventCard(notifire: notifire, img: "assets/image/n2.png", name: "Women's Festival"),
        EventCard(notifire: notifire, img: "assets/image/n3.png", name: "Halloween Festival"),
        EventCard(notifire: notifire, img: "assets/image/n4.png", name: "Women's Festival"),
        EventCard(notifire: notifire, img: "assets/image/n5.png", name: "Halloween Festival"),
      ],
    );
  }
}


class EventCard extends StatelessWidget {
  final ColorState notifire;
  final String img;
  final String name;

  const EventCard({
    Key? key,
    required this.notifire,
    required this.img,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   PageTransition(
        //     type: PageTransitionType.fade,
        //     child: const EventDetailsScreen(),
        //   ),
        // );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Card(
          elevation: 0,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: context.colorScheme.outlineVariant,
                width: 0.5,
              ),
            ),
            // height: context.height / 7,
            width: context.width,
            child: Row(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          EventImage(img: img),
                          EventDetails(notifire: notifire, name: name),
                        ],
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                DateContainer(notifire: notifire),
                SizedBox(width: context.width / 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EventImage extends StatelessWidget {
  final String img;

  const EventImage({Key? key, required this.img}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width / 5,
      height: context.height / 8,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: Image.asset(img, fit: BoxFit.cover),
      ),
    );
  }
}

class EventDetails extends StatelessWidget {
  final ColorState notifire;
  final String name;

  const EventDetails({Key? key, required this.notifire, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: context.height * 0.01),
        Row(
          children: [
            SizedBox(width: context.width / 50),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontFamily: 'Gilroy Medium',
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: context.height * 0.01),
                const LocationInfo(),
                SizedBox(height: context.height * 0.01),
                const AttendeesList(),
              ],
            ),
          ],
        ),
        SizedBox(height: context.height / 80),
      ],
    );
  }
}

class LocationInfo extends StatelessWidget {
  const LocationInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          "assets/image/location.png",
          height: context.height / 70,
        ),
        Text(
          " 36 Guild Street London , UK",
          style: TextStyle(
            fontFamily: 'Gilroy Medium',
            color: context.colorScheme.outline,
            fontSize: 12.sp,
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
                        Row(
                          children: [
                            SizedBox(width: context.width / 20),
                            Stack(
                              children: [
                                Image.asset(
                                  "assets/image/p4.png",
                                  height: context.height / 30,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Text(
              " 250 + Joined",
              style: TextStyle(
                color: const Color(0xffF0635A),
                fontSize: 12.sp,
                fontFamily: 'Gilroy Bold',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class DateContainer extends StatelessWidget {
  final ColorState notifire;

  const DateContainer({Key? key, required this.notifire}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: context.height / 80),
        Container(
          decoration: BoxDecoration(
            color: notifire.pinkColor,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          height: context.height / 13,
          width: context.width / 8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Feb",
                style: TextStyle(
                  color: notifire.darksColor,
                  fontSize: 14.sp,
                  fontFamily: 'Gilroy Bold',
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "12",
                style: TextStyle(
                  color: const Color(0xffF0635A),
                  fontSize: 15.sp,
                  fontFamily: 'Gilroy ExtraBold',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}