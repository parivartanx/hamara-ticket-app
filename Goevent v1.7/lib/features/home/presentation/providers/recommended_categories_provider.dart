import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '/featsures/home/data/event_data.dart';
// import '/features/home/data/park_data.dart';


enum CategoryType { all, parks, waterParks, events }

class RecommendedCategoriesState {
  final CategoryType selectedCategory;
  final List<dynamic> items;

  RecommendedCategoriesState({
    required this.selectedCategory,
    required this.items,
  });

  RecommendedCategoriesState copyWith({
    CategoryType? selectedCategory,
    List<dynamic>? items,
  }) {
    return RecommendedCategoriesState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      items: items ?? this.items,
    );
  }
}

final recommendedCategoriesProvider = StateNotifierProvider<
    RecommendedCategoriesNotifier, RecommendedCategoriesState>((ref) {
  return RecommendedCategoriesNotifier();
});

class RecommendedCategoriesNotifier
    extends StateNotifier<RecommendedCategoriesState> {
  RecommendedCategoriesNotifier()
      : super(RecommendedCategoriesState(
          selectedCategory: CategoryType.all,
          items: [...[], ...[]],
        ));

  void selectCategory(CategoryType category) {
    List<dynamic> filteredItems;
    switch (category) {
      case CategoryType.all:
        filteredItems = [...[], ...[]];
        break;
      case CategoryType.parks:
        filteredItems = [];
        break;
      case CategoryType.waterParks:
        filteredItems = [];
        break;
      case CategoryType.events:
        filteredItems = [];
        break;
    }

    state = state.copyWith(
      selectedCategory: category,
      items: filteredItems,
    );
  }
}
