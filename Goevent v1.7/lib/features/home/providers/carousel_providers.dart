import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../../../utils/string.dart';

// Model class for category items
class CategoryItem {
  final String imagePath;
  final String name;
  final Color color;

  CategoryItem({
    required this.imagePath,
    required this.name,
    required this.color,
  });
}

// Provider for the current carousel index
final carouselIndexProvider = StateProvider<int>((ref) => 0);

// Provider for carousel categories
final carouselCategoriesProvider = Provider<List<CategoryItem>>((ref) {
  return [
    CategoryItem(
      imagePath: "assets/image/1.webp",
      name: CustomStrings.musics,
      color: Colors.blue.shade400,
    ),
    CategoryItem(
      imagePath: "assets/image/2.png",
      name: CustomStrings.art,
      color: Colors.purple.shade400,
    ),
    CategoryItem(
      imagePath: "assets/image/3.png",
      name: CustomStrings.sport,
      color: Colors.green.shade400,
    ),
    // CategoryItem(
    //   imagePath: "assets/image/carousel/4.png",
    //   name: CustomStrings.party,
    //   color: Colors.orange.shade400,
    // ),
    // CategoryItem(
    //   imagePath: "assets/image/paint1.png",
    //   name: CustomStrings.food,
    //   color: Colors.red.shade400,
    // ),
    // CategoryItem(
    //   imagePath: "assets/image/other1.png",
    //   name: CustomStrings.others,
    //   color: Colors.teal.shade400,
    // ),
  ];
});

// Provider for the carousel controller
final carouselControllerProvider = Provider<CarouselSliderController>((ref) {
  return CarouselSliderController();
});
