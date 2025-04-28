import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/features/home/presentation/providers/bottom_nav_provider.dart';
import '/extensions/media_query_ext.dart';



class AdvancedBottomNavigation extends ConsumerWidget {
  const AdvancedBottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavProvider).index;
    return SizedBox(
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
            ref.read(bottomNavProvider.notifier).setSelectedItem(
                BottomNavItem.values[index],
              );
          
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: context.colorScheme.surface,
        selectedItemColor: context.colorScheme.primary,
        unselectedItemColor: context.colorScheme.outline,
        selectedLabelStyle: TextStyle(
          fontFamily: 'Gilroy',
          fontWeight: FontWeight.w600,
          fontSize: 12.sp,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: 'Gilroy',
          fontWeight: FontWeight.w500,
          fontSize: 12.sp,
        ),
        elevation: 0,
        items: [
          _buildNavItem(
            context: context,
            icon: Icons.home_rounded,
            label: 'Home',
            isSelected: currentIndex == 0,
          ),
          _buildNavItem(
            context: context,
            icon: Icons.calendar_today_rounded,
            label: 'Bookings',
            isSelected: currentIndex == 1,
            badge: '3', // Example badge
          ),
          _buildNavItem(
            context: context,
            icon: Icons.support_agent_rounded,
            label: 'Support',
            isSelected: currentIndex == 2,
          ),
          _buildNavItem(
            context: context,
            icon: Icons.person_rounded,
            label: 'Profile',
            isSelected: currentIndex == 3,
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required bool isSelected,
    String? badge,
  }) {
    return BottomNavigationBarItem(
      icon: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: isSelected
                  ? context.colorScheme.primary.withOpacity(0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              icon,
              size: 24.r,
            ),
          ),
          
         ],
      ),
      label: label,
    );
  }
}
