// Search Bar Widget
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(
            0.15), // Subtle white opacity that matches the circular patterns
        borderRadius: BorderRadius.circular(12),
        // Removed box shadow to blend with background
      ),
      child: Row(
        children: [
          const Icon(
            Icons.search,
            color: Colors.white,
            size: 20,
          ),
          const SizedBox(width: 8),
          Container(
            width: 1,
            height: 24,
            color: const Color(0x80FFFFFF), // 50% white opacity using hex
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              textInputAction: TextInputAction.search,
              cursorColor: Colors.white,
              style: TextStyle(
                fontFamily: 'Gilroy Medium',
                color: Colors.white,
                fontSize: 15.sp,
              ),
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                hintText: "Search events, shows, movies...",
                hintStyle: TextStyle(
                  fontFamily: 'Gilroy Medium',
                  color: const Color(0xB3FFFFFF), // 70% white opacity using hex
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
