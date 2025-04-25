import '/models/event/event_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../park/park_model.dart';

part 'booking_model.g.dart';

@JsonSerializable(explicitToJson: true)
class BookingModel {
  final String id;
  final String userId;
  final Map<String, dynamic> ticketIdsWithQuantity;
  final DateTime date;
  final String transactionId;
  final String? appTransactionId;
  final String? status; // "pending", "success", "failed","used"
  final double gstAmount;
  final double totalAmount;
  final double convenienceFee;
  final double couponAmount;
  final double discountAmount;
  final String? eventId;
  final Event? event;
  final Park? park;
  final String? parkId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? verifiedById;
  final DateTime? verifiedAt;

  BookingModel({
    required this.id,
    required this.userId,
    required this.ticketIdsWithQuantity,
    required this.date,
    required this.transactionId,
    this.appTransactionId,
    required this.status,
    required this.gstAmount,
    required this.totalAmount,
    required this.convenienceFee,
    required this.couponAmount,
    required this.discountAmount,
    this.eventId,
    this.parkId,
    this.event,
    this.park,
    required this.createdAt,
    required this.updatedAt,
    this.verifiedById,
    this.verifiedAt,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) => _$BookingModelFromJson(json);
  Map<String, dynamic> toJson() => _$BookingModelToJson(this);
}
