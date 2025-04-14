import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/extensions/media_query_ext.dart';
import 'package:page_transition/page_transition.dart';
import '../providers/recommended_categories_provider.dart';
import '/models/event/event_model.dart';
import '/models/park/park_model.dart';
import '/features/occasion-details/presentation/screens/event_details_screen.dart';

class BestRecommendationSection extends ConsumerWidget {
  const BestRecommendationSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(recommendedCategoriesProvider);
    final items = state.items;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            'Recommended',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            
              fontFamily: 'Gilroy',
            ),
          ),
        ),
        SizedBox(height: 15.h),
        SizedBox(
          height: 175.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              final isPark = item is Park;
              final isWaterPark = isPark && item.type == "Water Park";

              // Get the first image URL with fallback
              final imageUrl = isPark
                  ? (item.imageUrls.isNotEmpty ? item.imageUrls.first : '')
                  : (item.imageUrls.isNotEmpty ? item.imageUrls.first : '');

              // Get the price with fallback
              final price = isPark
                  ? (item.dynamicPricing!.isNotEmpty
                      ? item.dynamicPricing?.first.basePrice
                      : 299)
                  : 299;

              return GestureDetector(
                onTap: () {
                  if (item is Event) {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: EventDetailsScreen(event: item),
                      ),
                    );
                  } else if (isPark) {
                    // Create a mock Event from Park data
                    final mockEvent = Event(
                      id: item.id,
                      name: item.name,
                      description: 'Visit this amazing park',
                      location: item.address,
                      city: 'Patna',
                      address: item.address,
                      imageUrls: item.imageUrls,
                      videoUrls: const [],
                      tags: ['fun', 'entertainment'],
                      latitude: 0.0,
                      longitude: 0.0,
                      startDate: DateTime.now().toString(),
                      endDate: DateTime.now()
                          .add(const Duration(days: 2))
                          .toString(),
                      startTime: '09:00 AM',
                      endTime: '06:00 PM',
                      maxCapacity: 500,
                      adminId: '1',
                      status: 'Scheduled',
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    );

                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: EventDetailsScreen(event: mockEvent),
                      ),
                    );
                  }
                },
                child: Container(
                  width: 160.w,
                  margin: EdgeInsets.only(right: 15.w, bottom: 5.h),
                  decoration: BoxDecoration(
                    color: context.colorScheme.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(15.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(10),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image Section
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(15.r)),
                            child: imageUrl.isNotEmpty
                                ? Image.network(
                                    imageUrl,
                                    height: 85.h,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        height: 85.h,
                                        color: Colors.grey[200],
                                        child: Icon(Icons.image_not_supported,
                                            color: Colors.grey[400]),
                                      );
                                    },
                                  )
                                : Container(
                                    height: 85.h,
                                    color: Colors.grey[200],
                                    child: Icon(Icons.image_not_supported,
                                        color: Colors.grey[400]),
                                  ),
                          ),
                          // Category Badge
                          Positioned(
                            top: 8.h,
                            left: 8.w,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                color: isWaterPark
                                    ? const Color(0xFFFFE4E9)
                                    : isPark
                                        ? const Color(0xFFFFF0F3)
                                        : const Color(0xFFFFF5F7),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Text(
                                isWaterPark
                                    ? 'Water Park'
                                    : isPark
                                        ? 'Park'
                                        : 'Event',
                                style: TextStyle(
                                  color: isWaterPark
                                      ? const Color(0xFFD32651)
                                      : isPark
                                          ? const Color(0xFFE64A6A)
                                          : const Color(0xFFF0635A),
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Gilroy',
                                ),
                              ),
                            ),
                          ),
                          // Rating Badge
                          Positioned(
                            top: 8.h,
                            right: 8.w,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 12.r,
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    '4.5',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Gilroy',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Content Section
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(8.w, 6.w, 8.w, 6.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w700,
                                      
                                      fontFamily: 'Gilroy',
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 2.h),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        size: 12.r,
                                        color: context.colorScheme.outline,
                                      ),
                                      SizedBox(width: 4.w),
                                      Expanded(
                                        child: Text(
                                          isPark ? item.address : item.location,
                                          style: TextStyle(
                                            fontSize: 11.sp,
                                            color: context.colorScheme.outline,
                                            fontFamily: 'Gilroy',
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '₹$price',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w700,
                                      color: context.colorScheme.primary,
                                      fontFamily: 'Gilroy',
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.w, vertical: 4.h),
                                    decoration: BoxDecoration(
                                      color: context.colorScheme.primary
                                          .withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Text(
                                      'Book Now',
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.w600,
                                        color: context.colorScheme.primary,
                                        fontFamily: 'Gilroy',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle event tap
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
        child: Card(
          elevation: 0,
          color: context.colorScheme.surface,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: AspectRatio(
                        aspectRatio: 1.5,
                        child: Image.network(
                          event.imageUrls.first,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: context.height * .01),
                    Text(
                      event.name,
                      style: TextStyle(
                        fontFamily: 'Gilroy Medium',
                        color: context.colorScheme.onSurface,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: context.height * .005),
                    Row(
                      children: [
                        Icon(Icons.location_on,
                            color: Colors.grey, size: 12.sp),
                        Expanded(
                          child: Text(
                            " ${event.address}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'Gilroy Medium',
                              color: Colors.grey,
                              fontSize: 12.sp,
                            ),
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
