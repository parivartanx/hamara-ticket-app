import 'package:flutter/material.dart';
import 'package:goevent2/organizer/about.dart';
import 'package:goevent2/organizer/events.dart';
import 'package:goevent2/organizer/review.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/colornotifire.dart';

class Follow extends StatefulWidget {
  const Follow({Key? key}) : super(key: key);

  @override
  _FollowState createState() => _FollowState();
}

class _FollowState extends State<Follow>with SingleTickerProviderStateMixin {

  TabController? controller;
  List<Widget> tabs = const [
    About(),
    Event(),
    Review(),
  ];
  @override
  void initState() {
    super.initState();
    getdarkmodepreviousstate();
    controller = TabController(length: 3, vsync: this);
  }

  late ColorNotifire notifire;

  getdarkmodepreviousstate() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previusstate = prefs.getBool("setIsDark");
    if (previusstate == null) {
      notifire.setIsDark = false;
    } else {
      notifire.setIsDark = previusstate;
    }
  }


  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
      return Scaffold(
        backgroundColor: notifire.getprimerycolor,
        body: Container(
          color: Colors.transparent,
          child: Column(
            children: <Widget>[
              TabBar(
                indicatorColor: notifire.getbuttonscolor,
                 indicatorSize: TabBarIndicatorSize.label,
                controller: controller,
                labelColor: notifire.getbuttonscolor,
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
