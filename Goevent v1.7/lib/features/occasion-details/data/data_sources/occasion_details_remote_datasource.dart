
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/park/park_model.dart';
import '/models/event/event_model.dart';
import '/utils/dio_client.dart';
import '/utils/endPoints.dart';


class OccasionDetailsRemoteDataSource {
  final DioClient _dioClient;

  OccasionDetailsRemoteDataSource({required DioClient dioClient})
      : _dioClient = dioClient;

  Future<Event> getEventById(String eventId,) async {
    try {
      final response = await _dioClient.get(
        url: "${EndPoints.eventByIdEndpoint}/$eventId",
      );
      if( response.statusCode == 200 ){
        return Event.fromJson(response.data['data']);
      }
      else{
        throw Exception('Failed to get event');
      }
    }
    catch(e) {
      rethrow;
    }
  }

  Future<Park> getParkById(String parkId,) async {
    try {
      final response = await _dioClient.get(
        url: "${EndPoints.parkByIdEndpoint}/$parkId",
      );
      final data = response.data['data'];
      if( response.statusCode == 200 ){
        return Park.fromJson(data);
      }
      else{
        throw Exception('Failed to get park');
      }
    }
    catch(e) {
      rethrow;
    }
  }
}

final occasionDetailsRemoteDataSourceProvider = Provider<OccasionDetailsRemoteDataSource>((ref) {
  return OccasionDetailsRemoteDataSource(dioClient: ref.read(dioClientProvider));
});
