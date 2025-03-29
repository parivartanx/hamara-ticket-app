import 'package:flutter/material.dart';
import 'package:hamaraticket/extensions/media_query_ext.dart';
import '/models/event/event_model.dart';
import 'attendees_list.dart';
import 'event_header_image.dart';
import 'header_actions.dart';

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
