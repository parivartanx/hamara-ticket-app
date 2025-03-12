import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../extensions/media_query_ext.dart';
import '../../providers/color_provider.dart';
import '../../utils/custom_appbar.dart';

class ShippingPolicy extends ConsumerWidget {
  static const String routePath = "/shipping-policy";
  static const String routeName = "ShippingPolicy";
  const ShippingPolicy({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(colorProvider);
    return ScreenUtilInit(
      builder: (BuildContext context, child) => Scaffold(
        backgroundColor: notifier.primaryColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.width * .04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomAppbar(title: "Shipping Policy"),
                SizedBox(height: context.height * .04),
                Text(
                  'Shipping Policy',
                  style: TextStyle(
                    color: notifier.buttonColor,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Last updated: February 23, 2025',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  'At HamaraTicket.com, we provide digital tickets for various events, concerts, and shows. Since our platform offers electronic ticketing, no physical shipping is required. Please read the details below regarding the delivery of your tickets.',
                  style: TextStyle(fontSize: 14.sp, height: 1.5.h),
                ),
                SizedBox(height: 20.h),
                _buildSection(
                  '1. TICKET DELIVERY',
                  [
                    'All tickets purchased on HamaraTicket.com are delivered electronically via email and can also be accessed through your HamaraTicket account.',
                    'Once the payment is successful, you will receive a confirmation email with the ticket details and a QR code/barcode for entry.',
                    'If you do not receive the ticket within 15 minutes of booking, please check your spam/junk folder or contact our support team.',
                  ],
                ),
                _buildSection(
                  '2. TICKET ACCESSIBILITY',
                  [
                    'Customers can download or view their tickets directly from the "My Bookings" section on the website.',
                  ],
                ),
                _buildSection(
                  '3. RESENDING TICKETS',
                  [
                    'If you lose access to your email, you can log into your HamaraTicket account and re-download the ticket.',
                    'If you still face issues, contact parivartanx.info@gmail.com with your booking details, and we will resend your ticket.',
                  ],
                ),
                _buildSection(
                  '4. INVALID OR UNRECEIVED TICKETS',
                  [
                    'If you receive an invalid or incorrect ticket, contact us immediately.',
                    'If your ticket is not delivered within 30 minutes of booking, reach out to customer support for assistance.',
                  ],
                ),
                _buildSection(
                  '5. CONTACT US',
                  [
                    'For any issues regarding ticket delivery, please contact our support team at parivartanx.info@gmail.com.',
                  ],
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<String> points) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.h),
        Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.h),
        ...points.map((point) => Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('• ', style: TextStyle(fontSize: 14.sp)),
                  Expanded(
                    child: Text(
                      point,
                      style: TextStyle(fontSize: 14.sp, height: 1.5.h),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
