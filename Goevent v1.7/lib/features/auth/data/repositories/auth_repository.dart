import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/token_service.dart';

class AuthRepository {
  final TokenService _tokenService;
  
  AuthRepository({required TokenService tokenService}) 
      : _tokenService = tokenService;
  
  /// Verifies if the stored token is valid
  Future<bool> verifyToken() async {
    return await _tokenService.verifyToken();
  }
  
  /// Clears the stored token
  Future<void> clearToken() async {
    await _tokenService.clearToken();
  }
}

// Provider for AuthRepository
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final tokenService = ref.watch(tokenServiceProvider);
  return AuthRepository(tokenService: tokenService);
});