import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '/models/event/event_model.dart';
import '/models/park/park_model.dart';
import '/features/home/data/event_data.dart';
import '/features/home/data/park_data.dart';
import '/extensions/media_query_ext.dart';
import '/features/event-details/presentation/screens/event_details_screen.dart';
import 'package:page_transition/page_transition.dart';
import '/features/home/seeall.dart';

enum OccasionType { events, waterPark, park }

class NearbyEventsState {
  final OccasionType selectedType;
  final List<dynamic> filteredItems;

  NearbyEventsState({
    this.selectedType = OccasionType.events,
    this.filteredItems = const [],
  });

  NearbyEventsState copyWith({
    OccasionType? selectedType,
    List<dynamic>? filteredItems,
  }) {
    return NearbyEventsState(
      selectedType: selectedType ?? this.selectedType,
      filteredItems: filteredItems ?? this.filteredItems,
    );
  }
}

final nearbyEventsProvider = StateProvider<NearbyEventsState>((ref) {
  return NearbyEventsState();
});

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

class CategoryChips extends ConsumerWidget {
  const CategoryChips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(nearbyEventsProvider);
    final notifier = ref.watch(nearbyEventsProvider.notifier);
    
    return SingleChildScrollView( 
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          ...OccasionType.values.map((type) => Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(
                _getChipLabel(type),
                style: TextStyle(
                  color: state.selectedType == type 
                    ? Colors.white 
                    : Colors.black87,
                  fontFamily: 'Gilroy Medium',
                  fontSize: 13.sp,
                ),
              ),
              selected: state.selectedType == type,
              onSelected: (bool selected) {
                if (selected) {
                  notifier.update((state) => state.copyWith(
                    selectedType: type,
                    filteredItems: _getFilteredItems(type),
                  ));
                }
              },
              backgroundColor: Colors.grey[200],
              selectedColor: const Color(0xffF0635A),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            ),
          )),
        ],
      ),
    );
  }

  String _getChipLabel(OccasionType type) {
    switch (type) {
      case OccasionType.events:
        return "Events";
      case OccasionType.waterPark:
        return "Water Parks";
      case OccasionType.park:
        return "Parks";
    }
  }

  List<dynamic> _getFilteredItems(OccasionType type) {
    switch (type) {
      case OccasionType.events:
        return events;
      case OccasionType.waterPark:
        return parks.where((park) => park.type == "Water Park").toList();
      case OccasionType.park:
        return parks.where((park) => park.type == "Park").toList();
    }
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
        } else if(state.selectedType == OccasionType.waterPark) {
          return ParkCard(park: state.filteredItems[index] as Park);
        }
        else {
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
                  EventImage(img: event.imageUrls[0]),
                  SizedBox(width: context.width * 0.04),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${DateFormat("dd MMM,yyy").format(DateTime.parse(event.startDate))} - ${event.endDate}",
                              style: TextStyle(
                                fontFamily: 'Gilroy Medium',
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          event.name,
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
                EventImage(img: park.imageUrls[0]),
                SizedBox(width: context.width * 0.04),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        park.name,
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
                            " ${park.address}",
                            style: TextStyle(
                              fontFamily: 'Gilroy Medium',
                              color: context.colorScheme.outline,
                              fontSize: 13.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: context.height * 0.01),
                      Text(
                        "${park.operatingHours[0].openTime} - ${park.operatingHours[0].closeTime}",
                        style: TextStyle(
                          fontFamily: 'Gilroy Medium',
                          fontSize: 13.sp,
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
        child: Image.network(
          img,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Image.asset(
              'assets/image/default_event.png',
              fit: BoxFit.cover,
            );
          },
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