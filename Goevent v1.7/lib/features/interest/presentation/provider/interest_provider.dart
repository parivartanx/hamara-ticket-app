import 'package:flutter_riverpod/flutter_riverpod.dart';

// State class
class InterestState {
  final Map<String, bool> selections;
  final Map<String, List<String>> assets;

  const InterestState({
    required this.selections,
    required this.assets,
  });

  int get selectedCount => selections.values.where((v) => v).length;

  InterestState copyWith({
    Map<String, bool>? selections,
    Map<String, List<String>>? assets,
  }) {
    return InterestState(
      selections: selections ?? this.selections,
      assets: assets ?? this.assets,
    );
  }
}

// Interest notifier
class InterestNotifier extends StateNotifier<InterestState> {
  InterestNotifier() : super( const InterestState(
    selections: {
      'Music': false,
      'Art': false,
      'Sport': false,
      'Party': false,
      'Food': false,
      'Others': false,
    },
    assets: {
      'Music': ['assets/image/music.png', 'assets/image/music1.png'],
      'Art': ['assets/image/paint.png', 'assets/image/paint1.png'],
      'Sport': ['assets/image/sports.png', 'assets/image/sport1.png'],
      'Party': ['assets/image/sports.png', 'assets/image/party1.png'],
      'Food': ['assets/image/paint.png', 'assets/image/paint1.png'],
      'Others': ['assets/image/music.png', 'assets/image/other1.png'],
    },
  ));

  void toggleInterest(String interest) {
    if (!state.selections[interest]! && state.selectedCount >= 5) return;
    
    final newSelections = Map<String, bool>.from(state.selections);
    newSelections[interest] = !newSelections[interest]!;
    
    state = state.copyWith(selections: newSelections);
  }

  bool canProceed() => state.selectedCount == 5;
}

// Provider
final interestProvider = StateNotifierProvider<InterestNotifier, InterestState>((ref) {
  return InterestNotifier();
});