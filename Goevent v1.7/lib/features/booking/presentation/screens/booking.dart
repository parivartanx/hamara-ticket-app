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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(context.height * 0.08),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          context.colorScheme.primaryContainer.withAlpha(200),
                          context.colorScheme.primaryContainer.withAlpha(100),
                          context.colorScheme.surface
                        ],
                      ),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Bookings',
                    style: TextStyle(
                      color: colorScheme.onSurface,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.5,
                    ),
                  ),
                  
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          const BookingFilterSection(),
          Expanded(
            child: FadeTransition(
              opacity: _fadeInController,
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
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: SizedBox(
        height: 36.h,
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
