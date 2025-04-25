// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingModel _$BookingModelFromJson(Map<String, dynamic> json) => BookingModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      ticketIdsWithQuantity:
          json['ticketIdsWithQuantity'] as Map<String, dynamic>,
      date: DateTime.parse(json['date'] as String),
      transactionId: json['transactionId'] as String,
      appTransactionId: json['appTransactionId'] as String?,
      status: json['status'] as String?,
      gstAmount: (json['gstAmount'] as num).toDouble(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      convenienceFee: (json['convenienceFee'] as num).toDouble(),
      couponAmount: (json['couponAmount'] as num).toDouble(),
      discountAmount: (json['discountAmount'] as num).toDouble(),
      eventId: json['eventId'] as String?,
      parkId: json['parkId'] as String?,
      event: json['event'] == null
          ? null
          : Event.fromJson(json['event'] as Map<String, dynamic>),
      park: json['park'] == null
          ? null
          : Park.fromJson(json['park'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      verifiedById: json['verifiedById'] as String?,
      verifiedAt: json['verifiedAt'] == null
          ? null
          : DateTime.parse(json['verifiedAt'] as String),
    );

Map<String, dynamic> _$BookingModelToJson(BookingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'ticketIdsWithQuantity': instance.ticketIdsWithQuantity,
      'date': instance.date.toIso8601String(),
      'transactionId': instance.transactionId,
      'appTransactionId': instance.appTransactionId,
      'status': instance.status,
      'gstAmount': instance.gstAmount,
      'totalAmount': instance.totalAmount,
      'convenienceFee': instance.convenienceFee,
      'couponAmount': instance.couponAmount,
      'discountAmount': instance.discountAmount,
      'eventId': instance.eventId,
      'event': instance.event?.toJson(),
      'park': instance.park?.toJson(),
      'parkId': instance.parkId,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'verifiedById': instance.verifiedById,
      'verifiedAt': instance.verifiedAt?.toIso8601String(),
    };
