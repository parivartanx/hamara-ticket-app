
class TicketTypeAndQuantity {
  final String ticketType;
  final int quantity;

  TicketTypeAndQuantity({
    required this.ticketType,
    required this.quantity,
  });

  factory TicketTypeAndQuantity.fromJson(Map<String, dynamic> json) {
    return TicketTypeAndQuantity(
      ticketType: json['ticketType'],
      quantity: json['quantity'],
    );
  }
}
class BookingModel {
  final String id;
  final String userId;
  final DateTime date;
  final String transactionId;
  final String? appTransactionId;
  final List<TicketIdWithQuantity> ticketIdsWithQuantity;
  final String status;
  final double gstAmount;
  final double totalAmount;
  final double convenienceFee;
  final double couponAmount;
  final double discountAmount;
  final String? eventId;
  final String? parkId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? verifiedById;
  final DateTime? verifiedAt;
  final List<Ticket> ticket;
  final Event? event; // updated to Event? (nullable)
  final Park? park;

  BookingModel({
    required this.id,
    required this.userId,
    required this.date,
    required this.transactionId,
    this.appTransactionId,
    required this.ticketIdsWithQuantity,
    required this.status,
    required this.gstAmount,
    required this.totalAmount,
    required this.convenienceFee,
    required this.couponAmount,
    required this.discountAmount,
     this.eventId,
     this.parkId,
     this.createdAt,
     this.updatedAt,
    required this.verifiedById,
    required this.verifiedAt,
    required this.ticket,
    this.event,
    this.park,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'],
      userId: json['userId'],
      date: DateTime.parse(json['date']),
      transactionId: json['transactionId'],
      appTransactionId: json['appTransactionId'],
      ticketIdsWithQuantity: (json['ticketIdsWithQuantity'] as List)
          .map((e) => TicketIdWithQuantity.fromJson(e))
          .toList(),
      status: json['status'],
      gstAmount: (json['gstAmount'] ?? 0).toDouble(),
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
      convenienceFee: (json['convenienceFee'] ?? 0).toDouble(),
      couponAmount: (json['couponAmount'] ?? 0).toDouble(),
      discountAmount: (json['discountAmount'] ?? 0).toDouble(),
      eventId:  json['eventId'],
      parkId: json['parkId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      verifiedById: json['verifiedById'],
      verifiedAt: json['verifiedAt'] != null ? DateTime.parse(json['verifiedAt']) : null,
      ticket: (json['ticket'] as List)
          .map((e) => Ticket.fromJson(e))
          .toList(),
      event: json['event'] != null ? Event.fromJson(json['event']) : null,
      park: json["park"] != null ? Park.fromJson(json['park']): null,
    );
  }

  /// GET Ticket Type with Quantity
  List<TicketTypeAndQuantity> getTicketTypeWithQuantity() {
    final List<TicketTypeAndQuantity> ticketTypeWithQuantity = [];
    for(final tkt in ticketIdsWithQuantity) {
      // filter the ticket type from tickets
      final ticketTyp = ticket.where((element) => element.id == tkt.ticketId).toList();
      final ticketTypeQty = TicketTypeAndQuantity(
        ticketType: ticketTyp.isNotEmpty ? ticketTyp.first.ticketType : "",
        quantity: tkt.quantity,
      );
      ticketTypeWithQuantity.add(ticketTypeQty);
    }
    return ticketTypeWithQuantity;
  }
}

class TicketIdWithQuantity {
  final int quantity;
  final String ticketId;

  TicketIdWithQuantity({
    required this.quantity,
    required this.ticketId,
  });

  factory TicketIdWithQuantity.fromJson(Map<String, dynamic> json) {
    return TicketIdWithQuantity(
      quantity: json['quantity'],
      ticketId: json['ticketId'],
    );
  }
}

class Ticket {
  final String id;
  final String ticketType;
  final double price;
  final DateTime createdAt;

  Ticket({
    required this.id,
    required this.ticketType,
    required this.price,
    required this.createdAt,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'],
      ticketType: json['ticketType'],
      price: (json['price'] ?? 0).toDouble(),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

class Park {
  final String id;
  final String name;
  final String type;
  final String adminId;

  Park({
    required this.id,
    required this.name,
    required this.type,
    required this.adminId,
  });

  factory Park.fromJson(Map<String, dynamic> json) {
    return Park(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      adminId: json['adminId'],
    );
  }
}

class Event {
  final String id;
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final String startTime;
  final String endTime;
  final String adminId;

  Event({
    required this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    required this.adminId,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      name: json['name'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      startTime: json['startTime'],
      endTime: json['endTime'],
      adminId: json['adminId'],
    );
  }
}
