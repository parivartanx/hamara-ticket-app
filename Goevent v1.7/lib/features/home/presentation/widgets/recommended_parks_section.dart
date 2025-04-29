
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
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
    final parkCategory = park.tags.isNotEmpty ? park.tags.first : (isWaterPark ? 'Water Park' : 'Park');

    final isTicketsAvailable = park.tickets.isNotEmpty;
    // Offer-related data
    final bool hasOffer = isTicketsAvailable && 
        park.tickets.isNotEmpty && // Added additional safety check
        park.tickets.first.platformOffer != null && 
        park.tickets.first.platformOffer! > 0; // Added check for positive offer value
        
    final bool isPercentOffer = hasOffer && 
        park.tickets.first.platformOfferType?.toLowerCase() == 'percentage'; // Added null check and lowercase
        
    // Safe access to ticket price
    final double originalPrice = isTicketsAvailable ? 
        park.tickets.first.price.toDouble() : 0.0;
        
    // Safe access to offer amount
    final double offerAmount = hasOffer ? 
        (isPercentOffer ? 
            originalPrice * (park.tickets.first.platformOffer! / 100) : // Percentage calculation
            park.tickets.first.platformOffer!) : // Fixed amount
        0.0;
        
    final double savedAmount = offerAmount;
    final double currentPrice = hasOffer ? originalPrice - savedAmount : originalPrice;
    
  

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
                    ? CachedNetworkImage(
                      imageUrl: park.imageUrls.first,
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
                      errorWidget: (context, url, error) {
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
              // Offer Badge
              if (hasOffer)
                Positioned(
                  bottom: 8.h,
                  left: 8.w,
                  child: Container(
                    constraints: BoxConstraints(minWidth: 50.w),  // Added constraints
                    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
                    decoration: BoxDecoration(
                      color: Colors.red[600],
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isPercentOffer ? Icons.percent : Icons.currency_rupee,
                          color: Colors.white,
                          size: 10.sp,
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          "OFFER",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Gilroy',
                          ),
                        ),
                      ],
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
              padding: EdgeInsets.fromLTRB(8.w, 6.w, 8.w, 8.w), // Increased bottom padding from 6.w to 8.w
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Price and savings row
                      if (hasOffer) ...[
                        Row(
                          children: [
                            Text(
                              "₹$originalPrice",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey,
                                fontFamily: 'Gilroy',
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            SizedBox(width: 6.w),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                              decoration: BoxDecoration(
                                color: Colors.green[50],
                                borderRadius: BorderRadius.circular(2.r),
                              ),
                              child: Text(
                                "Save ₹$savedAmount",
                                style: TextStyle(
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.green[700],
                                  fontFamily: 'Gilroy',
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h), // Reduced from 2.h to 1.h to save space
                      ],
                      // Price and book now row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '₹$currentPrice',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: context.colorScheme.primary,
                              fontFamily: 'Gilroy',
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 3.h), // Reduced vertical padding from 4.h to 3.h
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}