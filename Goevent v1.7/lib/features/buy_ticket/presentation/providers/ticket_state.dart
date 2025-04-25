import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/enums/occasion_type.dart';
import '../../../../models/ticket/ticket_model.dart';

// State classes
class TicketBookingState {
  final int currentStep;
  final OccasionType occasionType;
  final DateTime? selectedDate;
  final Map<String, int> selectedTickets;
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

  double get subtotal {
    return selectedTickets.entries
        .map((entry) => entry.value * 100.0)
        .fold(0.0, (total, price) => total + price);
  }
  
  double get convenienceFee => subtotal * (convenienceFeePercentage / 100);
  
  double get totalAmount => subtotal + convenienceFee;

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
  TicketBookingNotifier() : super(TicketBookingState(occasionType: OccasionType.park));

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

// Convenience providers for individual state values
final currentStepProvider = Provider<int>((ref) {
  return ref.watch(ticketBookingProvider).currentStep;
});

final occasionTypeProvider = Provider<String>((ref) {
  return ref.watch(ticketBookingProvider).occasionType.toString();
});

final selectedDateProvider = Provider<DateTime?>((ref) {
  return ref.watch(ticketBookingProvider).selectedDate;
});

// final ticketsProvider = Provider<List<TicketModel>>((ref) {
//   final bookingState = ref.watch(ticketBookingProvider);
//   return bookingState.selectedTickets.entries.map((entry) => TicketModel(
//     id: entry.key,
//     ticketType: entry.key,
//     price: 100,
//     updatedAt: DateTime.now(),
//   )).toList();
// });

final subtotalProvider = Provider<double>((ref) {
  return ref.watch(ticketBookingProvider).subtotal;
});

final convenienceFeeProvider = Provider<double>((ref) {
  return ref.watch(ticketBookingProvider).convenienceFee;
});

final totalAmountProvider = Provider<double>((ref) {
  return ref.watch(ticketBookingProvider).totalAmount;
});

final promoCodeProvider = Provider<String?>((ref) {
  return ref.watch(ticketBookingProvider).promoCode;
}); 