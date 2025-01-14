import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goevent2/booking/comings.dart';
import 'package:goevent2/extensions/media_query_ext.dart';

import '../providers/color_provider.dart';

class Upcoming extends ConsumerStatefulWidget {
  const Upcoming({Key? key}) : super(key: key);

  @override
  _UpcomingState createState() => _UpcomingState();
}

class _UpcomingState extends ConsumerState<Upcoming> {



  @override
  void initState() {
    super.initState();
    ref.read(colorProvider.notifier).getdarkmodepreviousstate();
  }

  @override
  Widget build(BuildContext context) {
    final notifire = ref.watch(colorProvider);
    final height = context.height;
    final width = context.width;
    return ScreenUtilInit(
      builder: (BuildContext context, child) => Scaffold(
        backgroundColor: notifire.primaryColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height / 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: width / 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child:
                        Icon(Icons.arrow_back, color: notifire.darksColor),
                  ),
                  SizedBox(
                    width: width / 80,
                  ),
                  Text(
                    "My Booking",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Gilroy Medium',
                      color: notifire.darksColor,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.more_vert,
                    color: notifire.darksColor,
                  ),
                  SizedBox(
                    width: width / 20,
                  ),
                ],
              ),
              SizedBox(
                height: height / 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  height: MediaQuery.of(context).size.height / 1.125,
                  width: MediaQuery.of(context).size.width,
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 55,
                          width: MediaQuery.of(context).size.width * 0.90,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xffdcdbdb),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: TabBar(
                            // indicatorColor: Colors.green,
                            indicatorSize: TabBarIndicatorSize.tab,
                            labelStyle: const TextStyle(
                              fontFamily: 'Gilroy Bold',
                              fontSize: 15,
                              color: Colors.white,
                            ),
                            indicatorPadding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 2),
                            dividerColor: Colors.transparent,
                            unselectedLabelColor: Colors.grey,
                            indicator: BoxDecoration(
                              color: notifire.buttonsColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            tabs: [
                              Tab(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  height:
                                      MediaQuery.of(context).size.height / 19,
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  child: const Center(
                                    child: Text(
                                      "UPCOMING",
                                      style: TextStyle(
                                        fontFamily: 'Gilroy Bold',
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Tab(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  height:
                                      MediaQuery.of(context).size.height / 19,
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  child: const Center(
                                    child: Text(
                                      "PAST EVENTS",
                                      style: TextStyle(
                                          fontFamily: 'Gilroy Bold',
                                          fontSize: 15),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Expanded(
                          child: TabBarView(
                            children: <Widget>[
                              Comings(),
                              Comings(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
