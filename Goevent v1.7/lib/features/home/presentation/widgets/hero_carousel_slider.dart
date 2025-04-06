import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../screens/see_all.dart';
import '/extensions/media_query_ext.dart';
import 'package:page_transition/page_transition.dart';
import '../providers/carousel_providers.dart';

class HeroCarouselSlider extends ConsumerStatefulWidget {
  const HeroCarouselSlider({Key? key}) : super(key: key);

  @override
  ConsumerState<HeroCarouselSlider> createState() => _HeroCarouselSliderState();
}

class _HeroCarouselSliderState extends ConsumerState<HeroCarouselSlider>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(carouselIndexProvider);
    final categories = ref.watch(carouselCategoriesProvider);
    final carouselController = ref.watch(carouselControllerProvider);

    return Column(children: [
      SizedBox(
        height: context.height * .02,
      ),
      CarouselSlider(
        carouselController: carouselController,
        options: CarouselOptions(
          height: context.height * 0.12,
          aspectRatio: 16 / 9,
          viewportFraction: 0.8,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          enlargeFactor: 0.2,
          onPageChanged: (index, reason) {
            ref.read(carouselIndexProvider.notifier).state = index;
          },
          scrollDirection: Axis.horizontal,
        ),
        items: categories.map((category) {
          return Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: const All(),
                    ),
                  );
                },
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r)),
                      width: context.width,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child:
                            Image.asset(category.imagePath, fit: BoxFit.cover),
                      ),
                    );
                    // return Container(
                    //   width: context.width,
                    //   margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    //   decoration: BoxDecoration(
                    //     color: category.color.withOpacity(0.9),
                    //     borderRadius: BorderRadius.circular(20),
                    //     boxShadow: [
                    //       BoxShadow(
                    //         color: category.color.withOpacity(0.3),
                    //         blurRadius: 10,
                    //         offset: const Offset(0, 5),
                    //       ),
                    //     ],
                    //   ),
                    //   child: Stack(
                    //     children: [
                    //       // Background pattern
                    //       Positioned(
                    //         right: -20,
                    //         bottom: -20,
                    //         child: Opacity(
                    //           opacity: 0.2,
                    //           child: Image.asset(
                    //             category.imagePath,
                    //             height: context.height * 0.15,
                    //           ),
                    //         ),
                    //       ),
                    //       // Content
                    //       Padding(
                    //         padding: EdgeInsets.all(context.width * 0.05),
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           children: [
                    //             Row(
                    //               children: [
                    //                 Image.asset(
                    //                   category.imagePath,
                    //                   height: context.height * 0.06,
                    //                 ),
                    //                 SizedBox(width: context.width * 0.03),
                    //                 Column(
                    //                   crossAxisAlignment: CrossAxisAlignment.start,
                    //                   children: [
                    //                     Text(
                    //                       category.name,
                    //                       style: TextStyle(
                    //                         color: Colors.white,
                    //                         fontWeight: FontWeight.bold,
                    //                         fontSize: context.height * 0.025,
                    //                         fontFamily: 'Gilroy Bold',
                    //                       ),
                    //                     ),
                    //                     SizedBox(height: context.height * 0.005),
                    //                     Text(
                    //                       'Explore ${category.name} events',
                    //                       style: TextStyle(
                    //                         color: Colors.white.withOpacity(0.8),
                    //                         fontSize: context.height * 0.016,
                    //                         fontFamily: 'Gilroy Medium',
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ],
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //       // Overlay gradient
                    //       Positioned(
                    //         bottom: 0,
                    //         left: 0,
                    //         right: 0,
                    //         child: Container(
                    //           height: context.height * 0.05,
                    //           decoration: BoxDecoration(
                    //             gradient: LinearGradient(
                    //               begin: Alignment.topCenter,
                    //               end: Alignment.bottomCenter,
                    //               colors: [
                    //                 Colors.transparent,
                    //                 category.color.withOpacity(0.8),
                    //               ],
                    //             ),
                    //             borderRadius: const BorderRadius.only(
                    //               bottomLeft: Radius.circular(20),
                    //               bottomRight: Radius.circular(20),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // );
                  },
                ),
              );
            },
          );
        }).toList(),
      ),
      SizedBox(height: context.height * 0.02),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: categories.asMap().entries.map((entry) {
          return GestureDetector(
            onTap: () {
              carouselController.jumpToPage(entry.key);
              ref.read(carouselIndexProvider.notifier).state = entry.key;
            },
            child: Container(
              width: currentIndex == entry.key ? 20.0 : 10.0,
              height: 10.0,
              margin: const EdgeInsets.symmetric(horizontal: 3.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: currentIndex == entry.key
                    ? context.colorScheme.primary
                    : context.colorScheme.primary.withOpacity(0.3),
              ),
            ),
          );
        }).toList(),
      ),
    ]);
  }
}
