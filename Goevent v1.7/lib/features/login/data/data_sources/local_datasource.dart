import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../models/user_model.dart';
import '../../../../utils/shared_prefs_manager.dart';

class LocalDataSource {
  LocalDataSource();

  Future<bool> isLoggedIn() async {
    return SharedPrefsManager.isLoggedIn();
  }

  Future<void> saveAccessToken(String accessToken) async {
    await SharedPrefsManager.setAccessToken(accessToken);
  }

  Future<void> saveRefreshToken(String refreshToken) async {
    await SharedPrefsManager.setRefreshToken(refreshToken);
  }

  Future<String?> getAccessToken()  async{
    return await SharedPrefsManager.getAccessToken();
  }

  Future<String?> getRefreshToken() async {
    return SharedPrefsManager.getRefreshToken();
  }

  Future<void> clearAuthData() async {
    await SharedPrefsManager.clearAuthData();
  }

  Future<void> saveUser(User user)async{
    await SharedPrefsManager.setUser(user);
  }

   Future< User?> getUser()async{
    return SharedPrefsManager.getUser();
  }


}

// local storage provider 
final localDataSourceProvider = Provider<LocalDataSource>((ref) => LocalDataSource());