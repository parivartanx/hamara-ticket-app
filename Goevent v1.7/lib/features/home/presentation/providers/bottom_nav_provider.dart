import 'package:flutter_riverpod/flutter_riverpod.dart';

enum BottomNavItem {
  home,
  bookings,
  support,
  profile,
}

class BottomNavNotifier extends StateNotifier<BottomNavItem> {
  BottomNavNotifier() : super(BottomNavItem.home);

  void setSelectedItem(BottomNavItem item) {
    state = item;
  }
}

final bottomNavProvider = StateNotifierProvider<BottomNavNotifier, BottomNavItem>((ref) {
  return BottomNavNotifier();
});