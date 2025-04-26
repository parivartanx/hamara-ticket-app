import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentSuccessPage extends StatelessWidget {
  final VoidCallback? onShowBookings;

  const PaymentSuccessPage({Key? key, this.onShowBookings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment Success')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 80.w),
            const SizedBox(height: 20),
            const Text('Your payment was successful!', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: onShowBookings ?? () => Navigator.of(context).pop(),
              child: const Text('Show My Bookings'),
            ),
          ],
        ),
      ),
    );
  }
}
