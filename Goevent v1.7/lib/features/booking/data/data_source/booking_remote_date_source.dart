import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamaraticket/utils/dio_client.dart';
import 'package:hamaraticket/utils/endPoints.dart';

import '../../../../models/booking/booking_model.dart';

class BookingRemoteDataSource {
  final DioClient _dioClient;

  BookingRemoteDataSource({required DioClient dioClient}) : _dioClient = dioClient;

  Future<List<BookingModel>> getBookingsByUserId(String userId) async {
    try {
      final response = await _dioClient.get(
        url: EndPoints.getBookingsByUserId,
      );
      if (response.statusCode == 200) {
        final data = response.data;
        log("response of bookings: $data");
        return response.data.map((e) => BookingModel.fromJson(e)).toList();
      } else {
        throw Exception(response.data);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}

final bookingRemoteDataSource = Provider<BookingRemoteDataSource>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return BookingRemoteDataSource(dioClient: dioClient);
});
