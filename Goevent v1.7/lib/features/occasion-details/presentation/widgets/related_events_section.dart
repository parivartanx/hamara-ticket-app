import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import '/features/occasion-details/presentation/screens/event_details_screen.dart';
import '/extensions/media_query_ext.dart';
import '/models/event/event_model.dart';

class RelatedEventCard extends StatelessWidget {
  final Event event;

  const RelatedEventCard({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(EventDetailsScreen.routePath, extra: event.id);
      },
      child: Container(
        width: 200.w,
        margin: EdgeInsets.only(right: 12.w, bottom: 5.h),
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
            // Image
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15.r)),
              child: event.imageUrls.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: event.imageUrls.first,
                      height: 130.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          color: Colors.white,
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        height: 130.h,
                        color: Colors.grey[200],
                        child: Icon(Icons.image_not_supported, color: Colors.grey[400]),
                      ),
                    )
                  : Container(
                      height: 130.h,
                      color: Colors.grey[200],
                      child: Icon(Icons.image_not_supported, color: Colors.grey[400]),
                    ),
            ),
            // Content
            Padding(
              padding: EdgeInsets.all(10.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.name,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.onSurface,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 12.r,
                        color: context.colorScheme.primary,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        event.startDate,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: context.colorScheme.outline,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
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
                          event.location,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: context.colorScheme.outline,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
    );
  }
}

class RelatedEventsSection extends StatelessWidget {
  final List<Event> events;

  const RelatedEventsSection({
    super.key,
    required this.events,
  });

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            "Related Events",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: context.colorScheme.onSurface,
            ),
          ),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          height: 220.h,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            scrollDirection: Axis.horizontal,
            itemCount: events.length,
            itemBuilder: (context, index) {
              return RelatedEventCard(event: events[index]);
            },
          ),
        ),
      ],
    );
  }
}