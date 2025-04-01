import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../extensions/media_query_ext.dart';
import '../../data/providers/booking_provider.dart';

/// A custom filter chip widget for booking time filters
class BookingFilterChip extends ConsumerWidget {
  final BookingTimeFilter filter;
  
  const BookingFilterChip({
    Key? key,
    required this.filter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = context.colorScheme;
    final selectedFilter = ref.watch(selectedTimeFilterProvider);
    final isSelected = selectedFilter == filter;
    
    return FilterChip(
      selected: isSelected,
      showCheckmark: false,
      label: Text(filter.displayName),
      labelStyle: TextStyle(
        color: isSelected 
            ? colorScheme.onPrimary 
            : colorScheme.onSurface,
        fontWeight: FontWeight.w500,
      ),
      backgroundColor: colorScheme.surfaceVariant.withAlpha(50),
      selectedColor: colorScheme.primary,
      onSelected: (selected) {
        if (selected) {
          // Update the filter using Riverpod
          ref.read(selectedTimeFilterProvider.notifier).state = filter;
        }
      },
      padding: const EdgeInsets.symmetric(horizontal: 8),
    );
  }
}
