import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/booking_model.dart';
import '../../data/providers/booking_provider.dart';
import 'booking_card.dart';
import 'booking_empty_state.dart';

/// A dedicated widget for the bookings list with optimized rebuilds
class BookingList extends ConsumerWidget {
  const BookingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Only watch the filtered bookings provider in this widget
    final filteredBookings = ref.watch(filteredBookingsProvider);
    
    if (filteredBookings.isEmpty) {
      return const BookingEmptyState();
    }
    
    return _BookingListContent(bookings: filteredBookings);
  }
}

/// Inner content widget to avoid rebuilding the ListView when not needed
class _BookingListContent extends StatelessWidget {
  final List<BookingModel> bookings;
  
  const _BookingListContent({
    Key? key, 
    required this.bookings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final booking = bookings[index];
        return BookingCard(
          booking: booking,
          animationDelay: index * 0.15,
        );
      },
    );
  }
}
