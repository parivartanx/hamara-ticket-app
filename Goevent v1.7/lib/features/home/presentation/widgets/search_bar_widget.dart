// Search Bar Widget
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamaraticket/extensions/media_query_ext.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: context.colorScheme.secondaryContainer.withAlpha(120),
        borderRadius: BorderRadius.circular(12),
        // Removed box shadow to blend with background
      ),
      child: Row(
        children: [
           Icon(
            Icons.search,
            color: context.colorScheme.primary,
            size: 20,
          ),
          const SizedBox(width: 8),
          Container(
            width: 1,
            height: 24,
            color: context.colorScheme.outline // 50% white opacity using hex
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              textInputAction: TextInputAction.search,
          
              style: TextStyle(
                fontFamily: 'Gilroy Medium',
                
                fontSize: 15.sp,
              ),
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                hintText: "Search events, shows, movies...",
                hintStyle: TextStyle(
                  fontFamily: 'Gilroy Medium',
                  color: context.colorScheme.outline, // 70% white opacity using hex
                  fontSize: 15.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
