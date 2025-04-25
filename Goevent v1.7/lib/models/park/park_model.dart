import 'package:json_annotation/json_annotation.dart';
import '../ticket/ticket_model.dart';

part 'park_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Park {
  final String id;
  final String name;
  final String city;
  final String address;
  final double latitude;
  final double longitude;
  final List<String> imageUrls;
  final List<String> tags;
  final int maxCapacity;
  final List<Attraction> attractions;
  final List<TicketModel> tickets;

  // Optional fields (not returned by backend)
  final String? type;
  final String? adminId;
  final String? status;
  final bool? isDeleted;
  final List<String>? videoUrls;
  final List<OperatingHour>? operatingHours;
  final List<DynamicPricing>? dynamicPricing;
  final List<PeakHourPricing>? peakHourPricing;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Park({
    required this.id,
    required this.name,
    required this.city,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.imageUrls,
    required this.tags,
    required this.maxCapacity,
    required this.attractions,
    required this.tickets,
    this.type,
    this.adminId,
    this.status,
    this.isDeleted,
    this.videoUrls,
    this.operatingHours,
    this.dynamicPricing,
    this.peakHourPricing,
    this.createdAt,
    this.updatedAt,
  });

  factory Park.fromJson(Map<String, dynamic> json) => _$ParkFromJson(json);
  Map<String, dynamic> toJson() => _$ParkToJson(this);
}

@JsonSerializable()
class Attraction {
  final String id;
  final String name;
  final String type;
  final int? heightRestriction;
  final String status;

  Attraction({
    required this.id,
    required this.name,
    required this.type,
    this.heightRestriction,
    required this.status,
  });

  factory Attraction.fromJson(Map<String, dynamic> json) => _$AttractionFromJson(json);
  Map<String, dynamic> toJson() => _$AttractionToJson(this);
}

@JsonSerializable()
class OperatingHour {
  final String id;
  final String day;
  final String openTime;
  final String closeTime;

  OperatingHour({
    required this.id,
    required this.day,
    required this.openTime,
    required this.closeTime,
  });

  factory OperatingHour.fromJson(Map<String, dynamic> json) => _$OperatingHourFromJson(json);
  Map<String, dynamic> toJson() => _$OperatingHourToJson(this);
}

@JsonSerializable()
class DynamicPricing {
  final String id;
  final String dayType;
  final int basePrice;

  DynamicPricing({
    required this.id,
    required this.dayType,
    required this.basePrice,
  });

  factory DynamicPricing.fromJson(Map<String, dynamic> json) => _$DynamicPricingFromJson(json);
  Map<String, dynamic> toJson() => _$DynamicPricingToJson(this);
}

@JsonSerializable()
class PeakHourPricing {
  final String id;
  final String dayType;
  final String startTime;
  final String endTime;
  final int price;

  PeakHourPricing({
    required this.id,
    required this.dayType,
    required this.startTime,
    required this.endTime,
    required this.price,
  });

  factory PeakHourPricing.fromJson(Map<String, dynamic> json) => _$PeakHourPricingFromJson(json);
  Map<String, dynamic> toJson() => _$PeakHourPricingToJson(this);
}
