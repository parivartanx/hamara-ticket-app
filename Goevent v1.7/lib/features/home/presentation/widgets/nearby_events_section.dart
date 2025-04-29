import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../screens/nearby_see_all.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import '/models/event/event_model.dart';
import '/models/park/park_model.dart';
import '/extensions/media_query_ext.dart';
import 'package:page_transition/page_transition.dart';
import '/features/home/presentation/providers/nearby_events_provider.dart';
import 'category_chips.dart';

class NearbyEventsSection extends ConsumerWidget {
  const NearbyEventsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const SectionHeader(),
        SizedBox(height: context.height / 60),
        const CategoryChips(),
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
                  child: const NearBySeeAll(),
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
    final state = ref.watch(nearbyEventsProvider);

    return Column(
      children: List.generate(state.filteredItems.length, (index) {
        if (state.selectedType == OccasionType.events) {
          return EventCard(event: state.filteredItems[index] as Event);
        } else if (state.selectedType == OccasionType.waterPark) {
          return ParkCard(park: state.filteredItems[index] as Park);
        } else {
          return ParkCard(park: state.filteredItems[index] as Park);
        }
      }),
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: GestureDetector(
        onTap: () {
          // Navigator.push(
          //   context,
          //   PageTransition(
          //     type: PageTransitionType.fade,
          //     child:  EventDetailsScreen(event:event ,),
          //   ),
          // );
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
            width: context.width,
            child: Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 5, top: 5),
              child: Row(
                children: [
                  OccasionImage(img: event.imageUrls[0]),
                  SizedBox(width: context.width * 0.04),
                  Expanded(
                    child: Column(
                      spacing: 2.h,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SizedBox(height: 2.h),
                        Text(
                          "${DateFormat("dd MMM,yyy").format(DateTime.parse(event.startDate))} - ${DateFormat("dd MMM,yyy").format(DateTime.parse(event.endDate))}",
                          style: TextStyle(
                            fontFamily: 'Gilroy Medium',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          event.name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Gilroy Medium',
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 13.sp,
                            ),
                            Text(
                              " ${event.location}",
                              style: TextStyle(
                                fontFamily: 'Gilroy Medium',
                                color: context.colorScheme.outline,
                                fontSize: 12.sp,
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

class ParkCard extends StatelessWidget {
  final Park park;

  const ParkCard({
    Key? key,
    required this.park,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: GestureDetector(
        onTap: () {
          // Navigator.push(
          //   context,
          //   PageTransition(
          //     type: PageTransitionType.fade,
          //     child: const EventDetailsScreen(),
          //   ),
          // );
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
            width: context.width,
            child: Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 5, top: 5),
              child: Row(
                children: [
                  OccasionImage(img: park.imageUrls[0]),
                  SizedBox(width: context.width * 0.04),
                  Expanded(
                    child: Column(
                      spacing: 2.h,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          park.name,
                          style: TextStyle(
                            fontFamily: 'Gilroy Medium',
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 13.sp,
                            ),
                            Text(
                              " ${park.address}",
                              style: TextStyle(
                                fontFamily: 'Gilroy Medium',
                                color: context.colorScheme.outline,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${park.operatingHours?.first.openTime} - ${park.operatingHours?.first.closeTime}",
                          style: TextStyle(
                            fontFamily: 'Gilroy Medium',
                            fontSize: 12.sp,
                            color: context.colorScheme.outline,
                          ),
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

class OccasionImage extends StatelessWidget {
  final String img;

  const OccasionImage({Key? key, required this.img}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width / 5,
      height: context.height / 10,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: CachedNetworkImage(
          imageUrl: img,
          fit: BoxFit.cover,
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              color: Colors.white,
            ),
          ),
          errorWidget: (context, url, error) => Container(
            color: Colors.grey[200],
            child: Icon(Icons.image_not_supported, color: Colors.grey[400]),
          ),
        ),
      ),
    );
  }
}
