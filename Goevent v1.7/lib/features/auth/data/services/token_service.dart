import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/utils/dio_client.dart';
import '/utils/endPoints.dart';
import '/features/login/data/data_sources/local_datasource.dart';

class TokenService {
  final DioClient _dioClient;
  final LocalDataSource _localDataSource;
  
  TokenService({
    required DioClient dioClient,
    required LocalDataSource localDataSource,
  })  : _dioClient = dioClient,
        _localDataSource = localDataSource;

  /// Verifies if the stored token is valid by making a POST request to the verification endpoint
  Future<bool> verifyToken() async {
    try {
      // Check if token exists in shared preferences
      final token = await _localDataSource.getAccessToken();
      
      // If no token exists, return false immediately
      if (token == null || token.isEmpty) {
        return false;
      }
      
      // Use the existing post method from DioClient to verify the token
      // The token will be automatically added to the headers by DioClient's interceptor
      final response = await _dioClient.post(
        url: EndPoints.verifyToken,
        body: {}, // Empty body as the token is in the header
      );
      
      // If we get here, the request was successful
      // Check if the response contains a success field
      // check the status code 
      if(response.statusCode != 200){
        return false;
      }
      
      // If no success field, assume validity based on successful response
      return true;
    } catch (e) {
      // Log error for debugging purposes
      print('Error verifying token: $e');
      return false;
    }
  }
  
  /// Clears the stored token from SharedPreferences
  Future<void> clearToken() async {
    try {
      await _localDataSource.clearAuthData();
    } catch (e) {
      print('Error clearing token: $e');
    }
  }
}

// Provider for TokenService
final tokenServiceProvider = Provider<TokenService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  final localDataSource = LocalDataSource();
  return TokenService(
    dioClient: dioClient,
    localDataSource: localDataSource,
  );
});