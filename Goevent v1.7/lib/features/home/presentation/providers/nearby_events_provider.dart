import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/event.dart';

final nearbyEventsProvider = StateNotifierProvider<NearbyEventsNotifier, List<Event>>((ref) {
  return NearbyEventsNotifier();
});

class NearbyEventsNotifier extends StateNotifier<List<Event>> {
  NearbyEventsNotifier() : super([
    Event(
      id: 0,
      title: "Women's leadership conference",
      date: "1 ST MAY",
      time: "SAT -2:00 PM",
      location: "36 Guild Street London , UK",
      imageUrl: "assets/image/n1.png",
    ),
    Event(
      id: 1,
      title: "Tech Conference 2024",
      date: "5 MAY",
      time: "WED -3:00 PM",
      location: "123 Tech Street, London, UK",
      imageUrl: "assets/image/n2.png",
    ),
    Event(
      id: 2,
      title: "Music Festival",
      date: "10 MAY",
      time: "MON -6:00 PM",
      location: "Central Park, London, UK",
      imageUrl: "assets/image/n3.png",
    ),
    Event(
      id: 3,
      title: "Food & Wine Festival",
      date: "15 MAY",
      time: "SAT -4:00 PM",
      location: "Food Court, London, UK",
      imageUrl: "assets/image/n4.png",
    ),
    Event(
      id: 4,
      title: "Art Exhibition",
      date: "20 MAY",
      time: "THU -2:00 PM",
      location: "Art Gallery, London, UK",
      imageUrl: "assets/image/n5.png",
    ),
  ]);

  void toggleBookmark(int id) {
    state = state.map((event) {
      if (event.id == id) {
        return event.copyWith(isBookmarked: !event.isBookmarked);
      }
      return event;
    }).toList();
  }

  bool isBookmarked(int id) {
    return state.firstWhere((event) => event.id == id).isBookmarked;
  }
} 