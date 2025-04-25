import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/features/buy_ticket/repos/tickets_repo.dart';
import '/models/ticket/ticket_model.dart';

final ticketsProvider = FutureProvider.family<List<TicketModel>, ({String date, String? eventId, String? parkId})>((ref, params) async {
  final ticketsRepo = ref.read(ticketsRepoProvider);
  return ticketsRepo.getTickets(
    date: params.date,
    eventId: params.eventId,
    parkId: params.parkId,
  );
});
