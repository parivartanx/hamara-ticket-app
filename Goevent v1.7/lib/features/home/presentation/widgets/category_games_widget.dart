import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/extensions/media_query_ext.dart';
import '../providers/recommended_categories_provider.dart';
import '/providers/theme_provider.dart';

class GameCategoryItem {
  final String name;
  final IconData icon;
  final Color color;
  final List<Color> gradientColors;
  final CategoryType categoryType;

  const GameCategoryItem({
    required this.name,
    required this.icon,
    required this.color,
    required this.gradientColors,
    required this.categoryType,
  });
}

class CategoryGamesWidget extends ConsumerWidget {
  const CategoryGamesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = [
      const GameCategoryItem(
        name: "All",
        icon: Icons.confirmation_number,
        color: Color.fromARGB(255, 158, 30, 58),
        gradientColors: [
          Color.fromARGB(255, 177, 46, 81),
          Color.fromARGB(255, 241, 98, 148)
        ],
        categoryType: CategoryType.all,
      ),
      const GameCategoryItem(
        name: "Parks",
        icon: Icons.park,
        color: Color(0xFF4CAF50),
        gradientColors: [Color.fromARGB(255, 60, 88, 61), Color(0xFF81C784)],
        categoryType: CategoryType.parks,
      ),
      const GameCategoryItem(
        name: "Water\nPark",
        icon: Icons.water,
        color: Color(0xFF2196F3),
        gradientColors: [
          Color.fromARGB(255, 83, 143, 191),
          Color.fromARGB(255, 141, 198, 245)
        ],
        categoryType: CategoryType.waterParks,
      ),
      const GameCategoryItem(
        name: "Events",
        icon: Icons.event,
        color: Color(0xFF9C27B0),
        gradientColors: [Color.fromARGB(255, 135, 56, 138), Color(0xFFBA68C8)],
        categoryType: CategoryType.events,
      ),
    ];

    final selectedCategory =
        ref.watch(recommendedCategoriesProvider).selectedCategory;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((category) {
          final isSelected = selectedCategory == category.categoryType;
          return GestureDetector(
            onTap: () {
              ref
                  .read(recommendedCategoriesProvider.notifier)
                  .selectCategory(category.categoryType);
              // Update theme when category is selected
              ref.read(themeProvider.notifier).updateTheme(
                    category.gradientColors[0],
                    category.gradientColors[1],
                  );
            },
            child: Container(
              width: 70.w,
              height: 70.h,
              margin: EdgeInsets.symmetric(horizontal: 7.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                  colors: isSelected
                      ? category.gradientColors
                      : [
                          Colors.grey.shade300,
                          Colors.grey.shade200,
                        ],
                ),
                borderRadius: BorderRadius.circular(13.r),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: category.color.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Shine effect for selected category
                  if (isSelected)
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(13.r),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomRight,
                              end: Alignment.topLeft,
                              colors: [
                                Colors.white.withOpacity(0.2),
                                Colors.white.withOpacity(0.0),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  // Main content
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          category.icon,
                          color:
                              isSelected ? Colors.white : Colors.grey.shade600,
                          size: 21.r,
                        ),
                        SizedBox(height: 6.5.h),
                        Text(
                          category.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : Colors.grey.shade600,
                            fontSize: 11.sp,
                            fontWeight:
                                isSelected ? FontWeight.w900 : FontWeight.w700,
                            fontFamily: 'Gilroy',
                            letterSpacing: 0.8,
                            height: 1.1,
                            shadows: isSelected
                                ? [
                                    Shadow(
                                      color: Colors.black.withOpacity(0.3),
                                      offset: const Offset(0, 1),
                                      blurRadius: 2,
                                    ),
                                  ]
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
