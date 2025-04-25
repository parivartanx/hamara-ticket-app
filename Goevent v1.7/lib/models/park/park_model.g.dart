// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'park_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Park _$ParkFromJson(Map<String, dynamic> json) => Park(
      id: json['id'] as String,
      name: json['name'] as String,
      city: json['city'] as String,
      address: json['address'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      imageUrls:
          (json['imageUrls'] as List<dynamic>).map((e) => e as String).toList(),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      maxCapacity: (json['maxCapacity'] as num).toInt(),
      attractions: (json['attractions'] as List<dynamic>)
          .map((e) => Attraction.fromJson(e as Map<String, dynamic>))
          .toList(),
      tickets: (json['tickets'] as List<dynamic>)
          .map((e) => TicketModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      type: json['type'] as String?,
      adminId: json['adminId'] as String?,
      status: json['status'] as String?,
      isDeleted: json['isDeleted'] as bool?,
      videoUrls: (json['videoUrls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      operatingHours: (json['operatingHours'] as List<dynamic>?)
          ?.map((e) => OperatingHour.fromJson(e as Map<String, dynamic>))
          .toList(),
      dynamicPricing: (json['dynamicPricing'] as List<dynamic>?)
          ?.map((e) => DynamicPricing.fromJson(e as Map<String, dynamic>))
          .toList(),
      peakHourPricing: (json['peakHourPricing'] as List<dynamic>?)
          ?.map((e) => PeakHourPricing.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ParkToJson(Park instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'city': instance.city,
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'imageUrls': instance.imageUrls,
      'tags': instance.tags,
      'maxCapacity': instance.maxCapacity,
      'attractions': instance.attractions.map((e) => e.toJson()).toList(),
      'tickets': instance.tickets.map((e) => e.toJson()).toList(),
      'type': instance.type,
      'adminId': instance.adminId,
      'status': instance.status,
      'isDeleted': instance.isDeleted,
      'videoUrls': instance.videoUrls,
      'operatingHours':
          instance.operatingHours?.map((e) => e.toJson()).toList(),
      'dynamicPricing':
          instance.dynamicPricing?.map((e) => e.toJson()).toList(),
      'peakHourPricing':
          instance.peakHourPricing?.map((e) => e.toJson()).toList(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

Attraction _$AttractionFromJson(Map<String, dynamic> json) => Attraction(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      heightRestriction: (json['heightRestriction'] as num?)?.toInt(),
      status: json['status'] as String,
    );

Map<String, dynamic> _$AttractionToJson(Attraction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'heightRestriction': instance.heightRestriction,
      'status': instance.status,
    };

OperatingHour _$OperatingHourFromJson(Map<String, dynamic> json) =>
    OperatingHour(
      id: json['id'] as String,
      day: json['day'] as String,
      openTime: json['openTime'] as String,
      closeTime: json['closeTime'] as String,
    );

Map<String, dynamic> _$OperatingHourToJson(OperatingHour instance) =>
    <String, dynamic>{
      'id': instance.id,
      'day': instance.day,
      'openTime': instance.openTime,
      'closeTime': instance.closeTime,
    };

DynamicPricing _$DynamicPricingFromJson(Map<String, dynamic> json) =>
    DynamicPricing(
      id: json['id'] as String,
      dayType: json['dayType'] as String,
      basePrice: (json['basePrice'] as num).toInt(),
    );

Map<String, dynamic> _$DynamicPricingToJson(DynamicPricing instance) =>
    <String, dynamic>{
      'id': instance.id,
      'dayType': instance.dayType,
      'basePrice': instance.basePrice,
    };

PeakHourPricing _$PeakHourPricingFromJson(Map<String, dynamic> json) =>
    PeakHourPricing(
      id: json['id'] as String,
      dayType: json['dayType'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      price: (json['price'] as num).toInt(),
    );

Map<String, dynamic> _$PeakHourPricingToJson(PeakHourPricing instance) =>
    <String, dynamic>{
      'id': instance.id,
      'dayType': instance.dayType,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'price': instance.price,
    };
