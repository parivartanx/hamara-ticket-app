import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goevent2/organizer/about.dart';
import 'package:goevent2/organizer/events.dart';
import 'package:goevent2/organizer/review.dart';
import 'package:goevent2/providers/color_provider.dart';


class Follow extends ConsumerStatefulWidget {
  const Follow({Key? key}) : super(key: key);

  @override
  _FollowState createState() => _FollowState();
}

class _FollowState extends ConsumerState<Follow>with SingleTickerProviderStateMixin {

  TabController? controller;
  List<Widget> tabs = const [
    About(),
    Event(),
    Review(),
  ];
  @override
  void initState() {
    super.initState();
    ref.read(colorProvider.notifier).getdarkmodepreviousstate();
    controller = TabController(length: 3, vsync: this);
  }



  @override
  Widget build(BuildContext context) {
    final notifire = ref.watch(colorProvider);
      return Scaffold(
        backgroundColor: notifire.primaryColor,
        body: Container(
          color: Colors.transparent,
          child: Column(
            children: <Widget>[
              TabBar(
                indicatorColor: notifire.buttonsColor,
                 indicatorSize: TabBarIndicatorSize.label,
                controller: controller,
                labelColor: notifire.buttonsColor,
                unselectedLabelColor: Colors.grey,
                tabs: const [
                  Tab(text: "About"),
                  Tab(text: "Event"),
                  Tab(text: "REVIEW"),
                ],
              ),
              Expanded(
                child: Container(
                  color: Colors.transparent,
                  child: TabBarView(
                    controller: controller,
                    children: tabs.map((tab) => tab).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}
