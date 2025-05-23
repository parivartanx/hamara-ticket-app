import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/extensions/media_query_ext.dart';
import '/features/profile/presentation/providers/profile_provider.dart';
import 'category_games_widget.dart';
import 'collapsed_appbar_title.dart';
import 'expanded_appbar_header.dart';
import 'recommended_parks_section.dart';
import 'recommended_events_section.dart';

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

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
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

  String _getUserName() {
    final userState = ref.watch(profileProvider);
    return userState.when(
      data: (user) => user?.name ?? 'Guest',
      loading: () => 'Guest',
      error: (_, __) => 'Guest',
    );
  }

  @override
  Widget build(BuildContext context) {
    final userName = _getUserName();

    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: CustomScrollView(
        controller: _scrollController,
        physics: const ScrollPhysics(),
        slivers: [
          SliverAppBar(
            collapsedHeight: context.height * .08,
            expandedHeight: context.height * .2,
            floating: false,
            pinned: true,
            stretch: true,
            elevation: 0,
            
            shape: _isScrolled
                ? const RoundedRectangleBorder()
                : const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
            title: _isScrolled
                ? CollapsedAppBarTitle(greeting: _greeting, userName: userName)
                : null,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const  BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
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
                  ),
                  Column(
                    children: [
                      ExpandedAppBarHeader(
                          greeting: _greeting, userName: userName),
                      SizedBox(height: 16.h),
                    ],
                  ),
                ],
              ),
              collapseMode: CollapseMode.pin,
            ),
          ),
          
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: context.width * 0.04,
                  vertical: 8.0),
              child: const CategoryGamesWidget(),
            ),
          ),
          // const SliverToBoxAdapter(
          //   child: HeroCarouselSlider(),
          // ),

          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: RecommendedParksSection(),
            ),
          ),

          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: RecommendedEventsSection(),
            ),
          ),

          // const SliverToBoxAdapter(
          //   child: Padding(
          //     padding: EdgeInsets.only(top: 16.0),
          //     child: NearbyEventsSection(),
          //   ),
          // ),

          SliverToBoxAdapter(
            child: SizedBox(height: context.height / 150),
          ),
        ],
      ),
    );
  }
}
