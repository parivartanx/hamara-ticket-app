import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/extensions/media_query_ext.dart';
import '/providers/color_provider.dart';
import '/models/event/event_model.dart';
import '../widgets/occasion_info_card.dart';
import '../widgets/occasion_gallery.dart';
import '../widgets/occasion_title_section.dart';
import '../widgets/buy_ticket_button.dart';
import '../widgets/occasion_header.dart';
import 'package:intl/intl.dart';

class EventDetailsScreen extends ConsumerStatefulWidget {
  static const routePath = '/event-details';
  static const routeName = 'event-details';
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
      floatingActionButton: BuyTicketButton(
        occasionType: 'Event',
        occasionId: '1',
        occasionName: event.name,
        buttonText: "Buy Ticket",
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Column(
          children: [
            OccasionHeader(
              title: event.name,
              imageUrls: event.imageUrls,
              status: event.status,
              maxCapacity: event.maxCapacity,
              showSaveButton: true,
            ),
            SizedBox(height: context.height / 30),
            EventBody(event: event),
            SizedBox(height: context.height * 0.1),
          ],
        ),
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
        OccasionTitleSection(
          name: event.name,
          address: event.address,
          tags: event.tags,
        ),
        SizedBox(height: context.height * 0.01),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Wrap(
            children: [
              OccasionInfoCard(
                title: "Date",
                subtitle: "${_formatDate(event.startDate)} - ${_formatDate(event.endDate)}",
                icon: Icons.calendar_month,
                width: context.width * 0.5,
              ),
              OccasionInfoCard(
                title: "Time",
                subtitle: "${event.startTime} - ${event.endTime}",
                icon: Icons.timelapse,
                width: context.width * 0.4,
              ),
            ],
          ),
        ),
        SizedBox(height: context.height / 40),
        OccasionGallery(imageUrls: event.imageUrls),
        SizedBox(height: context.height / 40),
        if (event.description != null && event.description!.isNotEmpty)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: OccasionInfoCard(
              title: "Description",
              subtitle: event.description!,
              width: context.width,
            ),
          ),
        SizedBox(height: context.height / 40),
        OrganizerCard(event: event),
      ],
    );
  }

  String _formatDate(String date) {
    return DateFormat('d MMM, yyyy').format(DateTime.parse(date));
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
                  "Follow",
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


