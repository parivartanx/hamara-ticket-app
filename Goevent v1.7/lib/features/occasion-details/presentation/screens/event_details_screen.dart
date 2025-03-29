import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/event_header_image.dart';
import '/extensions/media_query_ext.dart';
import '../../../home/ticket.dart';
import '/providers/color_provider.dart';
import 'package:page_transition/page_transition.dart';
import '/models/event/event_model.dart';
import 'package:intl/intl.dart';
import '../widgets/attendees_list.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shimmer/shimmer.dart';

class EventDetailsScreen extends ConsumerStatefulWidget {
  final Event event;

  const EventDetailsScreen({
    super.key,
    required this.event,
  });

  @override
  ConsumerState<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends ConsumerState<EventDetailsScreen> {
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
    final event = widget.event;
    
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      floatingActionButton: const BuyTicketButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Column(
          children: [
            EventHeader(event: event),
            SizedBox(height: context.height / 30),
            EventBody(event: event),
          ],
        ),
      ),
    );
  }
}

class BuyTicketButton extends StatelessWidget {
  const BuyTicketButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: SizedBox(
        height: 45.h,
        width: 410.w,
        child: ElevatedButton(
          onPressed: () => Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: const Ticket(),
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: context.colorScheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.event_available, size: 16, color: Colors.white),
              SizedBox(width: 8),
              Text(
                "Buy Ticket",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EventHeader extends StatelessWidget {
  final Event event;

  const EventHeader({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        EventHeaderImage(imageUrl: event.imageUrls.first),
        Column(
          children: [
            SizedBox(height: context.height / 20),
            HeaderActions(event: event),
            SizedBox(height: context.height / 8.5),
            AttendeesList(event: event),
          ],
        ),
      ],
    );
  }
}

class HeaderActions extends StatelessWidget {
  final Event event;

  const HeaderActions({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: context.width / 20),
        const BackButton(color: Colors.white),
        SizedBox(width: context.width / 80),
        EventTitle(event: event),
        const Spacer(),
        SaveButton(),
        const SizedBox(width: 20),
      ],
    );
  }
}

class EventTitle extends StatelessWidget {
  final Event event;

  const EventTitle({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      event.name,
      style: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w900,
        fontFamily: 'Gilroy Medium',
        color: Colors.white,
      ),
    );
  }
}

class SaveButton extends StatelessWidget {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height / 25,
      width: context.width / 12,
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(200),
        borderRadius: BorderRadius.circular(5),
      ),
      child: const Padding(
        padding: EdgeInsets.all(7),
        child: Icon(Icons.bookmark_border, color: Colors.white),
      ),
    );
  }
}

class EventBody extends StatelessWidget {
  final Event event;

  const EventBody({ 
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EventTitleSection(event: event),
        SizedBox(height: context.height / 40),
        ImageGallery(event: event),
        SizedBox(height: context.height / 40),
        EventStatusCard(event: event),
        SizedBox(height: context.height / 40),
        EventInfoCard(
          title: "Date & Time",
          subtitle: "${_formatDate(event.startDate)} - ${_formatDate(event.endDate)}\n${event.startTime} - ${event.endTime}",
          colorScheme: context.colorScheme,
        ),
        SizedBox(height: context.height / 40),
        EventInfoCard(
          title: "Location",
          subtitle: "${event.location}, ${event.city}\n${event.address}",
          colorScheme: context.colorScheme,
        ),
        SizedBox(height: context.height / 40),
        if (event.description != null && event.description!.isNotEmpty)
          EventInfoCard(
            title: "Description",
            subtitle: event.description!,
            colorScheme: context.colorScheme,
          ),
        SizedBox(height: context.height / 40),
        OrganizerCard(event: event),
        SizedBox(height: context.height / 40),
        AboutEventSection(event: event),
      ],
    );
  }

  String _formatDate(String date) {
    return DateFormat('d MMM, yyyy').format(DateTime.parse(date));
  }

  
}

class ImageGallery extends StatelessWidget {
  final Event event;

  const ImageGallery({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Event Gallery",
            style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w700,
              fontFamily: 'Gilroy Medium',
              color: context.colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 16.h),
          CarouselSlider(
            options: CarouselOptions(
              height: 200.h,
              viewportFraction: 0.8,
              enlargeCenterPage: true,
            ),
            items: event.imageUrls.map((url) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        url,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class EventStatusCard extends StatelessWidget {
  final Event event;

  const EventStatusCard({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    String statusText;
    
    switch(event.status.toLowerCase()) {
      case 'scheduled':
        statusColor = Colors.blue;
        statusText = 'Upcoming';
        break;
      case 'ongoing':
        statusColor = Colors.green;
        statusText = 'Live Now';
        break;
      case 'completed':
        statusColor = Colors.grey;
        statusText = 'Completed';
        break;
      case 'cancelled':
        statusColor = Colors.red;
        statusText = 'Cancelled';
        break;
      default:
        statusColor = Colors.grey;
        statusText = 'Unknown';
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                statusText,
                style: TextStyle(
                  color: statusColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Event Capacity",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(Icons.people, size: 16.sp, color: Colors.grey),
                      SizedBox(width: 4.w),
                      Text(
                        "${event.maxCapacity} people",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey,
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

class EventInfoCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final ColorScheme colorScheme;

  const EventInfoCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                fontFamily: 'Gilroy Medium',
                color: colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                fontFamily: 'Gilroy Medium',
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EventTitleSection extends StatelessWidget {
  final Event event;

  const EventTitleSection({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            event.name,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              fontFamily: 'Gilroy Medium',
              color: context.colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 8.h),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: event.tags.map((tag) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: context.colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  tag,
                  style: TextStyle(
                    color: context.colorScheme.primary,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(Icons.location_on, size: 16.sp, color: Colors.grey),
              SizedBox(width: 4.w),
              Text(
                event.location,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: 'Gilroy Medium',
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OrganizerCard extends StatelessWidget {
  final Event event;

  const OrganizerCard({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 60.h,
              width: 60.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(event.imageUrls.first),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Organized by ${event.name}",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Gilroy Medium',
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "${event.tags.join(', ')}",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Gilroy Medium',
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16.w),
            Container(
              height: 35.h,
              width: 100.w,
              decoration: BoxDecoration(
                color: context.colorScheme.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  "Follow Organizer",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Gilroy Medium',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AboutEventSection extends StatelessWidget {
  final Event event;

  const AboutEventSection({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "About Event",
            style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w700,
              fontFamily: 'Gilroy Medium',
              color: context.colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            event.description ?? "No description available",
            style: TextStyle(
              fontSize: 14.sp,
              fontFamily: 'Gilroy Medium',
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
