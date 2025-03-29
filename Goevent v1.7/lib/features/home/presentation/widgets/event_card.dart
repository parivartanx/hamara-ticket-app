import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/extensions/media_query_ext.dart';
import '/models/event/event_model.dart';


class EventCard extends ConsumerWidget {
  final Event event;

  const EventCard({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EventImage(
                      img: event.imageUrls.first,
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
                    SizedBox(height: context.height * .01),
                    LocationWidget(location: event.address),
                  ],
                ),
                DateOverlay(
                  date: event.startDate,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EventImage extends StatelessWidget {
  final String img;

  const EventImage({    
    Key? key,
    required this.img,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height * .15,
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
              child: Image.network(
                img,
                fit: BoxFit.cover,
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
        Icon(Icons.location_on, color: Colors.grey, size: 12.sp),
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
  final String date;

  const DateOverlay({
    Key? key,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final parsedDate = DateTime.parse(date);
    
    return Column(
      children: [
        SizedBox(height: context.height * .12),
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
                    "${parsedDate.day} ",
                    style: TextStyle(
                      color: const Color(0xffF0635A),
                      fontSize: 13.sp,
                      fontFamily: 'Gilroy ExtraBold',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    _getMonth(parsedDate.month),
                    style: TextStyle(
                      color: const Color(0xffF0635A),
                      fontSize: 10.sp,
                      fontFamily: 'Gilroy Medium',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: context.width * .02),
          ],
        ),
      ],
    );
  }

  String _getMonth(int month) {
    const months = [
      'JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN',
      'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'
    ];
    return months[month - 1];
  }
}
