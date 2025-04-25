import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/models/ticket/ticket_model.dart';
import '/utils/dio_client.dart';
import '/utils/endPoints.dart';

class TicketRemoteDataSource {
  final DioClient _dioClient;

  TicketRemoteDataSource({required DioClient dioClient}) : _dioClient = dioClient;


  Future<List<TicketModel>> getTickets({ String? eventId,String? parkId ,required String date}) async {
    try {
      final response = await _dioClient.get(
        url: "${EndPoints.getTickets}/$date/${parkId ?? 'null'}/${eventId ?? 'null'}",
      );
      if (response.statusCode == 200) {
        log("response.data of tickets of $eventId and $parkId and $date: ${response.data['tickets']}");
        return (response.data['tickets'] as List).map((e) => TicketModel.fromJson(e)).toList();
      } else {
        throw Exception(response.data['message'] ?? "Failed to fetch tickets");
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}

final ticketRemoteDataSourceProvider = Provider<TicketRemoteDataSource>((ref) {
  return TicketRemoteDataSource(
    dioClient: ref.read(dioClientProvider),
  );
});
