import 'package:flutter/material.dart';
import 'package:hamaraticket/extensions/media_query_ext.dart';
import '/models/event/event_model.dart';

import '../screens/event_details_screen.dart';

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
        const SaveButton(),
        const SizedBox(width: 20),
      ],
    );
  }
}