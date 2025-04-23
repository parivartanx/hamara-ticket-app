import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/models/homepage/homepage_model.dart';
import '/features/home/data/data_sources/home_remote_datasource.dart';

class HomeRepo {

  final HomeRemoteDataSource _homeRemoteDataSource;

  HomeRepo({required HomeRemoteDataSource homeRemoteDataSource}):_homeRemoteDataSource = homeRemoteDataSource;

  Future<HomePageModel> getDashboardInsights() async {
    try {
      final homePageData = await _homeRemoteDataSource.getDashboardInsights();
      log("HomePageData: ${homePageData.recommendedParks.length}");
      return homePageData;
    } catch (e) {
      log("HomeRepo: Error getting Dashboard Insights");
      rethrow;
    }
  }
  
}

final homeRepoProvider = Provider<HomeRepo>((ref) {
  return HomeRepo(homeRemoteDataSource: ref.read(homeRemoteDataSourceProvider));
});