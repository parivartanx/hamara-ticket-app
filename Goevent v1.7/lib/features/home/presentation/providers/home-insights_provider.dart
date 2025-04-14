import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/models/homepage/homepage_model.dart';
import '/features/home/repos/home_repo.dart';

class HomeInsightsProvider extends AsyncNotifier<HomePageModel?> {
  @override
  Future<HomePageModel?> build() async {
    return null;
  }

  Future<void> getDashboardInsights() async {
    try {
      state = const AsyncLoading();
      final homePageData = await ref.read(homeRepoProvider).getDashboardInsights();
      state = AsyncData(homePageData);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final homeInsightsProvider = AsyncNotifierProvider<HomeInsightsProvider, HomePageModel?>(
  () => HomeInsightsProvider(),
);