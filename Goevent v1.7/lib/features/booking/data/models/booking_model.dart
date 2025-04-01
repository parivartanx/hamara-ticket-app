// Booking model to represent booking data with category support
class BookingModel {
  final String eventName;
  final String eventId;
  final DateTime eventDate;
  final String ticketType;
  final int quantity;
  final bool isUsed;
  final BookingCategory category;

  BookingModel({
    required this.eventName,
    required this.eventId,
    required this.eventDate,
    required this.ticketType,
    required this.quantity,
    required this.isUsed,
    required this.category,
  });
}

// Enum to categorize different types of bookings
enum BookingCategory {
  event,
  park,
  waterPark,
}

// Extension to get user-friendly name for the category
extension BookingCategoryExt on BookingCategory {
  String get displayName {
    switch (this) {
      case BookingCategory.event:
        return 'Event';
      case BookingCategory.park:
        return 'Park';
      case BookingCategory.waterPark:
        return 'Water Park';
    }
  }
}
