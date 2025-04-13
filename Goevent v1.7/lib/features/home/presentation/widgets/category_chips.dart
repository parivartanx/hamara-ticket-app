import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamaraticket/extensions/media_query_ext.dart';
import '/providers/theme_provider.dart';
import '../providers/nearby_events_provider.dart';

class CategoryChips extends ConsumerWidget {
  const CategoryChips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(nearbyEventsProvider);
    final notifier = ref.watch(nearbyEventsProvider.notifier);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          ...OccasionType.values.map((type) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(
                    _getChipLabel(type),
                    style: TextStyle(
                      color: state.selectedType == type
                          ? Colors.white
                          : context.colorScheme.onSurface,
                      fontFamily: 'Gilroy Medium',
                      fontSize: 13.sp,
                    ),
                  ),
                  selected: state.selectedType == type,
                  onSelected: (bool selected) {
                    if (selected) {
                      notifier.update((state) => state.copyWith(
                            selectedType: type,
                            filteredItems: getFilteredItems(type),
                          ));
                    }
                  },
                  backgroundColor: context.colorScheme.surfaceContainerLow,
                  selectedColor: context.colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                ),
              )),
        ],
      ),
    );
  }

  String _getChipLabel(OccasionType type) {
    switch (type) {
      case OccasionType.events:
        return "Events";
      case OccasionType.waterPark:
        return "Water Parks";
      case OccasionType.park:
        return "Parks";
    }
  }
}
