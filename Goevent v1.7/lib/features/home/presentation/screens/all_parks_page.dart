import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/features/home/presentation/widgets/recommended_parks_section.dart';
import '/features/home/presentation/providers/home-insights_provider.dart';
import '/features/home/presentation/widgets/shimmer_card_loading.dart';
import '/extensions/media_query_ext.dart';

class AllParksPage extends ConsumerWidget {
  static const routeName = 'all-parks';
  static const routePath = '/all-parks';
  const AllParksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeInsights = ref.watch(homeInsightsProvider);

    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'All Parks',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: context.colorScheme.onSurface,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: homeInsights.when(
        data: (data) {
          final parks = data?.recommendedParks;
          if (parks == null || parks.isEmpty) {
            return Center(
              child: Text(
                'No parks available',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: context.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            );
          }

          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16.h,
                    crossAxisSpacing: 16.w,
                    childAspectRatio: 0.85,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final park = parks[index];
                      return SizedBox(
                        width: 160.w,
                        child: RecommendedParkCard(park: park),
                      );
                    },
                    childCount: parks.length,
                  ),
                ),
              ),
            ],
          );
        },
        loading: () => const ShimmerCardLoading(title: 'Loading Parks'),
        error: (error, stack) => Center(
          child: Text(
            'Error loading parks: $error',
            style: TextStyle(
              fontSize: 16.sp,
              color: context.colorScheme.error,
            ),
          ),
        ),
      ),
    );
  }
}
