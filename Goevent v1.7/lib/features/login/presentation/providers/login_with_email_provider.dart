import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamaraticket/models/user_model.dart';
import '../../repos/login_repo.dart';


class LoginWithEmailProvider extends AsyncNotifier {
  @override
  Future<void> build() async {
    return;
  }

  Future<void> loginWithEmail({required String email}) async {
    try {
      state = const AsyncLoading();
      final response  = await ref.read(loginRepoProvider).loginWithEmail(email: email);
      state =  const AsyncData("OTP sent successfully:)");
      log("response of login with email in UI Provider : ${response.data}");
    } catch (e, st) {
      log("Error in loginWithEmail: $e");
      state = AsyncError(e, st);
    }
  }
   
}

final loginWithEmailProvider = AsyncNotifierProvider(() => LoginWithEmailProvider());





class OTPStateProvider extends Notifier<bool> {
  @override
  bool build() {
    return false; // Initially OTP is not sent
  }
  
  void setOTPSentState(bool isSent) {
    state = isSent;
  }
}

final otpStateProvider = NotifierProvider<OTPStateProvider, bool>(() {
  return OTPStateProvider();
});


class VerifyOTPProvider extends AsyncNotifier<User?> {
  @override
  Future<User?> build() async {
    return null;
  }
  Future<void> verifyOTP({required String email, required String otp}) async {
    try {
      state = const AsyncLoading();
      final response = await ref.read(loginRepoProvider).verifyOTP(email: email, otp: otp);
      state =   AsyncData(response);
    } catch (e, st) {
      log("Error in verifyOTP: $e");
      state = AsyncError(e, st);
    }
  }
  
  
}

final verifyOTPProvider = AsyncNotifierProvider<VerifyOTPProvider, User?>(() => VerifyOTPProvider());
