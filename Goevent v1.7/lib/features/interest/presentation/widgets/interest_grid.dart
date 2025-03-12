import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../provider/interest_provider.dart';
import 'interest_card.dart';

class InterestGrid extends ConsumerWidget {
  final Map<String, bool> selections;
  final Map<String, List<String>> assets;

  const InterestGrid({
    Key? key,
    required this.selections,
    required this.assets,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Wrap(
      spacing: 20.w,
      runSpacing: 20.h,
      alignment: WrapAlignment.center,
      children: selections.keys.map((interest) {
        return InterestCard(
          name: interest,
          isSelected: selections[interest]!,
          primaryImage: assets[interest]![0],
          secondaryImage: assets[interest]![1],
          onTap: () => ref.read(interestProvider.notifier).toggleInterest(interest),
        );
      }).toList(),
    );
  }
}
