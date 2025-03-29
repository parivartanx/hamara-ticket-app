import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/ticket_model.dart';

// Provider to determine if the occasion is a park or event
final occasionTypeProvider = StateProvider<String>((ref) => 'park'); // 'park' or 'event'

// Provider for the current step
final currentStepProvider = StateProvider<int>((ref) => 0);

// Provider for selected date (only for park type)
final selectedDateProvider = StateProvider<DateTime?>((ref) => null);

// Provider for ticket list
final ticketsProvider = StateNotifierProvider<TicketsNotifier, List<TicketModel>>((ref) {
  return TicketsNotifier();
});

// Provider for convenience fee percentage
final convenienceFeePercentageProvider = Provider<double>((ref) => 3.5); // 3.5% convenience fee

// Provider for subtotal calculation
final subtotalProvider = Provider<double>((ref) {
  final tickets = ref.watch(ticketsProvider);
  return tickets.fold(0, (total, ticket) => total + ticket.totalPrice);
});

// Provider for convenience fee calculation
final convenienceFeeProvider = Provider<double>((ref) {
  final subtotal = ref.watch(subtotalProvider);
  final feePercentage = ref.watch(convenienceFeePercentageProvider);
  return subtotal * (feePercentage / 100);
});

// Provider for total amount calculation
final totalAmountProvider = Provider<double>((ref) {
  final subtotal = ref.watch(subtotalProvider);
  final convenienceFee = ref.watch(convenienceFeeProvider);
  return subtotal + convenienceFee;
});

// Provider for applied promo code
final promoCodeProvider = StateProvider<String?>((ref) => null);

class TicketsNotifier extends StateNotifier<List<TicketModel>> {
  TicketsNotifier()
      : super([
          TicketModel(
            id: '1',
            name: 'Entry Ticket',
            price: 599,
            quantity: 0,
            isActive: true,
          ),
          TicketModel(
            id: '2',
            name: 'VIP Ticket',
            price: 999,
            quantity: 0,
            isActive: true,
          ),
          TicketModel(
            id: '3',
            name: 'Family Pack (4 Persons)',
            price: 1999,
            quantity: 0,
            isActive: true,
          ),
        ]);

  void updateTicketQuantity(String ticketId, int newQuantity) {
    if (newQuantity < 0) return;
    
    state = state.map((ticket) {
      if (ticket.id == ticketId) {
        return ticket.copyWith(quantity: newQuantity);
      }
      return ticket;
    }).toList();
  }

  void incrementTicket(String ticketId) {
    state = state.map((ticket) {
      if (ticket.id == ticketId) {
        return ticket.copyWith(quantity: ticket.quantity + 1);
      }
      return ticket;
    }).toList();
  }

  void decrementTicket(String ticketId) {
    state = state.map((ticket) {
      if (ticket.id == ticketId && ticket.quantity > 0) {
        return ticket.copyWith(quantity: ticket.quantity - 1);
      }
      return ticket;
    }).toList();
  }

  void applyPromoCode(String code) {
    // Implementation for applying promo code
    // This would typically involve an API call to validate the code
    // and apply the discount
  }
}
