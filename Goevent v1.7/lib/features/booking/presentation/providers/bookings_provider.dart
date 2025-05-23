import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../respos/bookings_repo.dart';
import '../../../../models/booking/booking_model.dart';

final bookingsProvider = FutureProvider.autoDispose.family<List<BookingModel>, String>((ref, userId) async {
  final bookingRepo = ref.watch(bookingRepoProvider);
  try {
    final bookings = await bookingRepo.getBookingsByUserId(userId: userId);
    // log("bookings: $bookings");
    return bookings;
  } catch (error, stackTrace) {
    // Log the error for debugging
    log('Error fetching bookings: $error');
    log(stackTrace.toString());
    
    // Rethrow the error so it can be handled by the UI
    throw Exception('Failed to load bookings: $error');
  }
});
