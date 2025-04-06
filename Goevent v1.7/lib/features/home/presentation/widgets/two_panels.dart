import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/extensions/media_query_ext.dart';
import '/features/home/presentation/widgets/hero_carousel_slider.dart';
import '/providers/color_provider.dart';
import '/providers/theme_provider.dart';
import 'category_games_widget.dart';
import 'collapsed_appbar_title.dart';
// import 'event_month_section.dart';
import 'expanded_appbar_header.dart';
import 'nearby_events_section.dart';
import 'best_recommendation_section.dart';

class TwoPanels extends ConsumerStatefulWidget {
  final AnimationController controller;

  const TwoPanels({Key? key, required this.controller}) : super(key: key);

  @override
  _TwoPanelsState createState() => _TwoPanelsState();
}

class _TwoPanelsState extends ConsumerState<TwoPanels>
    with TickerProviderStateMixin {
  late final ScrollController _scrollController;
  bool _isScrolled = false;
  late final String _greeting;
  // User name - in a real app, this would come from user profile or authentication
  final String _userName = "Vinita";

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    ref.read(colorProvider.notifier).getdarkmodepreviousstate();
    _greeting = _getGreeting();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset > 80 && !_isScrolled) {
      setState(() {
        _isScrolled = true;
      });
    } else if (_scrollController.offset <= 80 && _isScrolled) {
      setState(() {
        _isScrolled = false;
      });
    }
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeState = ref.watch(themeProvider);

    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: CustomScrollView(
        controller: _scrollController,
        physics: const ScrollPhysics(),
        slivers: [
          // Collapsible App Bar
          SliverAppBar(
            collapsedHeight: context.height * .08,
            expandedHeight: context.height * .34, // Increased from .30 to .35
            floating: false,
            pinned: true,
            stretch: true,
            elevation: 0,
            backgroundColor: themeState.primaryColor,
            shape: _isScrolled
                ? const RoundedRectangleBorder()
                : const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft:
                          Radius.circular(40), // Increased from 30 to 40
                      bottomRight:
                          Radius.circular(40), // Increased from 30 to 40
                    ),
                  ),
            title: _isScrolled
                ? CollapsedAppBarTitle(greeting: _greeting, userName: _userName)
                : null,
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                children: [
                  // App Bar Header
                  ExpandedAppBarHeader(
                      greeting: _greeting, userName: _userName),

                  // Add spacing between search bar and categories
                  SizedBox(height: 16.h), // Increased from 12.h to 16.h

                  // Categories Section
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: context.width * 0.04,
                        vertical: 8.0), // Increased from 4.0 to 8.0
                    child: const CategoryGamesWidget(),
                  ),
                ],
              ),
              collapseMode: CollapseMode.parallax,
            ),
          ),

          const SliverToBoxAdapter(
            child: HeroCarouselSlider(),
          ),

          // Upcoming Events Section
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 4.0), // Reduced from 8.0 to 4.0
              child: BestRecommendationSection(),
            ),
          ),

          // Nearby Events Section
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 12.h), // Reduced from 20.h to 12.h
              child: const NearbyEventsSection(),
            ),
          ),

          // Bottom Padding
          SliverToBoxAdapter(
            child: SizedBox(
                height: context.height / 150), // Reduced from 120 to 150
          ),
        ],
      ),
    );
  }
}
