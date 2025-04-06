import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamaraticket/extensions/media_query_ext.dart';
import 'package:page_transition/page_transition.dart';
import '../../../../../notification/notification.dart';
import '../../../../../providers/color_provider.dart';
import '../screens/home.dart';

class TopHeaderSection extends ConsumerWidget {
  final ColorState notifire;

  const TopHeaderSection({Key? key, required this.notifire}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: context.colorScheme.primary.withAlpha(240),
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
            ),
          ),
          height: context.height / 4.2,
          child: Column(
            children: [
              SizedBox(height: context.height / 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        z.toggle!();
                      },
                      child: Container(
                        height: context.height / 25,
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.all(7),
                          child: Image.asset(
                            "assets/image/draw.png",
                            height: context.height / 50,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: context.width * .2),
                    Column(
                      children: [
                        Text(
                          "Current Location",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontFamily: 'Gilroy Medium',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          "New York, USA",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.sp,
                            fontFamily: 'Gilroy Medium',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            child: const Note(),
                          ),
                        );
                      },
                      child: Image.asset(
                        "assets/image/bell.png",
                        height: context.height / 20,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: context.height / 50),
              _buildSearchBar(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Image.asset(
            "assets/image/search.png",
            height: context.height / 30,
          ),
          SizedBox(width: context.width / 90),
          Container(
            width: 1,
            height: context.height / 40,
            color: Colors.grey,
          ),
          SizedBox(width: context.width / 90),
          Container(
            color: Colors.transparent,
            height: context.height / 20,
            width: context.width / 1.7,
            child: TextField(
              style: TextStyle(
                fontFamily: 'Gilroy Medium',
                color: Colors.white,
                fontSize: 15.sp,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: "Search...",
                hintStyle: TextStyle(
                  fontFamily: 'Gilroy Medium',
                  color: const Color(0xffd2d2db),
                  fontSize: 15.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
