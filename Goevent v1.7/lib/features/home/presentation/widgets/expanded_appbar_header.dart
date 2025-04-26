// Expanded App Bar Header Widget
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/extensions/media_query_ext.dart';
import '/features/home/presentation/screens/home.dart';
import '/notification/notification.dart';
import 'package:page_transition/page_transition.dart';
import 'search_bar_widget.dart';

final locationProvider = StateProvider<String>((ref) => "Patna, IND");

class ExpandedAppBarHeader extends ConsumerWidget {
  final String greeting;
  final String userName;

  const ExpandedAppBarHeader({
    Key? key,
    required this.greeting,
    required this.userName,
  }) : super(key: key);

  void _showLocationPicker(BuildContext context, WidgetRef ref) {
    final popularCities = [
      "Patna, IND",
      "Delhi, IND",
      "Mumbai, IND",
      "Bangalore, IND",
      "Kolkata, IND",
      "Chennai, IND",
      "Hyderabad, IND",
      "Pune, IND",
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Select Location',
          style: TextStyle(
            fontSize: 18.sp,
            fontFamily: 'Gilroy Medium',
            fontWeight: FontWeight.w600,
          ),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: popularCities.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons.location_on_outlined),
                title: Text(
                  popularCities[index],
                  style: TextStyle(
                    fontFamily: 'Gilroy Medium',
                    fontSize: 14.sp,
                  ),
                ),
                onTap: () {
                  ref.read(locationProvider.notifier).state =
                      popularCities[index];
                  Navigator.pop(context);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocation = ref.watch(locationProvider);

    return Container(
      // decoration: BoxDecoration(
      //   color: Colors
      //       .transparent, // Make background transparent since parent has gradient
      //   borderRadius: const BorderRadius.only(
      //     bottomRight: Radius.circular(30),
      //     bottomLeft: Radius.circular(30),
      //   ),
      // ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: context.height / 50),
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
                      child: const Padding(
                        padding: EdgeInsets.all(7),
                        child: ImageIcon(
                          AssetImage("assets/image/draw.png"),
                          
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: context.width * .05),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500),
                              ),
                              TextSpan(
                                text: userName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        GestureDetector(
                          onTap: () => _showLocationPicker(context, ref),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                currentLocation,
                                style: TextStyle(
                                  
                                  fontSize: 13.sp,
                                  fontFamily: 'Gilroy Medium',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const Icon(
                                Icons.keyboard_arrow_down,
                              
                                size: 14,
                              ),
                            ],
                          ),
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
                    child: const Icon(
                      Icons.notifications,
                      
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: context.height / 30),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SearchBarWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
