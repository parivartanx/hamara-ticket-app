import 'package:json_annotation/json_annotation.dart';

part 'ticket_model.g.dart';

@JsonSerializable()
class TicketModel {
  final String id;
  final String? parkId;
  final String? eventId;
  final String? qrCode;
  final String ticketType; // "General", "VIP", "Combo", etc.
  final int price;

  @JsonKey(defaultValue: 0)
  final double? platformOffer;

  @JsonKey(defaultValue: "rupees")
  final String? platformOfferType; // "rupees" or "percentage"

  final String? status; // "Active", "Inactive", "Deleted"

  @JsonKey(defaultValue: false)
  final bool? isRefundable;

  final int? refundPercentage; // e.g., 80 for 80%
  final int? refundDuration; // in minutes

  @JsonKey(defaultValue: true)
  final bool? isBookingAllowed;

  final DateTime? refundValidUntil;
  final DateTime? createdAt;
  final DateTime? updatedAt;


  TicketModel({
    required this.id,
    this.parkId,
    this.eventId,
    this.qrCode,
    required this.ticketType,
    required this.price,
    this.platformOffer = 0,
    this.platformOfferType = "rupees",
    this.status,
    this.isRefundable = false,
    this.refundPercentage,
    this.refundDuration,
    this.isBookingAllowed = true,
    this.refundValidUntil,
    this.createdAt,
    required this.updatedAt,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) => _$TicketModelFromJson(json);
  Map<String, dynamic> toJson() => _$TicketModelToJson(this);
}