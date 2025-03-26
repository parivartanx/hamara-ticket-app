import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamaraticket/extensions/media_query_ext.dart';
import 'package:hamaraticket/features/event-details/presentation/screens/event_details_screen.dart';
import 'package:hamaraticket/features/home/seeall.dart';
import 'package:page_transition/page_transition.dart';
import '../../../../../utils/string.dart';
import '../providers/bookmark_provider.dart';

class UpcomingEventsSection extends ConsumerWidget {
  const UpcomingEventsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarkStates = ref.watch(bookmarkStateProvider);
    final List<String> imageUrls= ["assets/image/lagoon-waterpark.webp", "assets/image/g2.png", "assets/image/g3.png", "assets/image/g4.png"];
    
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
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      Text(
                        CustomStrings.seeall,
                        style: TextStyle(
                          fontFamily: 'Gilroy Medium',
                          color: const Color(0xff747688),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const Icon(
                        Icons.arrow_right,
                        color: Color(0xff747688),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: context.height / 60),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              // const SizedBox(width: 10),
              ...List.generate(imageUrls.length, (index) => [
                EventCard(
                  isSelected: bookmarkStates[index] ?? false,
                  img: imageUrls[index],
                  onBookmarkToggle: () => ref.read(bookmarkStateProvider.notifier).toggleBookmark(index),
                ),
                if (index < imageUrls.length - 1) SizedBox(width: context.width * 0.04),
              ]).expand((widgets) => widgets),
              const SizedBox(width: 10),
            ],
          ),
        ),
      ],
    );
  }
}

class EventCard extends StatelessWidget {
  final bool isSelected;
  final String img;
  final VoidCallback onBookmarkToggle;

  const EventCard({
    Key? key,
    required this.isSelected,
    required this.img,
    required this.onBookmarkToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: const EventDetailsScreen(),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: context.colorScheme.surface,
          border: Border.all(
            color: const Color(0xffdcdbdb),
            width: 1,
          ),
        ),
        width: context.width / 1.5,
        child: Card(
          elevation: 0,
          color: context.colorScheme.surface,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EventImage(isSelected: isSelected, img: img, onBookmarkToggle: onBookmarkToggle),
                    SizedBox(height: context.height / 40),
                    Text(
                      "Lagoon Water Park",
                      style: TextStyle(
                        fontFamily: 'Gilroy Medium',
                        color: context.colorScheme.onSurface,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    // const AttendeesList(),
                    SizedBox(height: context.height / 50),
                    const LocationWidget(),
                  ],
                ),
                const DateOverlay(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EventImage extends StatelessWidget {
  final bool isSelected;
  final String img;
  final VoidCallback onBookmarkToggle;

  const EventImage({
    Key? key,
    required this.isSelected,
    required this.img,
    required this.onBookmarkToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height / 5.5,
      width: context.width / 1.7,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Colors.transparent,
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: AspectRatio(
              aspectRatio: 1.5,
              child: Image.asset(
                img,
                fit: BoxFit.fill,
              ),
            ),
          ),
          // Column(
          //   children: [
          //     SizedBox(height: context.height *.03),
          //     Row(
          //       children: [
          //         SizedBox(width: context.width / 70),
          //         const Spacer(),
          //         BookmarkButton(isSelected: isSelected, onTap: onBookmarkToggle),
          //         SizedBox(width: context.width / 40),
          //       ],
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}

class BookmarkButton extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;

  const BookmarkButton({
    Key? key,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
          color:  Color.fromRGBO(255, 255, 255, 0.7),
          borderRadius:  BorderRadius.all(Radius.circular(5)),
        ),
        height: context.height / 25,
        width: context.width / 12,
        child: Padding(
          padding: const EdgeInsets.all(7),
          child: isSelected
              ? Image.asset("assets/image/book1.png")
              : Image.asset(
                  "assets/image/book2.png",
                  color: const Color(0xffF0635A),
                ),
        ),
      ),
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
        Image.asset(
          "assets/image/location.png",
          height: context.height / 40,
        ),
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