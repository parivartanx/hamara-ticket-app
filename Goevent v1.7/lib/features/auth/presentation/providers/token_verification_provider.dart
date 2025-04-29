import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/auth_repository.dart';

/// State for token verification
enum TokenStatus {
  initial,
  loading,
  valid,
  invalid,
  error,
}

/// Provider for token verification state
final tokenVerificationProvider = StateNotifierProvider<TokenVerificationNotifier, TokenStatus>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return TokenVerificationNotifier(authRepository);
});

/// Notifier class to manage token verification state
class TokenVerificationNotifier extends StateNotifier<TokenStatus> {
  final AuthRepository _authRepository;
  
  TokenVerificationNotifier(this._authRepository) : super(TokenStatus.initial);
  
  /// Verifies if the stored token is valid
  Future<bool> verifyToken() async {
    try {
      state = TokenStatus.loading;
      final isValid = await _authRepository.verifyToken();
      
      if (isValid) {
        state = TokenStatus.valid;
      } else {
        state = TokenStatus.invalid;
        await _authRepository.clearToken();
      }
      
      return isValid;
    } catch (e) {
      state = TokenStatus.error;
      _authRepository.clearToken();
      return false;
    }
  }
  
  /// Clears token and sets state to invalid
  Future<void> clearToken() async {
    await _authRepository.clearToken();
    state = TokenStatus.invalid;
  }
}