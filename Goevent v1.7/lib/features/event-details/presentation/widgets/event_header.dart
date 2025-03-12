import 'package:flutter/material.dart';
import 'package:hamaraticket/extensions/media_query_ext.dart';
import 'attendees_list.dart';
import 'event_header_image.dart';
import 'header_actions.dart';

class EventHeader extends StatelessWidget { 
  const EventHeader({
    super.key,
    
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const EventHeaderImage(),
        Column(
          children: [
            SizedBox(height: context.height / 20),
            const HeaderActions(),
            SizedBox(height: context.height / 8.5),
            const AttendeesList(),
          ],
        ),
      ],
    );
  }
}
