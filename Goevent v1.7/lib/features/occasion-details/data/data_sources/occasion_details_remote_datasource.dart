import '/models/event/event_model.dart';
import '/utils/dio_client.dart';
import '/utils/endPoints.dart';


class OccasionDetailsRemoteDataSource {
  final DioClient _dioClient;

  OccasionDetailsRemoteDataSource({required DioClient dioClient})
      : _dioClient = dioClient;

  Future<Event> getEventById(String eventId,) async {
    try {
      final response = await _dioClient.getWithParams(
        url: EndPoints.eventByIdEndpoint,
        params: {
          'id': eventId,
        },
      );
      if( response.statusCode == 200 ){
        return Event.fromJson(response.data);
      }
      else{
        throw Exception('Failed to get event');
      }
    }
    catch(e) {
      rethrow;
    }
  }
}
