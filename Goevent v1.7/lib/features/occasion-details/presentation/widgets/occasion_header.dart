import 'package:flutter/material.dart';
import '/extensions/media_query_ext.dart';
import 'header_actions.dart';
import 'occasion_status_card.dart';

class OccasionHeader extends StatelessWidget {
  final String title;
  final List<String> imageUrls;
  final String status;
  final int maxCapacity;
  final bool isOpen;
  final bool showSaveButton;
  final bool useCarousel;
  final Widget? extraContent;
   
  const OccasionHeader({
    super.key,
    required this.title,
    required this.imageUrls,
    required this.maxCapacity,
    this.status = '',
    this.isOpen = true,
    this.showSaveButton = false,
    this.useCarousel = false,
    this.extraContent,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Header Image
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Image.network(
            imageUrls.first,
            fit: BoxFit.cover,
          ),
        ),
        // Gradient Overlay
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black87],
              ),
            ),
          ),
        ),
        // Header Content
        Column(
          children: [
            SizedBox(height: context.height / 20),
            HeaderActions(
              title: title,
              showSaveButton: showSaveButton,
            ),
            SizedBox(height: context.height / 8.5),
            if (extraContent != null) extraContent!,
            OccasionStatusCard(
              status: status,
              maxCapacity: maxCapacity,
              isOpen: isOpen,
            ),
          ],
        ),
      ],
    );
  }
} 