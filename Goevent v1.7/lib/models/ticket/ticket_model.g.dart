// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketModel _$TicketModelFromJson(Map<String, dynamic> json) => TicketModel(
      id: json['id'] as String,
      parkId: json['parkId'] as String?,
      eventId: json['eventId'] as String?,
      qrCode: json['qrCode'] as String?,
      ticketType: json['ticketType'] as String,
      price: (json['price'] as num).toInt(),
      platformOffer: (json['platformOffer'] as num?)?.toDouble() ?? 0,
      platformOfferType: json['platformOfferType'] as String? ?? 'rupees',
      status: json['status'] as String?,
      isRefundable: json['isRefundable'] as bool? ?? false,
      refundPercentage: (json['refundPercentage'] as num?)?.toInt(),
      refundDuration: (json['refundDuration'] as num?)?.toInt(),
      isBookingAllowed: json['isBookingAllowed'] as bool? ?? true,
      refundValidUntil: json['refundValidUntil'] == null
          ? null
          : DateTime.parse(json['refundValidUntil'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$TicketModelToJson(TicketModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'parkId': instance.parkId,
      'eventId': instance.eventId,
      'qrCode': instance.qrCode,
      'ticketType': instance.ticketType,
      'price': instance.price,
      'platformOffer': instance.platformOffer,
      'platformOfferType': instance.platformOfferType,
      'status': instance.status,
      'isRefundable': instance.isRefundable,
      'refundPercentage': instance.refundPercentage,
      'refundDuration': instance.refundDuration,
      'isBookingAllowed': instance.isBookingAllowed,
      'refundValidUntil': instance.refundValidUntil?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
