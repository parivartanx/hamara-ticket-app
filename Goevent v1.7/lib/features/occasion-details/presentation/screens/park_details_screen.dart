import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/extensions/media_query_ext.dart';
import '/providers/color_provider.dart';
import '/models/park/park_model.dart';
import '../widgets/occasion_info_card.dart';
import '../widgets/occasion_gallery.dart';
import '../widgets/occasion_title_section.dart';
import '../widgets/buy_ticket_button.dart';
import '../widgets/occasion_header.dart';

class ParkDetailsScreen extends ConsumerStatefulWidget {
  static const routePath = '/park-details';
  static const routeName = 'park-details';
  final Park park;

  const ParkDetailsScreen({
    super.key,
    required this.park,
  });

  @override
  ConsumerState<ParkDetailsScreen> createState() => _ParkDetailsScreenState();
}

class _ParkDetailsScreenState extends ConsumerState<ParkDetailsScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    ref.read(colorProvider.notifier).getdarkmodepreviousstate();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final park = widget.park;
    
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      floatingActionButton: BuyTicketButton(
        occasionType: 'Park',
        occasionId: '1',
        occasionName: park.name,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Column(
          children: [
            OccasionHeader(
              title: park.name,
              imageUrls: park.imageUrls,
              maxCapacity: park.maxCapacity,
              isOpen: park.operatingHours?.isNotEmpty == true,
              useCarousel: true,
            ),
            SizedBox(height: context.height / 30),
            ParkBody(park: park),
            SizedBox(height: context.height * 0.1),
          ],
        ),
      ),
    );
  }
}

class ParkBody extends StatelessWidget {
  final Park park;

  const ParkBody({
    super.key,
    required this.park,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OccasionTitleSection(
          name: park.name,
          address: park.address,
          city: park.city,
          tags: park.tags,
        ),
        SizedBox(height: context.height * 0.02),
        // Operating Hours and Pricing Cards
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              if (park.operatingHours?.isNotEmpty == true)
                OperatingHoursCard(operatingHours: park.operatingHours!),
              if (park.dynamicPricing?.isNotEmpty == true)
                PricingCard(pricing: park.dynamicPricing!),
            ],
          ),
        ),
        SizedBox(height: context.height * 0.02),
        // Attractions Section
        if (park.attractions.isNotEmpty)
          AttractionsSection(attractions: park.attractions),
        SizedBox(height: context.height * 0.02),
        // Image Gallery
        OccasionGallery(imageUrls: park.imageUrls),
        SizedBox(height: context.height * 0.02),
        // Additional Info Cards
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Additional Information",
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Gilroy Medium',
                  color: context.colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 8.h),
              OccasionInfoCard(
                title: "Location",
                subtitle: "${park.address}, ${park.city}",
                icon: Icons.location_on,
                hasBorder: true,
              ),
              if (park.type != null)
                OccasionInfoCard(
                  title: "Type",
                  subtitle: park.type!,
                  icon: Icons.category,
                  hasBorder: true,
                ),
              OccasionInfoCard(
                title: "Tags",
                subtitle: park.tags.join(", "),
                icon: Icons.local_offer,
                hasBorder: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class OperatingHoursCard extends StatelessWidget {
  final List<OperatingHour> operatingHours;

  const OperatingHoursCard({
    super.key,
    required this.operatingHours,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width * 0.45,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(15),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.access_time, size: 16.sp),
              SizedBox(width: 4.w),
              Text(
                "Operating Hours",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Gilroy Medium',
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          ...operatingHours.map((hour) => Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      hour.day,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      "${hour.openTime} - ${hour.closeTime}",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class PricingCard extends StatelessWidget {
  final List<DynamicPricing> pricing;

  const PricingCard({
    super.key,
    required this.pricing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width * 0.45,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(15),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.currency_rupee, size: 16.sp),
              SizedBox(width: 4.w),
              Text(
                "Pricing",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Gilroy Medium',
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          ...pricing.map((price) => Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      price.dayType,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      "₹${price.basePrice}",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class AttractionsSection extends StatelessWidget {
  final List<Attraction> attractions;

  const AttractionsSection({
    super.key,
    required this.attractions,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Attractions",
            style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w700,
              fontFamily: 'Gilroy Medium',
              color: context.colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 12.h),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: attractions.length,
            itemBuilder: (context, index) {
              final attraction = attractions[index];
              return Container(
                margin: EdgeInsets.only(bottom: 8.h),
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: context.colorScheme.surface,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: context.colorScheme.outline.withOpacity(0.1),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: context.colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Icon(
                        Icons.attractions,
                        color: context.colorScheme.primary,
                        size: 20.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            attraction.name,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Gilroy Medium',
                            ),
                          ),
                          if (attraction.type.isNotEmpty)
                            Text(
                              attraction.type,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey,
                              ),
                            ),
                        ],
                      ),
                    ),
                    if (attraction.heightRestriction != null)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.height,
                              size: 14.sp,
                              color: Colors.orange,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              "${attraction.heightRestriction}cm",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.orange,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
