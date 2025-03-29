import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../screens/see_all.dart';
import '/extensions/media_query_ext.dart';
import 'package:page_transition/page_transition.dart';

class CategoryGamesWidget extends ConsumerWidget {

  const CategoryGamesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: context.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Categories',
                style: TextStyle(
                  fontSize: context.height * 0.022,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Gilroy Bold',
                ),
              ),
            ],
          ),
        ),
      SizedBox(height: context.height * 0.01),
      
         SingleChildScrollView(
          scrollDirection: Axis.horizontal,
           child: Wrap(
            spacing: 10.w,
            children: const [
              GameCategoryItem(
                imagePath: "assets/image/park.webp",
                name: "Parks",
              ),
              GameCategoryItem(
                imagePath: "assets/image/water-park.webp",
                name: "Water Parks",
              ),
              GameCategoryItem(
                imagePath: "assets/image/events.webp",
                name: "Events",
              ),
            ],
                   ),
         ),
      ],
    );
  }
}

class GameCategoryItem extends StatelessWidget {
  final String imagePath;
  final String name;

  const GameCategoryItem({
    Key? key,
    required this.imagePath,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                child: const All(),
              ),
            );
          },
          child: SizedBox(
            width: context.width / 3.4,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: context.colorScheme.surfaceContainerLow,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: context.height * 0.02),
                  CircleAvatar(
                    backgroundImage: AssetImage(
                      imagePath,
                    ),
                    radius: context.height * 0.04,
                  ),
                  SizedBox(height: context.height * 0.01),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: context.width * 0.04),
                    padding: EdgeInsets.symmetric(vertical: context.width * 0.015),
                    decoration: BoxDecoration(
                      color: context.colorScheme.primary,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        name,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: context.height / 70,
                          fontFamily: 'Gilroy Normal',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: context.height / 100),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}