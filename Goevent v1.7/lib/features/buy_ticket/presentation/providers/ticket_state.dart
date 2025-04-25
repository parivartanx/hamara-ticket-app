import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/enums/occasion_type.dart';
import '../../../../models/ticket/ticket_model.dart';
import 'tickets_provider.dart';
import 'package:intl/intl.dart';

// State classes
class TicketBookingState {
  final int currentStep;
  final OccasionType occasionType;
  final DateTime? selectedDate;
  final  selectedTickets;
  final Map<String, String> userDetails;
  final String? promoCode;
  final double convenienceFeePercentage;

  const TicketBookingState({
    this.currentStep = 0,
    required this.occasionType,
    this.selectedDate,
    this.selectedTickets = const {},
    this.userDetails = const {},
    this.promoCode,
    this.convenienceFeePercentage = 3.5,
  });

  bool get canProceedFromDateSelection {
    if (!occasionType.requiresDateSelection) return true;
    return selectedDate != null;
  }

  bool get canProceedFromTicketSelection {
    return selectedTickets.isNotEmpty && 
           selectedTickets.values.any((count) => count > 0);
  }

  bool get canProceedFromDetails {
    return userDetails.isNotEmpty &&
           userDetails.containsKey('name') &&
           userDetails.containsKey('email') &&
           userDetails.containsKey('phone');
  }

  TicketBookingState copyWith({
    int? currentStep,
    OccasionType? occasionType,
    DateTime? selectedDate,
    Map<String, int>? selectedTickets,
    Map<String, String>? userDetails,
    String? promoCode,
    double? convenienceFeePercentage,
  }) {
    return TicketBookingState(
      currentStep: currentStep ?? this.currentStep,
      occasionType: occasionType ?? this.occasionType,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTickets: selectedTickets ?? this.selectedTickets,
      userDetails: userDetails ?? this.userDetails,
      promoCode: promoCode ?? this.promoCode,
      convenienceFeePercentage: convenienceFeePercentage ?? this.convenienceFeePercentage,
    );
  }
}

// Provider
class TicketBookingNotifier extends StateNotifier<TicketBookingState> {
  TicketBookingNotifier() : super(const TicketBookingState(occasionType: OccasionType.park));

  void setOccasionType(String type) {
    state = TicketBookingState(occasionType: OccasionType.fromString(type));
  }

  void selectDate(DateTime date) {
    state = state.copyWith(selectedDate: date);
  }

  void updateTickets(String type, int count) {
    final updatedTickets = Map<String, int>.from(state.selectedTickets);
    if (count > 0) {
      updatedTickets[type] = count;
    } else {
      updatedTickets.remove(type);
    }
    state = state.copyWith(selectedTickets: updatedTickets);
  }

  void updateUserDetails(Map<String, String> details) {
    state = state.copyWith(userDetails: details);
  }

  bool canProceedToNextStep() {
    switch (state.currentStep) {
      case 0:
        return state.occasionType.requiresDateSelection 
            ? state.canProceedFromDateSelection 
            : state.canProceedFromTicketSelection;
      case 1:
        return state.occasionType.requiresDateSelection 
            ? state.canProceedFromTicketSelection 
            : state.canProceedFromDetails;
      case 2:
        return state.canProceedFromDetails;
      default:
        return false;
    }
  }

  void nextStep() {
    if (canProceedToNextStep()) {
      state = state.copyWith(currentStep: state.currentStep + 1);
    }
  }

  void previousStep() {
    if (state.currentStep > 0) {
      state = state.copyWith(currentStep: state.currentStep - 1);
    }
  }

  void applyPromoCode(String code) {
    state = state.copyWith(promoCode: code);
  }

  void reset() {
    state = TicketBookingState(occasionType: state.occasionType);
  }
}

// Global providers
final ticketBookingProvider = StateNotifierProvider<TicketBookingNotifier, TicketBookingState>((ref) {
  return TicketBookingNotifier();
});

// Provider to store ticket prices
class TicketPricesNotifier extends StateNotifier<Map<String, double>> {
  TicketPricesNotifier() : super({});

  void updatePrices(List<TicketModel> tickets) {
    try {
      if (tickets.isEmpty) return;
      
      final newPrices = <String, double>{};
      for (var ticket in tickets) {
        if (ticket.id.isNotEmpty) {
          newPrices[ticket.id] = ticket.price.toDouble();
        }
      }
      
      state = newPrices;
    } catch (e) {
      print('Error in updatePrices: $e');
      // Maintain current state in case of error
    }
  }

  void clear() {
    state = {};
  }
}

// Add providers for occasion details
final occasionIdProvider = StateProvider<String>((ref) => '');
final occasionTypeProvider = StateProvider<String>((ref) => '');

final ticketPricesProvider = StateNotifierProvider.autoDispose<TicketPricesNotifier, Map<String, double>>((ref) {
  final notifier = TicketPricesNotifier();
  
  // Get the selected date with null safety
  final selectedDate = ref.watch(selectedDateProvider);
  final formattedDate = selectedDate != null 
      ? DateFormat('yyyy-MM-dd').format(selectedDate)
      : DateFormat('yyyy-MM-dd').format(DateTime.now());
  
  // Get the occasion type and ID with validation
  final occasionType = ref.watch(occasionTypeProvider).toLowerCase();
  final occasionId = ref.watch(occasionIdProvider);
  
  // Only proceed if we have valid occasion type and ID
  if (occasionType.isNotEmpty && occasionId.isNotEmpty) {
    // Setup the automatic price updates with error handling
    ref.listen<AsyncValue<List<TicketModel>>>(
      ticketsProvider((
        date: formattedDate,
        eventId: occasionType == "event" ? occasionId : null,
        parkId: (occasionType == "park" || occasionType == "waterpark") ? occasionId : null,
      )),
      (previous, next) {
        try {
          next.whenData((tickets) {
            if (tickets.isNotEmpty) {
              notifier.updatePrices(tickets);
            }
          });
        } catch (e) {
          // Handle any errors during price updates
          print('Error updating ticket prices: $e');
          notifier.clear(); // Reset to safe state
        }
      },
    );
  }
  
  // Clean up when disposed
  ref.onDispose(() {
    notifier.clear();
  });
  
  return notifier;
});

// Convenience providers for individual state values
final currentStepProvider = Provider<int>((ref) {
  return ref.watch(ticketBookingProvider).currentStep;
});

final selectedDateProvider = Provider<DateTime?>((ref) {
  return ref.watch(ticketBookingProvider).selectedDate;
});

final subtotalProvider = Provider<double>((ref) {
  final bookingState = ref.watch(ticketBookingProvider);
  final ticketPrices = ref.watch(ticketPricesProvider);
  
  return bookingState.selectedTickets.entries
      .map((entry) => entry.value * (ticketPrices[entry.key] ?? 0.0))
      .fold(0.0, (total, price) => total + price);
});

final convenienceFeeProvider = Provider<double>((ref) {
  final subtotal = ref.watch(subtotalProvider);
  final bookingState = ref.watch(ticketBookingProvider);
  return subtotal * (bookingState.convenienceFeePercentage / 100);
});

final totalAmountProvider = Provider<double>((ref) {
  final subtotal = ref.watch(subtotalProvider);
  final convenienceFee = ref.watch(convenienceFeeProvider);
  return subtotal + convenienceFee;
});

final promoCodeProvider = Provider<String?>((ref) {
  return ref.watch(ticketBookingProvider).promoCode;
}); 