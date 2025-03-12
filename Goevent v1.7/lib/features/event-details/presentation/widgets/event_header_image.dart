import 'package:flutter/material.dart';
import 'package:hamaraticket/extensions/media_query_ext.dart';

class EventHeaderImage extends StatelessWidget {

  const EventHeaderImage({super.key,});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: context.width,
      height: context.height / 4,
      child: Image.asset(
        "assets/image/event.png",
        fit: BoxFit.cover,
      ),
    );
  }
}
