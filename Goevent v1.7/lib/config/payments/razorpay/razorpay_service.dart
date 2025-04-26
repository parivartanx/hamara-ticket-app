import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayService {
  late Razorpay _razorpay;
  final VoidCallback onPaymentSuccess;
  final Function(String) onPaymentFailure;

  RazorpayService({required this.onPaymentSuccess, required this.onPaymentFailure}) {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void openCheckout({
    required String apiKey,
    required double amount,
    required String name,
    required String description,
    required String email,
    required String contact,
  }) {
    var options = {
      'key': apiKey,
      'amount': (amount * 100).toInt(), // in paise
      'name': name,
      'description': description,
      'prefill': {'contact': contact, 'email': email},
      'external': {
        'wallets': ['paytm']
      }
    };
    _razorpay.open(options);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    debugPrint('Payment Success: \\${response.paymentId}');
    onPaymentSuccess();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    debugPrint('Payment Error: \\${response.code} | \\${response.message}');
    onPaymentFailure(response.message ?? 'Payment failed');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    debugPrint('External Wallet: \\${response.walletName}');
    // Handle external wallet logic here
  }

  void dispose() {
    _razorpay.clear();
  }
}
