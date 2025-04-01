import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../extensions/media_query_ext.dart';
import '../../data/providers/booking_provider.dart';
import '../widgets/booking_filter_chip.dart';
import '../widgets/booking_list.dart';

/// Main booking screen that displays user's bookings with filtering options
class Booking extends ConsumerStatefulWidget { 
  static const routeName = 'Booking';
  static const routePath = '/booking'; 
  const Booking({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BookingState();
}

class _BookingState extends ConsumerState<Booking> with TickerProviderStateMixin {
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
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        title: Text(
          'Your Bookings',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
      ),
      body: Column(
        children: [
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
    );
  }
}

class BookingFilterSection extends ConsumerWidget {
  const BookingFilterSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SizedBox(
        height: 40,
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