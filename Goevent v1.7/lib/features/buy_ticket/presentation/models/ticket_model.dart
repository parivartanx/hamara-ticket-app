class TicketModel {
  final String id;
  final String name;
  final double price;
  int quantity;
  final bool isActive;

  TicketModel({
    required this.id,
    required this.name,
    required this.price,
    this.quantity = 0,
    this.isActive = true,
  });

  double get totalPrice => price * quantity;

  TicketModel copyWith({
    String? id,
    String? name,
    double? price,
    int? quantity,
    bool? isActive,
  }) {
    return TicketModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      isActive: isActive ?? this.isActive,
    );
  }
}
