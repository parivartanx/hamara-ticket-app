class OrderTicket {
  final String? eventId;
  final String? parkId;
  final List<String> couponCodes;
  final String email;
  final String name;
  final String phone;
  final List<BookingTicket> ticketIds;
  final DateTime? date;

  OrderTicket({
    this.eventId,
    this.parkId,
    required this.couponCodes,
    required this.email,
    required this.name,
    required this.phone,
    required this.ticketIds,
    this.date,
  });

  factory OrderTicket.fromJson(Map<String, dynamic> json) {
    return OrderTicket(
      eventId: json['eventId'],
      parkId: json['parkId'],
      couponCodes: List<String>.from(json['couponCodes']),
      email: json['email'],
      name: json['name'],
      phone: json['phone'],
      date: json['date'] != null
          ? DateTime.parse(json['date'])
          : null,
      ticketIds: (json['ticketIds'] as List)
          .map((item) => BookingTicket.fromJson(item))
          .toList(),
    
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'eventId': eventId,
      'parkId': parkId,
      'couponCodes': couponCodes,
      'email': email,
      'name': name,
      'phone': phone,
      'date': date?.toIso8601String(),
      'ticketIds': ticketIds.map((item) => item.toJson()).toList(),
   
    };
  }
}
class BookingTicket {
  final String ticketId;
  final int quantity;

  BookingTicket({
    required this.ticketId,
    required this.quantity,
  });

  factory BookingTicket.fromJson(Map<String, dynamic> json) {
    return BookingTicket(
      ticketId: json['ticketId'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ticketId': ticketId,
      'quantity': quantity,
    };
  }
}

class TicketOrderResponse {
  final String orderId;
  final int amount;
  final String currency;
  final String keyId;

  TicketOrderResponse({
    required this.orderId,
    required this.amount,
    required this.currency,
    required this.keyId,
  });

  factory TicketOrderResponse.fromJson(Map<String, dynamic> json) {
    return TicketOrderResponse(
      orderId: json['orderId'],
      amount: json['amount'],
      currency: json['currency'],
      keyId: json['key_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'amount': amount,
      'currency': currency,
      'key_id': keyId,
    };
  }
}