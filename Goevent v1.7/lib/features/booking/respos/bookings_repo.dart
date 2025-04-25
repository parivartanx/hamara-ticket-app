import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/data_source/booking_remote_date_source.dart';
import '../../../../models/booking/booking_model.dart';

class BookingRepo {
  final BookingRemoteDataSource _bookingRemoteDataSource;

  BookingRepo({required BookingRemoteDataSource bookingRemoteDataSource})
      : _bookingRemoteDataSource = bookingRemoteDataSource;

  Future<List<BookingModel>> getBookingsByUserId({required String userId}) async {
    try {
      return await _bookingRemoteDataSource.getBookingsByUserId(userId);
    } catch (e) {
      rethrow;
    }
  }
}

final bookingRepoProvider = Provider<BookingRepo>((ref) {
  final remoteDataSource = ref.watch(bookingRemoteDataSource);
  return BookingRepo(bookingRemoteDataSource: remoteDataSource);
});
