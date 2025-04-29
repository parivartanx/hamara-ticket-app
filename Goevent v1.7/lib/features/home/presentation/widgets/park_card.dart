import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import '/extensions/media_query_ext.dart';
import '/models/park/park_model.dart';

class ParkCard extends ConsumerWidget {
  final Park park;

  const ParkCard({
    Key? key,
    required this.park,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Example offer data (replace with actual data from your Park model)
    final bool hasOffer = park.tickets.isNotEmpty &&  (park.tickets.first.platformOffer!= null && park.tickets.first.platformOffer! > 0);
    final bool isPercentOffer = hasOffer &&
        park.tickets.first.platformOfferType == 'percentage';
    final double originalPrice = hasOffer && park.tickets.isNotEmpty ? 
        park.tickets.first.price.toDouble()  : 0.0;
        
    final double currentPrice = park.tickets.isNotEmpty ? park.tickets.first.price.toDouble() : 0.0;
    final double savedAmount = hasOffer ? originalPrice - currentPrice : 0.0;

    log("Current price and saved amount: $currentPrice, $savedAmount");
    
    return GestureDetector(
      onTap: () {
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
                padding:  EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ParkImage(
                      img: park.imageUrls.first,
                      hasOffer: hasOffer,
                      isPercentOffer: isPercentOffer,
                    ),
                    SizedBox(height: context.height*.01 ),
                    Text(
                      park.name,
                      style: TextStyle(
                        fontFamily: 'Gilroy Medium',
                        color: context.colorScheme.onSurface,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: context.height *.005),
                    LocationWidget(location: park.city),
                    
                    // Price and offer section
                    if (park.tickets.isNotEmpty) ...[
                      SizedBox(height: context.height * .01),
                      Row(
                        children: [
                          // Current price
                          Text(
                            "₹$currentPrice",
                            style: TextStyle(
                              fontFamily: 'Gilroy Bold',
                              color: context.colorScheme.primary,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 6.w),
                          
                          // Original price (crossed out)
                          if (hasOffer)
                            Text(
                              "₹$originalPrice",
                              style: TextStyle(
                                fontFamily: 'Gilroy Medium',
                                color: Colors.grey,
                                fontSize: 12.sp,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          
                          const Spacer(),
                          
                          // Saved amount
                          if (hasOffer)
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                              decoration: BoxDecoration(
                                color: Colors.green[50],
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              child: Text(
                                "Save ₹$savedAmount",
                                style: TextStyle(
                                  fontFamily: 'Gilroy Medium',
                                  color: Colors.green[700],
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              DateOverlay(date: park.createdAt!),
            ],
          ),
        ),
      ),
    );
  }
}

class ParkImage extends StatelessWidget {
  final String img;
  final bool hasOffer;
  final bool isPercentOffer;

  const ParkImage({
    Key? key,
    required this.img,
    this.hasOffer = false,
    this.isPercentOffer = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height*.17,
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
              child: CachedNetworkImage(
                imageUrl: img,
                fit: BoxFit.fill,
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
          ),
          
          // Offer badge
          if (hasOffer)
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                // Add constraints to ensure the Container has bounded dimensions
                constraints: BoxConstraints(minWidth: 60.w),
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
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
                      size: 12.sp,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      "OFFER",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
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

class LocationWidget extends StatelessWidget {
  final String location;

  const LocationWidget({
    Key? key,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
         Icon(Icons.location_on, color: Colors.grey,size: 12.sp,),
        Expanded(
          child: Text(
            " $location",
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
    );
  }
}

class DateOverlay extends StatelessWidget {
  final DateTime date;

  const DateOverlay({
    Key? key,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: context.height *.12),
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
                    "${date.day} ",
                    style: TextStyle(
                      color: const Color(0xffF0635A),
                      fontSize: 13.sp,
                      fontFamily: 'Gilroy ExtraBold',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    _getMonthName(date.month),
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

  String _getMonthName(int month) {
    const months = [
      'JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN',
      'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'
    ];
    return months[month - 1];
  }
}
