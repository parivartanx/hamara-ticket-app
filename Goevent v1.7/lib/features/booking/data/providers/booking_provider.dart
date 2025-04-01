import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/booking_model.dart';

// Enum to filter bookings by time
enum BookingTimeFilter {
  all,
  upcoming,
  past
}

// Extension to get display name for the filter
extension BookingTimeFilterExt on BookingTimeFilter {
  String get displayName {
    switch (this) {
      case BookingTimeFilter.all:
        return 'All';
      case BookingTimeFilter.upcoming:
        return 'Upcoming';
      case BookingTimeFilter.past:
        return 'Past';
    }
  }
}

// Provider to store the currently selected filter
final selectedTimeFilterProvider = StateProvider<BookingTimeFilter>((ref) {
  return BookingTimeFilter.all; // Default filter
});

// Provider to fetch all bookings (mock data for now)
final bookingsProvider = Provider<List<BookingModel>>((ref) {
  // Mock data - would be replaced with actual API calls
  return [
    // Events
    BookingModel(
      eventName: 'EVENT - LAGOON E-GULAAL',
      eventId: 'c46cd3ad-1ff2-4cfb-b320-fe5dc220e623',
      eventDate: DateTime(2025, 3, 5, 20, 0),
      ticketType: 'Entry-Ticket',
      quantity: 1,
      isUsed: true,
      category: BookingCategory.event,
    ),
    BookingModel(
      eventName: 'EVENT - LAGOON E-GULAAL',
      eventId: 'b558bba6-3234-47c4-97db-0b443241a126',
      eventDate: DateTime(2025, 3, 1, 9, 59),
      ticketType: 'Entry-Ticket',
      quantity: 1,
      isUsed: true,
      category: BookingCategory.event,
    ),
    BookingModel(
      eventName: 'MUSIC FESTIVAL 2025',
      eventId: 'a47de3c5-8912-4e7b-af23-0d9a7654b321',
      eventDate: DateTime(2025, 4, 15, 18, 30),
      ticketType: 'VIP Pass',
      quantity: 2,
      isUsed: false,
      category: BookingCategory.event,
    ),
    
    // Parks
    BookingModel(
      eventName: 'CITY PARK ADVENTURE',
      eventId: 'd59eba87-f834-42c1-81aa-c3b445d78fa9',
      eventDate: DateTime(2025, 4, 10, 10, 0),
      ticketType: 'Day Pass',
      quantity: 2,
      isUsed: false,
      category: BookingCategory.park,
    ),
    BookingModel(
      eventName: 'NATIONAL HERITAGE PARK',
      eventId: 'e75cd4b9-2a87-48d2-b5ec-f912a631a045',
      eventDate: DateTime(2025, 2, 20, 9, 0),
      ticketType: 'Family Pass',
      quantity: 4,
      isUsed: true,
      category: BookingCategory.park,
    ),
    
    // Water Parks
    BookingModel(
      eventName: 'SPLASH ZONE WATERPARK',
      eventId: 'f861cd3e-9a54-48d9-b3f7-a129d752e089',
      eventDate: DateTime(2025, 5, 12, 11, 30),
      ticketType: 'Full Day Pass',
      quantity: 3,
      isUsed: false,
      category: BookingCategory.waterPark,
    ),
    BookingModel(
      eventName: 'AQUA ADVENTURE PARK',
      eventId: 'g982ab7c-6d23-47e5-9f61-b843c532e167',
      eventDate: DateTime(2025, 4, 25, 12, 0),
      ticketType: 'Premium Pass',
      quantity: 2,
      isUsed: false,
      category: BookingCategory.waterPark,
    ),
  ];
});

// Provider to filter bookings by time (upcoming or past)
final filteredBookingsProvider = Provider<List<BookingModel>>((ref) {
  final allBookings = ref.watch(bookingsProvider);
  final selectedFilter = ref.watch(selectedTimeFilterProvider);
  final now = DateTime.now();
  
  switch (selectedFilter) {
    case BookingTimeFilter.all:
      return allBookings;
    case BookingTimeFilter.upcoming:
      return allBookings.where((booking) => booking.eventDate.isAfter(now)).toList();
    case BookingTimeFilter.past:
      return allBookings.where((booking) => booking.eventDate.isBefore(now)).toList();
  }
});
