// Collapsed App Bar Title Widget
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/notification/notification.dart';
import 'package:page_transition/page_transition.dart';
import '/extensions/media_query_ext.dart';
import '/features/home/presentation/screens/home.dart';
import '/features/home/presentation/widgets/expanded_appbar_header.dart';

class CollapsedAppBarTitle extends ConsumerWidget {
  final String greeting;
  final String userName;

  const CollapsedAppBarTitle({
    Key? key,
    required this.greeting,
    required this.userName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocation = ref.watch(locationProvider);

    return Row(
      children: [
        GestureDetector(
          onTap: () {
            z.toggle!();
          },
          child: Container(
            height: context.height * .1,
            color: Colors.transparent,
            child: const Padding(
              padding: EdgeInsets.all(5),
              child: ImageIcon(
                AssetImage("assets/image/draw.png"),
                size: 18,
              
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: context.colorScheme.onSurface,
                    fontSize: 18.sp,
                    fontFamily: 'Gilroy Medium',
                  ),
                  children: [
                    TextSpan(
                      text: "$greeting, ",
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    TextSpan(
                      text: userName,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    
                    size: 13.sp,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    currentLocation,
                    style: TextStyle(
                    
                      fontSize: 14.sp,
                      fontFamily: 'Gilroy Medium',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
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
          child: const Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(Icons.notifications),
          ),
        ),
      ],
    );
  }
}
