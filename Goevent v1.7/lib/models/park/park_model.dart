import 'package:json_annotation/json_annotation.dart';

part 'park_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Park {
  String id;
  String name;
  String type;
  String adminId;
  String city;
  String address;
  double latitude;
  double longitude;
  String status;
  bool isDeleted;
  List<String> imageUrls;
  List<String> videoUrls;
  List<String> tags;
  int maxCapacity;
  List<OperatingHour> operatingHours;
  List<DynamicPricing> dynamicPricing;
  List<PeakHourPricing> peakHourPricing;
  List<Attraction> attractions;
  DateTime createdAt;
  DateTime updatedAt;

  Park({
    required this.id,
    required this.name,
    required this.type,
    required this.adminId,
    required this.city,
    required this.address,
    required this.latitude,
    required this.longitude,
    this.status = "active",
    this.isDeleted = false,
    required this.imageUrls,
    required this.videoUrls,
    required this.tags,
    required this.maxCapacity,
    required this.operatingHours,
    required this.dynamicPricing,
    required this.peakHourPricing,
    required this.attractions,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Park.fromJson(Map<String, dynamic> json) => _$ParkFromJson(json);
  Map<String, dynamic> toJson() => _$ParkToJson(this);
}

@JsonSerializable()
class OperatingHour {
  String id;
  String day;
  String openTime;
  String closeTime;

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
  String id;
  String dayType;
  int basePrice;

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
  String id;
  String dayType;
  String startTime;
  String endTime;
  int price;

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

@JsonSerializable()
class Attraction {
  String id;
  String name;
  String type;
  int? heightRestriction;
  String status;

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
