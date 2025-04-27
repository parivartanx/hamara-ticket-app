
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/utils/dio_client.dart';
import '/utils/endPoints.dart';

import '../../../../models/booking/booking_model.dart';

class BookingRemoteDataSource {
  final DioClient _dioClient;

  BookingRemoteDataSource({required DioClient dioClient}) : _dioClient = dioClient;

  Future<List<BookingModel>> getBookingsByUserId(String userId) async {
    try {
      final response = await _dioClient.get(
        url: "${EndPoints.getBookingsByUserId}/$userId/bookings",
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data["bookings"];
        // log("response of bookings: $data");
        final  bookings = data.map((e) => BookingModel.fromJson(e)).toList();
        // log("bookings after converted : $bookings");
        return bookings;
      } else {
        throw Exception(response.data);
      }
    } catch (e) {
      // print("Error in booking remote data source: $e");
      rethrow;
    }
  }
}

final bookingRemoteDataSource = Provider<BookingRemoteDataSource>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return BookingRemoteDataSource(dioClient: dioClient);
});
