import 'package:flutter_riverpod/flutter_riverpod.dart';

final bookmarkStateProvider = StateNotifierProvider<BookmarkNotifier, Map<int, bool>>((ref) {
  return BookmarkNotifier();
});

class BookmarkNotifier extends StateNotifier<Map<int, bool>> {
  BookmarkNotifier() : super({
    0: false,
    1: false,
    2: false,
    3: false,
    4: false,
    5: false,
  });

  void toggleBookmark(int index) {
    state = {...state, index: !state[index]!};
  }
} 