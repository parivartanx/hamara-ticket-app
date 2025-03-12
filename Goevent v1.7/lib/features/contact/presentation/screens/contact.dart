import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/contact_app_bar.dart';
import '../widgets/contact_info.dart';
import '/extensions/media_query_ext.dart';
import '/providers/color_provider.dart';


class Contact extends ConsumerStatefulWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends ConsumerState<Contact> {
  @override
  void initState() {
    super.initState();
    ref.read(colorProvider.notifier).getdarkmodepreviousstate();
  }

  @override
  Widget build(BuildContext context) {
    final height = context.height;
    final width = context.width;

    return ScreenUtilInit(
      builder: (BuildContext context, child) => Scaffold(
        backgroundColor: context.colorScheme.surface,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: height / 20),
              ContactAppBar(width: width),
              SizedBox(height: height / 2.5),
              const ContactInfo(),
            ],
          ),
        ),
      ),
    );
  }
}



