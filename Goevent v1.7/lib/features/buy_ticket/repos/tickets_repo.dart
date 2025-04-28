import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/ticket/order_ticket_model.dart';
import '/features/buy_ticket/data/data_source/ticket_remote_data_source.dart';
import '/models/ticket/ticket_model.dart';

class TicketsRepo {
  final TicketRemoteDataSource _ticketRemoteDataSource;

  TicketsRepo({required TicketRemoteDataSource ticketRemoteDataSource})
      : _ticketRemoteDataSource = ticketRemoteDataSource;

  Future<List<TicketModel>> getTickets({
    String? eventId,
    String? parkId,
    required String date,
  }) async {
    try {
      final tickets = await _ticketRemoteDataSource.getTickets(
        eventId: eventId,
        parkId: parkId,
        date: date,
      );
      return tickets;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<TicketOrderResponse> createTicketOrder(OrderTicket orderTicket) async {
    try {
      final response = await _ticketRemoteDataSource.createTicketOrder(orderTicket);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

final ticketsRepoProvider = Provider<TicketsRepo>((ref) {
  return TicketsRepo(
    ticketRemoteDataSource: ref.read(ticketRemoteDataSourceProvider),
  );
});
