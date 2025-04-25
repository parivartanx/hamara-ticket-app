// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      location: json['location'] as String,
      city: json['city'] as String,
      address: json['address'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      imageUrls:
          (json['imageUrls'] as List<dynamic>).map((e) => e as String).toList(),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      maxCapacity: (json['maxCapacity'] as num).toInt(),
      status: json['status'] as String,
      tickets: (json['tickets'] as List<dynamic>)
          .map((e) => TicketModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      videoUrls: (json['videoUrls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      adminId: json['adminId'] as String?,
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
      vendors: (json['vendors'] as List<dynamic>?)
          ?.map((e) => Vendor.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'location': instance.location,
      'city': instance.city,
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'imageUrls': instance.imageUrls,
      'tags': instance.tags,
      'maxCapacity': instance.maxCapacity,
      'status': instance.status,
      'tickets': instance.tickets.map((e) => e.toJson()).toList(),
      'videoUrls': instance.videoUrls,
      'adminId': instance.adminId,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'vendors': instance.vendors?.map((e) => e.toJson()).toList(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

Vendor _$VendorFromJson(Map<String, dynamic> json) => Vendor(
      id: json['id'] as String,
      eventId: json['eventId'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      contact: json['contact'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$VendorToJson(Vendor instance) => <String, dynamic>{
      'id': instance.id,
      'eventId': instance.eventId,
      'name': instance.name,
      'type': instance.type,
      'contact': instance.contact,
      'createdAt': instance.createdAt.toIso8601String(),
    };
