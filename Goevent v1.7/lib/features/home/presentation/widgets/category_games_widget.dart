import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/extensions/media_query_ext.dart';
import '../providers/recommended_categories_provider.dart';
import '/providers/theme_provider.dart';

class GameCategoryItem {
  final String name;
  final IconData icon;
  final Color lightModeColor;
  final Color darkModeColor;
  final List<Color> lightGradientColors;
  final CategoryType categoryType;

  const GameCategoryItem({
    required this.name,
    required this.icon,
    required this.lightModeColor,
    required this.darkModeColor,
    required this.lightGradientColors,
    required this.categoryType,
  });
}

class CategoryGamesWidget extends ConsumerWidget {
  const CategoryGamesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

   const  categories =   [
      GameCategoryItem(
        name: "All",
        icon: Icons.confirmation_number,
        lightModeColor: const Color.fromARGB(255, 158, 30, 58),
        darkModeColor: const Color.fromARGB(255, 223, 131, 155),
        lightGradientColors: const [
          Color.fromARGB(255, 223, 131, 155),
          Color.fromARGB(255, 241, 98, 148)
        ],
        categoryType: CategoryType.all,
      ),
      GameCategoryItem(
        name: "Parks",
        icon: Icons.park,
        lightModeColor: const Color(0xFF4CAF50),
        darkModeColor: const Color(0xFF81C784),
        lightGradientColors: const [Color.fromARGB(255, 176, 223, 179), Color(0xFF81C784)],
        categoryType: CategoryType.parks,
      ),
      GameCategoryItem(
        name: "Water\nPark",
        icon: Icons.water,
        lightModeColor: const Color(0xFF2196F3),
        darkModeColor: const Color(0xFF64B5F6),
        lightGradientColors: const [
          Color.fromARGB(255, 144, 179, 214),
          Color(0xFF64B5F6)
        ],
        categoryType: CategoryType.waterParks,
      ),
      GameCategoryItem(
        name: "Events",
        icon: Icons.event,
        lightModeColor: const Color(0xFF9C27B0),
        darkModeColor: const Color(0xFFBA68C8),
        lightGradientColors: const [Color.fromARGB(255, 207, 154, 229), Color(0xFFBA68C8)],
        categoryType: CategoryType.events,
      ),
    ];

    final selectedCategory = ref.watch(recommendedCategoriesProvider).selectedCategory;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((category) {
          final isSelected = selectedCategory == category.categoryType;
          return GestureDetector(
            onTap: () {
              ref.read(recommendedCategoriesProvider.notifier).selectCategory(category.categoryType);
              // ref.read(themeProvider.notifier).updateTheme(
              //       isDarkMode ? category.darkGradientColors[1] : category.lightGradientColors[1],
              //     );
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
                      ? category.lightGradientColors
                      : isDarkMode
                          ? [
                              colorScheme.surface,
                              colorScheme.onSurface,
                            ]
                          : [
                              Colors.grey.shade300,
                              Colors.grey.shade200,
                            ],
                ),
                borderRadius: BorderRadius.circular(13.r),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: (isDarkMode ? category.darkModeColor : category.lightModeColor).withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: (isDarkMode ? Colors.black12 : Colors.grey.withOpacity(0.2)),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
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
                                Colors.white.withAlpha(isDarkMode ? 10 : 20),
                                Colors.white.withAlpha(0),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          category.icon,
                          color: isSelected 
                              ? Colors.white 
                              : isDarkMode 
                                  ? Colors.grey.shade400
                                  : Colors.grey.shade600,
                          size: 21.r,
                        ),
                        SizedBox(height: 6.5.h),
                        Text(
                          category.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : isDarkMode
                                    ? Colors.grey.shade400
                                    : Colors.grey.shade600,
                            fontSize: 11.sp,
                            fontWeight: isSelected ? FontWeight.w900 : FontWeight.w700,
                            fontFamily: 'Gilroy',
                            letterSpacing: 0.8,
                            height: 1.1,
                            shadows: isSelected
                                ? [
                                    Shadow(
                                      color: Colors.black.withOpacity(isDarkMode ? 0.5 : 0.3),
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
