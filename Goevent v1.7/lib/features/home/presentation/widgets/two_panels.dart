import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamaraticket/extensions/media_query_ext.dart';
import 'package:hamaraticket/features/home/presentation/widgets/hero_carousel_slider.dart';
import '../../../../providers/color_provider.dart';
import 'category_games_widget.dart';
import 'collapsed_appbar_title.dart';
import 'event_month_section.dart';
import 'expanded_appbar_header.dart';
import 'nearby_events_section.dart';
import 'best_recommendation_section.dart';

class TwoPanels extends ConsumerStatefulWidget {
  final AnimationController controller;

  const TwoPanels({Key? key, required this.controller}) : super(key: key);

  @override
  _TwoPanelsState createState() => _TwoPanelsState();
}

class _TwoPanelsState extends ConsumerState<TwoPanels> with TickerProviderStateMixin {
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
    final notifire = ref.watch(colorProvider);

    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: CustomScrollView(
        controller: _scrollController,
        physics: const ScrollPhysics(),
        slivers: [
          // Collapsible App Bar
          SliverAppBar(
            collapsedHeight: context.height*.08,
            expandedHeight: context.height *.2,
            floating: false,
            pinned: true,
            stretch: true,
            elevation: 0,
            backgroundColor: context.colorScheme.primary,
            shape: _isScrolled?const RoundedRectangleBorder():const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            title: _isScrolled ? CollapsedAppBarTitle(greeting: _greeting, userName: _userName) : null,
            flexibleSpace: FlexibleSpaceBar(
              background: ExpandedAppBarHeader(greeting: _greeting, userName: _userName),
              collapseMode: CollapseMode.parallax,
            ),
          ),
          
          const SliverToBoxAdapter(
            child: HeroCarouselSlider(),
          ),
          // Category Games Section
           SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left: context.width * 0.02, top: 16.0),
              child: const CategoryGamesWidget(),
            ),
          ),
          
          // Upcoming Events Section
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: BestRecommendationSection(),
            ),
          ),
          
          // Nearby Events Section
          const SliverToBoxAdapter(
            child: Padding(
              padding:  EdgeInsets.only(top: 16.0),
              child: NearbyEventsSection(),
            ),
          ),
          
          // Events This Month Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: EventMonthSection(notifire: notifire),
            ),
          ),
          
          // Bottom Padding
          SliverToBoxAdapter(
            child: SizedBox(height: context.height / 60),
          ),
        ],
      ),
    );
  }
}



