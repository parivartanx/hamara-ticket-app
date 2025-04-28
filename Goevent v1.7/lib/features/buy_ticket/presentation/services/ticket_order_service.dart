
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hamaraticket/features/payment_failure_page.dart';
import 'package:hamaraticket/features/payment_success_page.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../../../config/payments/razorpay/razorpay_service.dart';
import '../../../../../models/ticket/order_ticket_model.dart';

import '../providers/tickets_provider.dart';

/// A service class that handles ticket order creation and payment process
/// with professional UI feedback for different states
class TicketOrderService {
  /// Shows an order processing dialog with elegant state management
  /// for different order creation phases
  static void processOrder({
    required BuildContext context,
    required OrderTicket order,
    required WidgetRef ref,
    required String customerName,
    required String customerEmail,
    required String customerPhone,
    String description = "Ticket Booking",
  }) {
    // Initialize payment service
    final razorpayService = RazorpayService(
      onPaymentSuccess: (PaymentSuccessResponse response) {
        context.pushNamed(PaymentSuccessPage.routeName,extra: response.paymentId);
      },
      onPaymentFailure: (error) {
        context.pushNamed(PaymentFailurePage.routeName, extra: error);
      },
    );

    // Show the order processing dialog
    showOrderProcessingDialog(
      context: context,
      ref: ref,
      order: order,
      onOrderCreated: (orderResponse) {
        // Open payment gateway when order is created successfully
        razorpayService.openCheckout(
          apiKey: orderResponse.keyId,
          amount: orderResponse.amount,
          name: customerName,
          description: description,
          email: customerEmail,
          contact: customerPhone,
          orderId: orderResponse.orderId, // Pass the orderId from backend
        );
      },
    );
  }

  /// Shows a dialog with elegant UI for order processing states
  static void showOrderProcessingDialog({
    required BuildContext context,
    required WidgetRef ref,
    required OrderTicket order,
    required Function(TicketOrderResponse) onOrderCreated,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => WillPopScope(
        onWillPop: () async => false, // Prevent dismiss with back button
        child: Consumer(
          builder: (context, ref, _) {
            final orderState = ref.watch(ticketOrderProvider(order));
            
            return orderState.when(
              data: (orderResponse) {
                // Auto-close dialog after success
                Future.delayed(const Duration(milliseconds: 800), () {
                  Navigator.of(context).pop();
                  onOrderCreated(orderResponse);
                });
                
                return _buildSuccessDialog();
              },
              loading: () => _buildLoadingDialog(),
              error: (error, stack) {
                // Auto-close dialog after error
                Future.delayed(const Duration(seconds: 3), () {
                  Navigator.of(context).pop();
                });
                
                return _buildErrorDialog(error);
              },
            );
          },
        ),
      ),
    );
  }

  /// Builds an elegant success dialog
  static Widget _buildSuccessDialog() {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text(
        'Order Created Successfully',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 64,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Your order has been created successfully.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          const Text(
            'Redirecting to payment gateway...',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  /// Builds an elegant loading dialog
  static Widget _buildLoadingDialog() {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text(
        'Processing Your Order',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const SizedBox(
              width: 32,
              height: 32,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'We\'re processing your ticket order.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          const Text(
            'This will only take a moment...',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  /// Builds an elegant error dialog
  static Widget _buildErrorDialog(Object error) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text(
        'Unable to Process Order',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 64,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'We encountered a problem while creating your order.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            error.toString(),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Please try again later.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}