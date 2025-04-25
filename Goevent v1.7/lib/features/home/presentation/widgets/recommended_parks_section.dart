import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '/features/occasion-details/presentation/screens/park_details_screen.dart';
import '/extensions/media_query_ext.dart';
import '/models/park/park_model.dart';
import '/features/home/presentation/providers/home-insights_provider.dart';
import '/features/home/presentation/widgets/shimmer_card_loading.dart';

class RecommendedParksSection extends ConsumerWidget {
  const RecommendedParksSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeInsights = ref.watch(homeInsightsProvider);

    return homeInsights.when(
      data: (data) {
        final parks = data?.recommendedParks;
        if (parks == null || parks.isEmpty) {
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
                    'Recommended Parks',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigate to all parks
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
                itemCount: parks.length,
                itemBuilder: (context, index) {
                  final park = parks[index];
                  return GestureDetector(
                    onTap: () {
                      context.push(ParkDetailsScreen.routePath, extra: park.id);
                    },
                    child: RecommendedParkCard(park: park),
                  );
                },
              ),
            ),
          ],
        );
      },
      loading: () => const ShimmerCardLoading(title: 'Recommended Parks'),
      error: (error, stack) => Center(
        child: Text('Error loading parks: $error'),
      ),
    );
  }
}

class RecommendedParkCard extends StatelessWidget {
  final Park park;

  const RecommendedParkCard({Key? key, required this.park}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isWaterPark = park.type?.toLowerCase() == "water park";
    final price = park.tickets.isNotEmpty == true
        ? park.tickets.first.price
        : "N/A";
    final parkCategory = park.tags.isNotEmpty ? park.tags.first : (isWaterPark ? 'Water Park' : 'Park');

    return Container(
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
                borderRadius: BorderRadius.vertical(top: Radius.circular(15.r)),
                child: park.imageUrls.isNotEmpty
                    ? Image.network(
                        park.imageUrls.first,
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
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: isWaterPark
                        ? const Color(0xFFFFE4E9)
                        : const Color(0xFFFFF0F3),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    parkCategory,
                    style: TextStyle(
                      color: isWaterPark
                          ? const Color(0xFFD32651)
                          : const Color(0xFFE64A6A),
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
              padding: EdgeInsets.fromLTRB(8.w, 6.w, 8.w, 6.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        park.name,
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
                              park.address,
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
                      if (park.attractions.isNotEmpty) ...[
                        SizedBox(height: 2.h),
                        Row(
                          children: [
                            Icon(
                              Icons.attractions,
                              size: 12.r,
                              color: context.colorScheme.outline,
                            ),
                            SizedBox(width: 4.w),
                            Expanded(
                              child: Text(
                                '${park.attractions.length} Attractions',
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
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          color: context.colorScheme.primary.withOpacity(0.1),
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
    );
  }
} 