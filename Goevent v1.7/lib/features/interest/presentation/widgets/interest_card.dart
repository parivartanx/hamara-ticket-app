
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamaraticket/extensions/media_query_ext.dart';

class InterestCard extends StatelessWidget {
  final String name;
  final bool isSelected;
  final String primaryImage;
  final String secondaryImage;
  final VoidCallback onTap;

  const InterestCard({
    Key? key,
    required this.name,
    required this.isSelected,
    required this.primaryImage,
    required this.secondaryImage,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(
                width: 2,
                color: isSelected 
                  ? context.colorScheme.primary 
                  : Colors.transparent,
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  primaryImage,
                  height: context.height / 6,
                ),
                Center(
                  child: Image.asset(
                    secondaryImage,
                    height: context.height / 10,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            name,
            style: TextStyle(
              color: context.colorScheme.onSurface,
              fontSize: 12.sp,
              fontFamily: 'Gilroy Medium',
            ),
          ),
        ],
      ),
    );
  }
}