import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../respos/bookings_repo.dart';
import '../../../../models/booking/booking_model.dart';

final bookingsProvider = FutureProvider.autoDispose.family<List<BookingModel>, String>((ref, userId) async {
  final bookingRepo = ref.watch(bookingRepoProvider);
  return await bookingRepo.getBookingsByUserId(userId: userId);
});
