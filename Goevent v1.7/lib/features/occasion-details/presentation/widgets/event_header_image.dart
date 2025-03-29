import 'package:flutter/material.dart';
import '/extensions/media_query_ext.dart';

class EventHeaderImage extends StatelessWidget {
  final String imageUrl;

  const EventHeaderImage({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      height: context.height / 4,
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            "assets/image/event.png",
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}
