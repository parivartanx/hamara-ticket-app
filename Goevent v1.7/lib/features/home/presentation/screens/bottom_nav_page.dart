import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamaraticket/features/booking/presentation/screens/booking.dart';
import 'package:hamaraticket/features/contact/presentation/screens/contact.dart';
import 'package:hamaraticket/features/home/presentation/providers/bottom_nav_provider.dart';
import 'package:hamaraticket/features/home/presentation/screens/home.dart';
import 'package:hamaraticket/features/home/presentation/widgets/advanced_bottom_navigation.dart';
import 'package:hamaraticket/features/profile/presentation/screens/profile.dart';


class BottomNavPage extends ConsumerWidget {
  static const String routePath = '/bottom_nav';
  static const String routeName = 'Bottom Navigation';
  const BottomNavPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedItem = ref.watch(bottomNavProvider);
    return Scaffold(
      body: _buildPage(selectedItem),
      bottomNavigationBar: const AdvancedBottomNavigation(),
      // bottomNavigationBar:NavigationBar(
      //   selectedIndex: selectedItem.index,
      //   onDestinationSelected: (index) {
      //     ref.read(bottomNavProvider.notifier).setSelectedItem(
      //           BottomNavItem.values[index],
      //         );
      //   },
      //   destinations: const [
      //     NavigationDestination(
      //       icon: Icon(Icons.home_outlined),
      //       selectedIcon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     NavigationDestination(
      //       icon: Icon(Icons.calendar_today_outlined),
      //       selectedIcon: Icon(Icons.calendar_today),
      //       label: 'Bookings',
            
      //     ),
      //     NavigationDestination(
      //       icon: Icon(Icons.support_agent_outlined),
      //       selectedIcon: Icon(Icons.support_agent),
      //       label: 'Support',
      //     ),
      //     NavigationDestination(
      //       icon: Icon(Icons.person_outline),
      //       selectedIcon: Icon(Icons.person),
      //       label: 'Profile',
      //     ),
      //   ],
      // ),
    );
  }
  
  Widget _buildPage(BottomNavItem selectedItem) {
    switch (selectedItem) {
      case BottomNavItem.home:
        return const Home();
      case BottomNavItem.bookings:
        return const Booking();
      case BottomNavItem.support:
        return const Contact();
      case BottomNavItem.profile:
        return const Profile();
    }
  }
}