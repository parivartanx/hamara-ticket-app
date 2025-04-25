import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/park/park_model.dart';
import '/models/event/event_model.dart';
import '../data/data_sources/occasion_details_remote_datasource.dart';

// Abstract class defining the contract for the repository
abstract class IOccasionRepository {
  Future<Event> getEventById(String eventId);
  Future<Park> getParkById(String parkId);
}

// Concrete implementation of the repository
class OccasionRepository implements IOccasionRepository {
  final OccasionDetailsRemoteDataSource _remoteDataSource;

  OccasionRepository({
    required OccasionDetailsRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Event> getEventById(String eventId) async {
    try {
      return await _remoteDataSource.getEventById(eventId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Park> getParkById(String parkId) async {
    try {
      return await _remoteDataSource.getParkById(parkId);
    } catch (e) {
      rethrow;
    }
  }
}

// Provider for the repository
final occasionRepositoryProvider = Provider<IOccasionRepository>((ref) {
  final remoteDataSource = ref.read(occasionDetailsRemoteDataSourceProvider);
  return OccasionRepository(remoteDataSource: remoteDataSource);
});
