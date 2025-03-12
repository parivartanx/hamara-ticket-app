import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamaraticket/extensions/media_query_ext.dart';
import 'package:hamaraticket/features/home/seeall.dart';
import 'package:page_transition/page_transition.dart';
import '../../../../../utils/string.dart';

class CategoryGamesWidget extends ConsumerWidget {

  const CategoryGamesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Row(
      children: [
        GameCategoryItem(
          imagePath: "assets/image/music1.png",
          name: CustomStrings.musics,
        ),
        GameCategoryItem(
          imagePath: "assets/image/paint1.png",
          name: CustomStrings.art,
        ),
        GameCategoryItem(
          imagePath: "assets/image/sport1.png",
          name: CustomStrings.sport,
        ),
        GameCategoryItem(
          imagePath: "assets/image/party1.png",
          name: CustomStrings.party,
        ),
        GameCategoryItem(
          imagePath: "assets/image/paint1.png",
          name: CustomStrings.food,
        ),
        GameCategoryItem(
          imagePath: "assets/image/other1.png",
          name: CustomStrings.others,
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
            height: context.height / 5.9,
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
                  Image.asset(
                    imagePath,
                    height: context.height * 0.07,
                  ),
                  SizedBox(height: context.height * 0.02),
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