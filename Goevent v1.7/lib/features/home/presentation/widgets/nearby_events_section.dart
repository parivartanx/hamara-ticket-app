import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamaraticket/extensions/media_query_ext.dart';
import 'package:hamaraticket/features/event-details/presentation/screens/event_details_screen.dart';
import 'package:hamaraticket/features/home/seeall.dart';
import 'package:page_transition/page_transition.dart';
import '../providers/nearby_events_provider.dart';
import '../../domain/models/event.dart';

import '../../../../../providers/color_provider.dart';

class NearbyEventsSection extends ConsumerWidget {
  final ColorState notifire;

  const NearbyEventsSection({Key? key, required this.notifire}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const SectionHeader(),
        SizedBox(height: context.height / 60),
        const EventsList(),
      ],
    );
  }
}

class SectionHeader extends StatelessWidget {
  const SectionHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Text(
            "Nearby You",
            style: TextStyle(
              fontFamily: 'Gilroy Medium',
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
                    "See All",
                    style: TextStyle(
                      fontFamily: 'Gilroy Medium',
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
    );
  }
}

class EventsList extends ConsumerWidget {
  const EventsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = ref.watch(nearbyEventsProvider);

    return Column(
      children: events.map((event) => EventCard(event: event)).toList(),
    );
  }
}

class EventCard extends ConsumerWidget {
  final Event event;

  const EventCard({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: const EventDetailsScreen(),
            ),
          );
        },
        child: Card(
          elevation: 0,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: const Color(0xffdcdbdb),
                width: 0.2,
              ),
            ),
            height: context.height * 0.14,
            width: context.width,
            child: Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 5, top: 5),
              child: Row(
                children: [
                  EventImage(img: event.imageUrl),
                  SizedBox(width: context.width * 0.04),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${event.date} - ${event.time}",
                              style: TextStyle(
                                fontFamily: 'Gilroy Medium',
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            BookmarkButton(
                              isSelected: event.isBookmarked,
                              onTap: () => ref.read(nearbyEventsProvider.notifier).toggleBookmark(event.id),
                            ),
                          ],
                        ),
                        Text(
                          event.title,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Gilroy Medium',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: context.height * 0.01),
                        Row(
                          children: [
                            Image.asset(
                              "assets/image/location.png",
                              height: context.height / 70,
                            ),
                            Text(
                              " ${event.location}",
                              style: TextStyle(
                                fontFamily: 'Gilroy Medium',
                                color: context.colorScheme.outline,
                                fontSize: 13.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
        child: Image.asset(
          img,
          fit: BoxFit.cover,
        ),
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
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        height: context.height / 25,
        width: context.width * 0.1,
        child: Padding(
          padding: const EdgeInsets.all(5),
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