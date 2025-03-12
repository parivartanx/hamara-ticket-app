import 'package:flutter/material.dart';
import 'package:hamaraticket/extensions/media_query_ext.dart';

import '../screens/event_details_screen.dart';

class HeaderActions extends StatelessWidget {

  const HeaderActions({super.key, });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: context.width / 20),
        const BackButton(color: Colors.white),
        SizedBox(width: context.width / 80),
        EventTitle(),
        const Spacer(),
        const SaveButton(),
        const SizedBox(width: 20),
      ],
    );
  }
}