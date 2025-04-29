import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import '/features/occasion-details/presentation/screens/event_details_screen.dart';
import '/extensions/media_query_ext.dart';
import '/models/event/event_model.dart';
import '/features/home/presentation/providers/home-insights_provider.dart';
import '/features/home/presentation/widgets/shimmer_card_loading.dart';

class RecommendedEventsSection extends ConsumerWidget {
  const RecommendedEventsSection({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeInsights = ref.watch(homeInsightsProvider);

    return homeInsights.when(
      data: (data) {
        final events = data?.recommendedEvents;
        if (events == null || events.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recommended Events',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigate to all events
                    },
                    child: Text(
                      'See All',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: context.colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            SizedBox(
              height: 200.h,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                scrollDirection: Axis.horizontal,
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final event = events[index];
                  return GestureDetector(
                    onTap: () {
                      context.push(EventDetailsScreen.routePath, extra: event.id);
                    },
                    child: _EventCard(event: event),
                  );
                },
              ),
            ),
          ],
        );
      },
      loading: () => const ShimmerCardLoading(title: 'Recommended Events'),
      error: (error, stack) => Center(
        child: Text('Error loading events: $error'),
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  final Event event;

  const _EventCard({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final eventCategory = event.tags.isNotEmpty ? event.tags.first : 'Event';
    final formattedDate = event.startTime != null ? '${event.startDate} • ${event.startTime}' : event.startDate;

    return Container(
      width: 160.w,
      height: 200.h, // Explicitly set height to match parent ListView
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
                borderRadius: BorderRadius.vertical(top: Radius.circular(15.r)),
                child: event.imageUrls.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: event.imageUrls.first,
                        height: 85.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: 85.h,
                            width: double.infinity,
                            color: Colors.white,
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          height: 85.h,
                          color: Colors.grey[200],
                          child: Icon(Icons.image_not_supported,
                              color: Colors.grey[400]),
                        ),
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
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF5F7),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    eventCategory,
                    style: TextStyle(
                      color: const Color(0xFFF0635A),
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
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
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
              padding: EdgeInsets.fromLTRB(8.w, 5.h, 8.w, 5.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        event.name,
                        style: TextStyle(
                          fontSize: 13.sp,
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
                            Icons.calendar_today,
                            size: 11.r,
                            color: context.colorScheme.outline,
                          ),
                          SizedBox(width: 3.w),
                          Expanded(
                            child: Text(
                              formattedDate,
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: context.colorScheme.outline,
                                fontFamily: 'Gilroy',
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 1.h),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 11.r,
                            color: context.colorScheme.outline,
                          ),
                          SizedBox(width: 3.w),
                          Expanded(
                            child: Text(
                              event.location,
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: context.colorScheme.outline,
                                fontFamily: 'Gilroy',
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      
                      // Only show ticket count if available
                      if (event.tickets.isNotEmpty)
                        SizedBox(height: 1.h),
                      if (event.tickets.isNotEmpty)
                        Row(
                          children: [
                            Icon(
                              Icons.confirmation_number,
                              size: 11.r,
                              color: context.colorScheme.outline,
                            ),
                            SizedBox(width: 3.w),
                            Expanded(
                              child: Text(
                                '${event.tickets.length} ticket${event.tickets.length > 1 ? 's' : ''}',
                                style: TextStyle(
                                  fontSize: 10.sp,
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
                  
                  const Spacer(),
                  
                  // Ticket Price Range
                  event.tickets.isNotEmpty
                      ? _buildTicketPriceInfo(context)
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "N/A",
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w700,
                                color: context.colorScheme.primary,
                                fontFamily: 'Gilroy',
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                color: context.colorScheme.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Text(
                                'Book Now',
                                style: TextStyle(
                                  fontSize: 10.sp,
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
    );
  }
  
  Widget _buildTicketPriceInfo(BuildContext context) {
    if (event.tickets.isEmpty) {
      return Text(
        "No tickets available",
        style: TextStyle(
          fontSize: 10.sp,
          color: context.colorScheme.outline,
          fontFamily: 'Gilroy',
        ),
      );
    }
    
    // Sort tickets by price to get min and max
    final sortedTickets = List.from(event.tickets)
      ..sort((a, b) => a.price.compareTo(b.price));
    
    final lowestPrice = sortedTickets.first.price;
    final highestPrice = sortedTickets.last.price;
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              sortedTickets.length > 1
                  ? '₹$lowestPrice${sortedTickets.length > 1 ? '+' : ''}' 
                  : '₹$lowestPrice',
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
                color: context.colorScheme.primary,
                fontFamily: 'Gilroy',
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: 8.w, vertical: 3.h),
          decoration: BoxDecoration(
            color: context.colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(
            'Book Now',
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              color: context.colorScheme.primary,
              fontFamily: 'Gilroy',
            ),
          ),
        ),
      ],
    );
  }
}