import 'package:flutter/material.dart';
import '/extensions/media_query_ext.dart';
import 'app_title.dart';
import 'splash_logo.dart';

class SplashContent extends StatelessWidget {
  final ColorScheme colorScheme;

  const SplashContent({
    Key? key,
    required this.colorScheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SizedBox(height: context.height / 2.5),
          const SplashLogo(),
          SizedBox(height: context.height / 30),
          AppTitle(colorScheme: colorScheme),
        ],
      ),
    );
  }
}