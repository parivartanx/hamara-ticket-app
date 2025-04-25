enum OccasionType {
  park,
  waterpark,
  event;

  String get displayName {
    switch (this) {
      case OccasionType.park:
        return 'Park';
      case OccasionType.waterpark:
        return 'Waterpark';
      case OccasionType.event:
        return 'Event';
    }
  }

  static OccasionType fromString(String? type) {
    if (type == null) return OccasionType.park;
    switch (type.toLowerCase()) {
      case 'waterpark':
        return OccasionType.waterpark;
      case 'event':
        return OccasionType.event;
      default:
        return OccasionType.park;
    }
  }

  bool get requiresDateSelection => this != OccasionType.event;
} 