import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'empty_state.dart';

/// Pre-configured empty states for different scenarios in the app
class EmptyStates {
  /// Empty state for when no bookings are found
  static Widget noBookings(BuildContext context) {
    return const EmptyState(
      icon: Icons.calendar_today_outlined,
      title: "No Bookings Yet",
      message: "Your booking history will appear here once you book your first event.",
    );
  }

  /// Empty state for when search results are empty
  static Widget noSearchResults(BuildContext context) {
    return const EmptyState(
      icon: Icons.search_off_rounded,
      title: "No Results Found",
      message: "We couldn't find any matches for your search. Try different keywords.",
    );
  }

  /// Empty state for when notifications are empty
  static Widget noNotifications(BuildContext context) {
    return const EmptyState(
      icon: Icons.notifications_off_outlined,
      title: "No Notifications",
      message: "You don't have any notifications at the moment.",
    );
  }

  /// Empty state for when user needs to login
  static Widget needsLogin(BuildContext context, {required String routeName}) {
    return EmptyState(
      icon: Icons.account_circle_outlined,
      title: "Login Required",
      message: "Please log in to access this feature",
      action: ElevatedButton(
        onPressed: () {
          context.pushNamed(routeName);
        },
        child: const Text('Log In'),
      ),
    );
  }

  /// Empty state for when content is empty and user can create something
  static Widget createContent(BuildContext context, {
    required String title,
    required String message,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    return EmptyState(
      icon: Icons.add_circle_outline,
      title: title,
      message: message,
      action: ElevatedButton(
        onPressed: onPressed,
        child: Text(buttonText),
      ),
    );
  }
} 