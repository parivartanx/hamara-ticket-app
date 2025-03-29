// lib/features/home/presentation/providers/nearby_events_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/features/home/data/event_data.dart';
import '/features/home/data/park_data.dart';

enum OccasionType { events, waterPark, park }

class NearbyEventsState {
  final OccasionType selectedType;
  final List<dynamic> filteredItems;

  NearbyEventsState({
    this.selectedType = OccasionType.events,
    this.filteredItems = const [],
  });

  NearbyEventsState copyWith({
    OccasionType? selectedType,
    List<dynamic>? filteredItems,
  }) {
    return NearbyEventsState(
      selectedType: selectedType ?? this.selectedType,
      filteredItems: filteredItems ?? this.filteredItems,
    );
  }
}

final nearbyEventsProvider = StateProvider<NearbyEventsState>((ref) {
  // Initialize with events data
  return NearbyEventsState(
    selectedType: OccasionType.events,
    filteredItems: events,
  );
});

List<dynamic> getFilteredItems(OccasionType type) {
  switch (type) {
    case OccasionType.events:
      return events;
    case OccasionType.waterPark:
      return parks.where((park) => park.type == "Water Park").toList();
    case OccasionType.park:
      return parks.where((park) => park.type == "Park").toList();
  }
}