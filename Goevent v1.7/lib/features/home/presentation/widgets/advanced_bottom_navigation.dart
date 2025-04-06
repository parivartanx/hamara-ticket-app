import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/extensions/media_query_ext.dart';
import 'package:go_router/go_router.dart';
import '/features/booking/presentation/screens/booking.dart';
import '/features/profile/presentation/screens/profile.dart';
import '/features/home/presentation/screens/home.dart';
import '/features/contact/presentation/screens/contact.dart';

// Provider to track the current navigation index
final bottomNavigationIndexProvider = StateProvider<int>((ref) => 0);

class AdvancedBottomNavigation extends ConsumerWidget {
  const AdvancedBottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavigationIndexProvider);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          ref.read(bottomNavigationIndexProvider.notifier).state = index;

          // Navigate based on index using the same route names as sidebar
          switch (index) {
            case 0:
              context.goNamed(Home.routeName);
              break;
            case 1:
              context.goNamed(Booking.routeName);
              break;
            case 2:
              context.goNamed(Contact.routeName);
              break;
            case 3:
              context.goNamed(Profile.routeName);
              break;
          }
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: context.colorScheme.primary,
        unselectedItemColor: Colors.grey.shade400,
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
          if (badge != null)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: EdgeInsets.all(4.r),
                decoration: BoxDecoration(
                  color: context.colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                constraints: BoxConstraints(
                  minWidth: 16.r,
                  minHeight: 16.r,
                ),
                child: Text(
                  badge,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
      label: label,
    );
  }
}
