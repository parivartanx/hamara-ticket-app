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
  final double latitude;
  final double longitude;
  final String startDate;
  final String endDate;
  final List<String> imageUrls;
  final List<String> tags;
  final int maxCapacity;
  final String status;

  // Optional fields (not returned by backend)
  final List<String>? videoUrls;
  final String? adminId;
  final String? startTime;
  final String? endTime;
  final List<Vendor>? vendors;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Event({
    required this.id,
    required this.name,
    this.description,
    required this.location,
    required this.city,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.startDate,
    required this.endDate,
    required this.imageUrls,
    required this.tags,
    required this.maxCapacity,
    required this.status,
    this.videoUrls,
    this.adminId,
    this.startTime,
    this.endTime,
    this.vendors,
    this.createdAt,
    this.updatedAt,
  });

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
  Map<String, dynamic> toJson() => _$EventToJson(this);
}

@JsonSerializable()
class Vendor {
  final String id;
  final String eventId;
  final String name;
  final String type;
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
