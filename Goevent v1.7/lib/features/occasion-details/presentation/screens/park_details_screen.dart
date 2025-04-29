import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../models/ticket/ticket_model.dart';
import '../provider/occasion_provider.dart';
import '/extensions/media_query_ext.dart';
import '/providers/color_provider.dart';
import '/models/park/park_model.dart';
import '../widgets/occasion_info_card.dart';
import '../widgets/occasion_gallery.dart';
import '../widgets/occasion_title_section.dart';
import '../widgets/buy_ticket_button.dart';
import '../widgets/occasion_header.dart';

enum OccasionType {
  park,
  waterpark,
  event;

  String get displayName {
    switch (this) {
      case OccasionType.park:
        return 'Park';
      case OccasionType.waterpark:
        return 'Waterpark';
      case OccasionType.event:
        return 'Event';
    }
  }

  static OccasionType fromString(String? type) {
    if (type == null) return OccasionType.park;
    switch (type.toLowerCase()) {
      case 'waterpark':
        return OccasionType.waterpark;
      case 'event':
        return OccasionType.event;
      default:
        return OccasionType.park;
    }
  }
}

class ParkDetailsScreen extends ConsumerStatefulWidget {
  static const routePath = '/park-details';
  static const routeName = 'park-details';
  final String parkId;

  const ParkDetailsScreen({
    super.key,
    required this.parkId,
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
    Future.microtask(() {
      if (mounted) {
        ref.read(colorProvider.notifier).getdarkmodepreviousstate();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final parkAsync = ref.watch(parkByIdProvider(widget.parkId));
    
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: parkAsync.when(
        data: (park) => SingleChildScrollView(
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
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Error loading park details: $error'),
        ),
      ),
      floatingActionButton: parkAsync.maybeWhen(
        data: (park) => BuyTicketButton(
          occasionType: OccasionType.fromString(park.type).displayName,
          occasionId: park.id,
          occasionName: park.name,
        ),
        orElse: () => null,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
    // Separate pricing into regular and peak hours
    final regularPricing = park.dynamicPricing?.where((p) => p.dayType != "Peak Hours").toList() ?? [];
    final peakPricing = park.dynamicPricing?.where((p) => p.dayType == "Peak Hours").toList() ?? [];

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
        
        // Tickets and Offers Section
        if (park.tickets != null && park.tickets!.isNotEmpty)
          TicketsAndOffersSection(tickets: park.tickets!),
        
        SizedBox(height: context.height * 0.02),
        
        // Pricing Information Section
        if (park.dynamicPricing?.isNotEmpty == true)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Additional Pricing Information",
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Gilroy Medium',
                    color: context.colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 12.h),
                if (regularPricing.isNotEmpty)
                  PricingInfoCard(
                    title: "Additional Pricing",
                    pricing: regularPricing,
                  ),
                if (regularPricing.isNotEmpty && peakPricing.isNotEmpty)
                  SizedBox(height: 12.h),
                if (peakPricing.isNotEmpty)
                  PricingInfoCard(
                    title: "Peak Hour Pricing",
                    pricing: peakPricing,
                  ),
              ],
            ),
          ),
        SizedBox(height: context.height * 0.02),
        // Operating Hours Section
        if (park.operatingHours?.isNotEmpty == true)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5.h),
                OperatingHoursCard(operatingHours: park.operatingHours!),
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
              // if (park.type != null)
              //   OccasionInfoCard(
              //     title: "Type",
              //     subtitle: park.type!,
              //     icon: Icons.category,
              //     hasBorder: true,
              //   ),
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

  List<List<OperatingHour>> _groupSimilarTimings(List<OperatingHour> hours) {
    Map<String, List<OperatingHour>> timeGroups = {};
    
    for (var hour in hours) {
      String timeKey = '${hour.openTime}-${hour.closeTime}';
      timeGroups.putIfAbsent(timeKey, () => []);
      timeGroups[timeKey]!.add(hour);
    }
    
    return timeGroups.values.toList();
  }

  String _formatDays(List<OperatingHour> sameTimeHours) {
    if (sameTimeHours.length == 1) {
      return sameTimeHours.first.day;
    }
    
    if (sameTimeHours.length == 7) {
      return "All Days";
    }

    List<String> weekDays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];
    List<String> days = sameTimeHours.map((h) => h.day).toList();
    
    if (days.length >= 2 && 
        weekDays.any((day) => days.contains(day)) && 
        days.every((day) => weekDays.contains(day))) {
      return "Weekdays";
    }
    
    if (days.length == 2 && 
        days.contains('Saturday') && 
        days.contains('Sunday')) {
      return "Weekends";
    }
    
    if (sameTimeHours.length <= 3) {
      return days.join(', ');
    }
    
    return "${days.first} - ${days.last}";
  }

  @override
  Widget build(BuildContext context) {
    final groupedHours = _groupSimilarTimings(operatingHours);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: context.colorScheme.outline.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.access_time_rounded,
                size: 16.sp,
                color: context.colorScheme.primary,
              ),
              SizedBox(width: 6.w),
              Text(
                "Operating Hours",
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Gilroy Medium',
                  color: context.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          ...groupedHours.map((sameTimeHours) {
            final firstHour = sameTimeHours.first;
            return Padding(
              padding: EdgeInsets.only(bottom: 6.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _formatDays(sameTimeHours),
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: context.colorScheme.onSurface.withOpacity(0.7),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: firstHour.openTime,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: context.colorScheme.primary,
                          ),
                        ),
                        TextSpan(
                          text: " - ",
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: context.colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                        TextSpan(
                          text: firstHour.closeTime,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: context.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}

class PricingInfoCard extends StatelessWidget {
  final String title;
  final List<DynamicPricing> pricing;

  const PricingInfoCard({
    super.key,
    required this.title,
    required this.pricing,
  });

  String _formatDayType(String dayType) {
    if (dayType == "Peak Hours") return "Peak Hours";
    if (dayType.toLowerCase().contains("weekend")) return "Weekends";
    if (dayType.toLowerCase().contains("weekday")) return "Weekdays";
    return dayType;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: context.colorScheme.outline.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.currency_rupee,
                size: 16.sp,
                color: context.colorScheme.primary,
              ),
              SizedBox(width: 6.w),
              Text(
                title,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Gilroy Medium',
                  color: context.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          ...pricing.map((price) => Padding(
            padding: EdgeInsets.only(bottom: 6.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatDayType(price.dayType),
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: context.colorScheme.onSurface.withOpacity(0.7),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Ticket Price ",
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: context.colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                      TextSpan(
                        text: "+ ₹${price.basePrice}",
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: context.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )).toList(),
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
          SizedBox(height: 5.h),
          ListView.builder(
            padding: EdgeInsets.zero,
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

class TicketsAndOffersSection extends StatelessWidget {
  final List<TicketModel> tickets;

  const TicketsAndOffersSection({
    super.key,
    required this.tickets,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tickets & Offers",
            style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w700,
              fontFamily: 'Gilroy Medium',
              color: context.colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 12.h),
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: tickets.length,
            itemBuilder: (context, index) {
              final ticket = tickets[index];
              
              return Container(
                margin: EdgeInsets.only(bottom: 12.h),
                decoration: BoxDecoration(
                  color: context.colorScheme.surface,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: context.colorScheme.outline.withOpacity(0.1),
                  ),
                ),
                child: Column(
                  children: [
                    // Ticket header
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                      decoration: BoxDecoration(
                        color: context.colorScheme.primary.withOpacity(0.05),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12.r),
                          topRight: Radius.circular(12.r),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.confirmation_number_outlined,
                                size: 18.sp,
                                color: context.colorScheme.primary,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                ticket.ticketType,
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Gilroy Medium',
                                  color: context.colorScheme.onSurface,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: context.colorScheme.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Text(
                              "₹${ticket.price}",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Gilroy Medium',
                                color: context.colorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Ticket details
                    Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        children: [
                          // Ticket features
                          ..._buildTicketFeatures(context, ticket),
                          
                          // Ticket offers - check if platformOffer is greater than 0
                          if ((ticket.platformOffer != null && ticket.platformOffer! > 0) || 
                              (ticket.isRefundable ?? false) ||
                              (ticket.platformOffer != null))
                            _buildTicketOffers(context, ticket),
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
  
  List<Widget> _buildTicketFeatures(BuildContext context, TicketModel ticket) {
    List<Widget> features = [];
    
    // Age restriction feature
    // if (ticket.ageRestriction != null) {
    //   features.add(
    //     Padding(
    //       padding: EdgeInsets.only(bottom: 8.h),
    //       child: Row(
    //         children: [
    //           Icon(Icons.person_outline, 
    //             size: 16.sp, 
    //             color: context.colorScheme.outline,
    //           ),
    //           SizedBox(width: 8.w),
    //           Text(
    //             "Age: ${ticket.ageRestriction}",
    //             style: TextStyle(
    //               fontSize: 13.sp,
    //               color: context.colorScheme.onSurface.withOpacity(0.8),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   );
    // }
    
    // Availability feature
    // if (ticket.availabilityDays?.isNotEmpty ?? false) {
    //   features.add(
    //     Padding(
    //       padding: EdgeInsets.only(bottom: 8.h),
    //       child: Row(
    //         children: [
    //           Icon(Icons.event_available_outlined, 
    //             size: 16.sp, 
    //             color: context.colorScheme.outline,
    //           ),
    //           SizedBox(width: 8.w),
    //           Expanded(
    //             child: Text(
    //               "Available on: ${ticket.availabilityDays!.join(", ")}",
    //               style: TextStyle(
    //                 fontSize: 13.sp,
    //                 color: context.colorScheme.onSurface.withOpacity(0.8),
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   );
    // }
    
    // Duration feature if this is a multi-day pass
    // if (ticket.validityPeriod != null) {
    //   features.add(
    //     Padding(
    //       padding: EdgeInsets.only(bottom: 8.h),
    //       child: Row(
    //         children: [
    //           Icon(Icons.timelapse_outlined, 
    //             size: 16.sp, 
    //             color: context.colorScheme.outline,
    //           ),
    //           SizedBox(width: 8.w),
    //           Text(
    //             "Valid for: ${ticket.validityPeriod}",
    //             style: TextStyle(
    //               fontSize: 13.sp,
    //               color: context.colorScheme.onSurface.withOpacity(0.8),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   );
    // }
    
    // Add refund information if ticket is refundable
    if (ticket.isRefundable ?? false) {
      features.add(
        Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: Row(
            children: [
              Icon(Icons.assignment_return_outlined, 
                size: 16.sp, 
                color: context.colorScheme.outline,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  ticket.refundPercentage != null
                      ? "Refundable (${ticket.refundPercentage}%)"
                      : "Refundable",
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: context.colorScheme.onSurface.withOpacity(0.8),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
      
      // Add refund duration if available
      if (ticket.refundDuration != null) {
        features.add(
          Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Row(
              children: [
                Icon(Icons.timer_outlined, 
                  size: 16.sp, 
                  color: context.colorScheme.outline,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    "Refund valid for ${_formatRefundDuration(ticket.refundDuration!)}",
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: context.colorScheme.onSurface.withOpacity(0.8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }
    
    return features;
  }
  
  String _formatRefundDuration(int minutes) {
    if (minutes < 60) {
      return "$minutes minutes";
    } else if (minutes < 1440) { // Less than a day
      final hours = minutes ~/ 60;
      return "$hours ${hours == 1 ? 'hour' : 'hours'}";
    } else { // Days
      final days = minutes ~/ 1440;
      return "$days ${days == 1 ? 'day' : 'days'}";
    }
  }
  
  Widget _buildTicketOffers(BuildContext context, TicketModel ticket) {

    if(ticket.platformOffer == null || ticket.platformOffer == 0) {
      return const SizedBox.shrink();
    }
    return Container(
      margin: EdgeInsets.only(top: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: Colors.green.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.local_offer_outlined,
                size: 16.sp,
                color: Colors.green,
              ),
              SizedBox(width: 6.w),
              Text(
                "Special Offers",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          
          // Platform offer
          if (ticket.platformOffer != null && ticket.platformOffer! > 0)
            Padding(
              padding: EdgeInsets.only(bottom: 6.h),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 14.sp,
                    color: Colors.green,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    ticket.platformOfferType?.toLowerCase() == "percentage"
                        ? "${ticket.platformOffer}% off on regular price"
                        : "₹${ticket.platformOffer} off on regular price",
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: context.colorScheme.onSurface.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
          
          // Refund highlight as an offer if applicable
          if ((ticket.isRefundable ?? false) && ticket.refundPercentage != null)
            Padding(
              padding: EdgeInsets.only(bottom: 6.h),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 14.sp,
                    color: Colors.green,
                  ),
                  SizedBox(width: 6.w),
                  Expanded(
                    child: Text(
                      "Get ${ticket.refundPercentage}% refund if cancelled within ${_formatRefundDuration(ticket.refundDuration ?? 0)}",
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: context.colorScheme.onSurface.withOpacity(0.8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          
          // Other offers
          // if (ticket.offers?.isNotEmpty ?? false)
          //   ...ticket.offers!.map((offer) => Padding(
          //     padding: EdgeInsets.only(bottom: 6.h),
          //     child: Row(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Padding(
          //           padding: EdgeInsets.only(top: 2.h),
          //           child: Icon(
          //             Icons.check_circle_outline,
          //             size: 14.sp,
          //             color: Colors.green,
          //           ),
          //         ),
          //         SizedBox(width: 6.w),
          //         Expanded(
          //           child: Text(
          //             offer,
          //             style: TextStyle(
          //               fontSize: 13.sp,
          //               color: context.colorScheme.onSurface.withOpacity(0.8),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   )).toList(),
        ],
      ),
    );
  }
}

