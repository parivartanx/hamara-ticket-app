import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../extensions/media_query_ext.dart';
import '../widgets/booking_list.dart';
import '/features/home/presentation/widgets/advanced_bottom_navigation.dart';
import '/features/profile/presentation/providers/profile_provider.dart';
import '/features/login/presentation/screens/login.dart';

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
    final userState = ref.watch(profileProvider);

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
      body: userState.when(
        data: (user) {
          if (user == null) {
            // User is not logged in, show login prompt
            return _buildLoginPrompt(context);
          } else {
            // User is logged in, show booking list
            return Column(
              children: [
                Expanded(
                  child: FadeTransition(
                    opacity: _fadeInController,
                    child: const BookingList(),
                  ),
                ),
              ],
            );
          }
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Text('Error: ${error.toString()}'),
        ),
      ),
      bottomNavigationBar: const AdvancedBottomNavigation(),
    );
  }

  Widget _buildLoginPrompt(BuildContext context) {
    return FadeTransition(
      opacity: _fadeInController,
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.account_circle_outlined,
                size: 80.sp,
                color: context.colorScheme.primary,
              ),
              SizedBox(height: 16.h),
              Text(
                'Please Login to View Your Bookings',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: context.colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'You need to be logged in to see your booking history and manage your tickets.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: 32.h),
              ElevatedButton(
                onPressed: () {
                  context.pushNamed(Login.routeName);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.colorScheme.primary,
                  foregroundColor: context.colorScheme.onPrimary,
                  padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Login Now',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class BookingFilterSection extends ConsumerWidget {
//   const BookingFilterSection({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
//       child: SizedBox(
//         height: 36.h,
//         child: ListView(
//           scrollDirection: Axis.horizontal,
//           children: const [
//             BookingFilterChip(filter: BookingTimeFilter.all),
//             SizedBox(width: 8),
//             BookingFilterChip(filter: BookingTimeFilter.upcoming),
//             SizedBox(width: 8),
//             BookingFilterChip(filter: BookingTimeFilter.past),
//           ],
//         ),
//       ),
//     );
//   }
// }
