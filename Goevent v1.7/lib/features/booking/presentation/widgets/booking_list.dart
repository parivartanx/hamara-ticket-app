import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamaraticket/extensions/media_query_ext.dart';
import '../../../../models/booking/booking_model.dart';
import '../../../profile/presentation/providers/profile_provider.dart';
import '../providers/bookings_provider.dart';
import 'booking_card.dart';

/// A dedicated widget for the bookings list with optimized rebuilds
class BookingList extends ConsumerWidget {
  const BookingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(profileProvider).when(
          data: (profile) => profile?.id,
          loading: () => null,
          error: (_, __) => null,
        );
    log("userId: $userId");
    final bookings = ref.watch(bookingsProvider(userId ?? ''));
    // Only watch the filtered bookings provider in this widget

    // if (filteredBookings.isEmpty) {
    //   return const BookingEmptyState();
    // }

    return bookings.when(
      data: (bookings) => _BookingListContent(bookings: bookings),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const Center(child: Text('Error loading bookings')),
    );
  }
}

/// Inner content widget to avoid rebuilding the ListView when not needed
class _BookingListContent extends StatelessWidget {
  final List<BookingModel> bookings;

  const _BookingListContent({
    Key? key,
    required this.bookings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Summary section
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
          child: Row(
            children: [
              Text(
                'Found ${bookings.length} bookings',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade700,
                ),
              ),
              const Spacer(),
              // Additional controls could go here - like a sort button
            ],
          ),
        ),

        // Divider
        Divider(
          height: 1.h,
          thickness: 1.h,
          color: context.colorScheme.outlineVariant,
          indent: 20.w,
          endIndent: 20.w,
        ),

        // Main list
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.only(
              top: 8.h,
              bottom: 16.h,
            ),
            physics: const ScrollPhysics(),
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              final booking = bookings[index];
              return BookingCard(
                booking: booking,
                animationDelay: index * 0.1,
              );
            },
          ),
        ),
      ],
    );
  }
}
