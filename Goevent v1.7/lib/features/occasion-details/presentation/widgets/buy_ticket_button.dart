import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import '/extensions/media_query_ext.dart';
import '../../../buy_ticket/presentation/screens/buy_ticket.dart';

class BuyTicketButton extends StatelessWidget {
  final String occasionType;
  final String occasionId;
  final String occasionName;
  final String buttonText;

  const BuyTicketButton({
    super.key,
    required this.occasionType,
    required this.occasionId,
    required this.occasionName,
    this.buttonText = "Book Now",
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: SizedBox(
        height: 45.h,
        width: 410.w,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                child: BuyTicketS(
                  occasionType: occasionType,
                  occasionId: occasionId,
                  occasionName: occasionName,
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: context.colorScheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.event_available, size: 16, color: Colors.white),
              SizedBox(width: 8.w),
              Text(
                buttonText,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}