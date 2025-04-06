import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../extensions/media_query_ext.dart';
import '../../data/providers/booking_provider.dart';
import '../widgets/booking_filter_chip.dart';
import '../widgets/booking_list.dart';
import '/features/home/presentation/widgets/advanced_bottom_navigation.dart';

/// Main booking screen that displays user's bookings with filtering options
class Booking extends ConsumerStatefulWidget {
  static const routeName = 'Booking';
  static const routePath = '/booking';
  const Booking({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BookingState();
}

class _BookingState extends ConsumerState<Booking>
    with TickerProviderStateMixin {
  late AnimationController _fadeInController;

  @override
  void initState() {
    super.initState();
    _fadeInController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
  }

  @override
  void dispose() {
    _fadeInController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(context.height * 0.18),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                colorScheme.primary,
                colorScheme.primary.withAlpha(150),
              ],
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow.withAlpha(50),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Abstract pattern elements
              Positioned(
                right: -50,
                top: -30,
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colorScheme.onPrimary.withAlpha(10),
                  ),
                ),
              ),
              Positioned(
                left: -30,
                bottom: -20,
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colorScheme.onPrimary.withAlpha(15),
                  ),
                ),
              ),
              // AppBar content
              SafeArea(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Your Bookings',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Manage your event tickets',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 8.h),
          const BookingFilterSection(),

          // Bookings list section (wrapped in animated fade-in)
          Expanded(
            child: AnimatedBuilder(
              animation: _fadeInController,
              builder: (context, child) {
                return Opacity(
                  opacity: _fadeInController.value,
                  child: child,
                );
              },
              child: const BookingList(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const AdvancedBottomNavigation(),
    );
  }
}

class BookingFilterSection extends ConsumerWidget {
  const BookingFilterSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: SizedBox(
        height: 40.h,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: const [
            BookingFilterChip(filter: BookingTimeFilter.all),
            SizedBox(width: 8),
            BookingFilterChip(filter: BookingTimeFilter.upcoming),
            SizedBox(width: 8),
            BookingFilterChip(filter: BookingTimeFilter.past),
          ],
        ),
      ),
    );
  }
}
