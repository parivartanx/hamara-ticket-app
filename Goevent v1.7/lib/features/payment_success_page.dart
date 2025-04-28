import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '/extensions/media_query_ext.dart';
import 'home/presentation/screens/bottom_nav_page.dart';

class PaymentSuccessPage extends StatefulWidget {
  final VoidCallback? onShowBookings;
  static const String routeAddress = '/payment-success';
  static const String routeName = 'payment-success';

  final String paymentId;

  const PaymentSuccessPage({Key? key, this.onShowBookings,required this.paymentId}) : super(key: key);

  @override
  State<PaymentSuccessPage> createState() => _PaymentSuccessPageState();
}

class _PaymentSuccessPageState extends State<PaymentSuccessPage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _animationController.forward();
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    // Define success green color similar to the image
    const successGreen =  Color(0xFF22C55E);
    
    return Scaffold(
    
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 20, color: colorScheme.onSurface),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Payment Success',
          style: TextStyle(
            color: colorScheme.onSurface,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Success icon with concentric circles like in the image
              SizedBox(
                height: 200.h,
                width: 200.w,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Outermost circle
                    Container(
                      width: 180.w,
                      height: 180.w,
                      decoration: BoxDecoration(
                        color: successGreen.withOpacity(0.05),
                        shape: BoxShape.circle,
                      ),
                    )
                    .animate(controller: _animationController)
                    .scale(
                      duration: const Duration(milliseconds: 800),
                      begin: const Offset(0, 0),
                      end: const Offset(1.0, 1.0),
                      curve: Curves.elasticOut,
                    ),
                    
                    // Middle circle
                    Container(
                      width: 140.w,
                      height: 140.w,
                      decoration: BoxDecoration(
                        color: successGreen.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                    )
                    .animate(controller: _animationController)
                    .scale(
                      duration: const Duration(milliseconds: 800),
                      delay: const Duration(milliseconds: 100),
                      begin: const Offset(0, 0),
                      end: const Offset(1.0, 1.0),
                      curve: Curves.elasticOut,
                    ),
                    
                    // Inner circle
                    Container(
                      width: 100.w,
                      height: 100.w,
                      decoration: BoxDecoration(
                        color: successGreen.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                    )
                    .animate(controller: _animationController)
                    .scale(
                      duration: const Duration(milliseconds: 800),
                      delay: const Duration(milliseconds: 200),
                      begin: const Offset(0, 0),
                      end: const Offset(1.0, 1.0),
                      curve: Curves.elasticOut,
                    ),
                    
                    // Center green circle with checkmark
                    Container(
                      width: 60.w,
                      height: 60.w,
                      decoration: const BoxDecoration(
                        color: successGreen,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 30.w,
                      ),
                    )
                    .animate(controller: _animationController)
                    .scale(
                      duration: const Duration(milliseconds: 800),
                      delay: const Duration(milliseconds: 300),
                      begin: const Offset(0, 0),
                      end: const Offset(1.0, 1.0),
                      curve: Curves.elasticOut,
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 30.h),
              
              // Success text
              Text(
                'Payment Successful',
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w600,
                  color: context.colorScheme.onSurface,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              )
              .animate()
              .fadeIn(duration: const Duration(milliseconds: 600), delay: const Duration(milliseconds: 400))
              .moveY(begin: 20, end: 0, curve: Curves.easeOutQuad),
              
              SizedBox(height: 12.h),
              
              // Transaction Number
              Text(
                'Transaction Id: ${widget.paymentId}',
                style: TextStyle(
                  fontSize: 15.sp,
                  color:context.colorScheme.outline,
                ),
                textAlign: TextAlign.center,
              )
              .animate()
              .fadeIn(duration: const Duration(milliseconds: 600), delay: const Duration(milliseconds: 500))
              .moveY(begin: 20, end: 0, curve: Curves.easeOutQuad),
              
              SizedBox(height: 60.h),
              
              // Buttons
              ElevatedButton(
                onPressed: widget.onShowBookings ?? () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: successGreen,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 56.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'View My Bookings',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
              .animate()
              .fadeIn(duration: const Duration(milliseconds: 500), delay: const Duration(milliseconds: 600))
              .moveY(begin: 20, end: 0),
              
              SizedBox(height: 16.h),
              
              OutlinedButton(
                onPressed: () => context.pushNamed(BottomNavPage.routeName),
                style: OutlinedButton.styleFrom(
                  foregroundColor: successGreen,
                  side: BorderSide(color: Colors.grey.shade300),
                  minimumSize: Size(double.infinity, 56.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Return to Home',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
              .animate()
              .fadeIn(duration: const Duration(milliseconds: 500), delay: const Duration(milliseconds: 700))
              .moveY(begin: 20, end: 0),
            ],
          ),
        ),
      ),
    );
  }
}
