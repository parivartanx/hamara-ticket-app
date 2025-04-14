import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/extensions/media_query_ext.dart';

class OccasionStatusCard extends StatelessWidget {
  final String status;
  final int maxCapacity;
  final bool isOpen;

  const OccasionStatusCard({
    super.key,
    required this.status,
    required this.maxCapacity,
    this.isOpen = true,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    String statusText;

    // For events
    switch (status.toLowerCase()) {
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
        // For parks
        statusColor = isOpen ? Colors.green : Colors.red;
        statusText = isOpen ? 'Open Now' : 'Closed';
    }

    return Container(
      width: context.width * 0.7,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(15),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
          SizedBox(height: context.height * 0.04, child: const VerticalDivider()),
          Row(
            children: [
              Icon(Icons.people, size: 16.sp, color: Colors.grey),
              SizedBox(width: 4.w),
              Text(
                "$maxCapacity",
                style: TextStyle(
                  fontSize: 14.sp,
                  color: context.colorScheme.outline,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
} 