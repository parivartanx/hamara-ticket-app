import 'package:json_annotation/json_annotation.dart';

part 'event_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Event {
  final String id;
  final String name;
  final String? description;
  final String location;
  final String city;
  final String address;
  final List<String> imageUrls;
  final List<String> videoUrls;
  final List<String> tags;
  final double latitude;
  final double longitude;
  final String startDate;
  final String endDate;
  final String startTime;
  final String endTime;
  final int maxCapacity;
  final String adminId;
  final String status; // "Scheduled", "Ongoing", "Completed", "Cancelled"
  final DateTime createdAt;
  final DateTime updatedAt;

  final List<Vendor>? vendors; // Made optional

  Event({
    required this.id,
    required this.name,
    this.description,
    required this.location,
    required this.city,
    required this.address,
    required this.imageUrls,
    required this.videoUrls,
    required this.tags,
    required this.latitude,
    required this.longitude,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    required this.maxCapacity,
    required this.adminId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.vendors, // Optional field
  });

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
  Map<String, dynamic> toJson() => _$EventToJson(this);
}

@JsonSerializable()
class Vendor {
  final String id;
  final String eventId;
  final String name;
  final String type; // "Food", "Merchandise", "Sponsor"
  final String contact;
  final DateTime createdAt;

  Vendor({
    required this.id,
    required this.eventId,
    required this.name,
    required this.type,
    required this.contact,
    required this.createdAt,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) => _$VendorFromJson(json);
  Map<String, dynamic> toJson() => _$VendorToJson(this);
}
