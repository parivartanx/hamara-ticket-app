import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../extensions/media_query_ext.dart';

class TicketTypeListItem extends StatelessWidget {
  final String ticketType;
  final int quantity;
  final Color Function() getCategoryColor;

  const TicketTypeListItem({
    Key? key,
    required this.ticketType,
    required this.quantity,
    required this.getCategoryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 4.h, bottom: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.local_activity_outlined,
                size: 14.sp,
                color: getCategoryColor(),
              ),
              SizedBox(width: 6.w),
              Padding(
                padding: EdgeInsets.only(top: 2.h),
                child: Text(
                  ticketType,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: context.colorScheme.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: getCategoryColor().withAlpha(20),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(
              'Qty: $quantity',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: getCategoryColor(),
              ),
            ),
          ),
        ],
      ),
    );
  }
} 