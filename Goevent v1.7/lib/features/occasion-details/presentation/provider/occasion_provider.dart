import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/models/park/park_model.dart';
import '/models/event/event_model.dart';
import '../../repos/occasion_repo.dart';

/// Provider to fetch park details by ID
final parkByIdProvider = FutureProvider.family<Park, String>((ref, parkId) async {
  final repository = ref.read(occasionRepositoryProvider);
  return await repository.getParkById(parkId);
});

/// Provider to fetch event details by ID
final eventByIdProvider = FutureProvider.family<Event, String>((ref, eventId) async {
  final repository = ref.read(occasionRepositoryProvider);
  return await repository.getEventById(eventId);
});

// parkByIdProvider.listen((previous, next) {
//   log("Park: ${next.name}");
// });

