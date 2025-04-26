import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentFailurePage extends StatelessWidget {
  final String reason;

  const PaymentFailurePage({Key? key, required this.reason}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment Failed')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error, color: Colors.red, size: 80.w),
            const SizedBox(height: 20),
            const Text('Payment Failed', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            Text(reason, style: const TextStyle(fontSize: 16, color: Colors.red)),
            SizedBox(height: 30.h),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}
