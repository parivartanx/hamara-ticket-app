import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:hamaraticket/features/home/presentation/screens/bottom_nav_page.dart';
import '/extensions/media_query_ext.dart';

class PaymentFailurePage extends StatefulWidget {
  final String reason;
  static const String routeName = 'payment-failure';
  static const routeAddress = '/payment-failure';

  const PaymentFailurePage({Key? key, required this.reason}) : super(key: key);

  @override
  State<PaymentFailurePage> createState() => _PaymentFailurePageState();
}

class _PaymentFailurePageState extends State<PaymentFailurePage> with SingleTickerProviderStateMixin {
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
    // Define failure red color
    const  failureRed =  Color(0xFFE53935);
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 20, color: colorScheme.onSurface),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Payment Failed',
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
              // Failure icon with concentric circles
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
                        color: failureRed.withAlpha(20),
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
                        color: failureRed.withOpacity(0.1),
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
                        color: failureRed.withOpacity(0.2),
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
                    
                    // Center red circle with X icon
                    Container(
                      width: 60.w,
                      height: 60.w,
                      decoration: const  BoxDecoration(
                        color: failureRed,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
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
              
              // Failure text
              Text(
                'Payment Failed',
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
              
              // Error reason
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: failureRed.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: failureRed.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: failureRed,
                      size: 24.w,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        widget.reason,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: failureRed.withOpacity(0.9),
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              )
              .animate()
              .fadeIn(duration: const Duration(milliseconds: 600), delay: const Duration(milliseconds: 500))
              .moveY(begin: 20, end: 0, curve: Curves.easeOutQuad),
              
              SizedBox(height: 60.h),
              
              // Buttons
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: failureRed,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 56.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Try Again',
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
                onPressed: () => context.go(BottomNavPage.routePath),
                style: OutlinedButton.styleFrom(
                  foregroundColor: context.colorScheme.outline,
                  side: BorderSide(color: context.colorScheme.outlineVariant),
                  minimumSize: Size(double.infinity, 56.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Go Home',
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
