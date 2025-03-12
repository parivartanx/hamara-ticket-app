import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamaraticket/extensions/media_query_ext.dart';
import '../../../../providers/color_provider.dart';
import 'category_games_widget.dart';
import 'event_month_section.dart';
import 'nearby_events_section.dart';
import 'top_header_section.dart';
import 'upcoming_events_section.dart';

class TwoPanels extends ConsumerStatefulWidget {
  final AnimationController controller;

  const TwoPanels({Key? key, required this.controller}) : super(key: key);

  @override
  _TwoPanelsState createState() => _TwoPanelsState();
}

class _TwoPanelsState extends ConsumerState<TwoPanels> with TickerProviderStateMixin {
  static const header_height = 32.0;
  late TabController tabController = TabController(length: 3, vsync: this);

  Animation<RelativeRect> getPanelAnimation(BoxConstraints constraints) {
    final height = constraints.biggest.height;
    final backPanelHeight = height - header_height;
    const frontPanelHeight = -header_height;

    return RelativeRectTween(
      begin: RelativeRect.fromLTRB(0.0, backPanelHeight, 0.0, frontPanelHeight),
      end: const RelativeRect.fromLTRB(0.0, 100, 0.0, 0.0),
    ).animate(
      CurvedAnimation(parent: widget.controller, curve: Curves.linear),
    );
  }

  @override
  void initState() {
    super.initState();
    ref.read(colorProvider.notifier).getdarkmodepreviousstate();
  }

  @override
  Widget build(BuildContext context) {
    final notifire = ref.watch(colorProvider);

    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: SingleChildScrollView(
        child: Column(
          spacing: context.height*.02,
          children: [
            // Top Header Section with Search
            TopHeaderSection(notifire: notifire),

             Padding(
              padding:  EdgeInsets.only(left: context.width * 0.02),
              child: const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CategoryGamesWidget(),
                  ],
                ),
              ),
            ),

            // Upcoming Events Section
            const UpcomingEventsSection(),


            // Nearby Events Section
            NearbyEventsSection(notifire: notifire),


            // Events This Month Section
            EventMonthSection(notifire: notifire),

            SizedBox(height: context.height / 60),
          ],
        ),
      ),
    );
  }
}