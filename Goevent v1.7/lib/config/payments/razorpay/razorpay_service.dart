import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayService {
  late Razorpay _razorpay;
  final Function(PaymentSuccessResponse) onPaymentSuccess;
  final Function(String) onPaymentFailure;

  RazorpayService({required this.onPaymentSuccess, required this.onPaymentFailure}) {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void openCheckout({
    required String apiKey,
    required int amount,
    required String name,
    required String description,
    required String email,
    required String contact,
    String? orderId, // Add orderId parameter
  }) {
    var options = {
      'key': apiKey,
      'amount': amount, // in paise
      'name': "Hamara Ticket",
      'description': description,
      'prefill': {'contact': contact, 'email': email},
      'external': {
        'wallets': ['paytm']
      }
    };
    
    // Add orderId to options if available
    if (orderId != null && orderId.isNotEmpty) {
      options['order_id'] = orderId;
    }
    
    _razorpay.open(options);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    debugPrint('Payment Success: ${response.paymentId}');
    onPaymentSuccess(response);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    debugPrint('Payment Error: ${response.code} | ${response.message}');
    onPaymentFailure(response.message ?? 'Payment failed');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    debugPrint('External Wallet: ${response.walletName}');
    // Handle external wallet logic here
  }

  void dispose() {
    _razorpay.clear();
  }
}
