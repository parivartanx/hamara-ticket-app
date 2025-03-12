import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/extensions/media_query_ext.dart';
import '/providers/color_provider.dart';

import 'side_menu_header.dart';
import 'side_menu_items.dart';
import 'upgrade_pro_button.dart';

class Side extends ConsumerStatefulWidget {
  const Side({Key? key}) : super(key: key);

  @override
  _SideState createState() => _SideState();
}

class _SideState extends ConsumerState<Side> {
  @override
  void initState() {
    super.initState();
    ref.read(colorProvider.notifier).getdarkmodepreviousstate();
  }

  @override
  Widget build(BuildContext context) {
    final buttonColor = ref.watch(colorProvider).buttonColor;
    final proColor = ref.watch(colorProvider).proColor;
    
    return Scaffold(
      backgroundColor: buttonColor,
      body: SingleChildScrollView(
        child: ScreenUtilInit(
          designSize: Size(context.width, context.height),
          builder: (BuildContext context, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: context.height / 15),
              
              // Profile Header Section
              const SideMenuHeader(),
              
              SizedBox(height: context.height / 30),
              
              // Menu Items Section
              const SideMenuItems(),
              
              SizedBox(height: context.height / 20),
              
              // Upgrade Pro Button
              UpgradeProButton(proColor: proColor),
            ],
          ),
        ),
      ),
    );
  }
}