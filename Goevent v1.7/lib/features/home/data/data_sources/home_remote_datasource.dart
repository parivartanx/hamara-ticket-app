import 'dart:developer';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '/utils/dio_client.dart';
import '/utils/endPoints.dart';
import '/models/homepage/homepage_model.dart';

class HomeRemoteDataSource {  
  final DioClient _dioClient;

  HomeRemoteDataSource({required DioClient dioClient}):_dioClient= dioClient;
  
  Future<HomePageModel> getDashboardInsights() async {
    try {
      final response = await _dioClient.get(url: EndPoints.homeEndPoint);
      
      
      if(response.statusCode == 200) {
        // log("Response: ${response.data}");
        final homePageModel = HomePageModel.fromJson(response.data);
        // log("HomePageModel: ${homePageModel.recommendedParks}");
        return homePageModel;
      }

      throw Exception("Backend returned error code ${response.statusCode}");

    } catch (e, stackTrace) {
       log("RemoteDataSource: Error getting Home Insights", error: e, stackTrace: stackTrace);
       rethrow; // Let's throw the error to better understand what's going wrong
    }
  }
}

final homeRemoteDataSourceProvider = Provider<HomeRemoteDataSource>((ref) {
  return HomeRemoteDataSource(dioClient: ref.read(dioClientProvider));
});