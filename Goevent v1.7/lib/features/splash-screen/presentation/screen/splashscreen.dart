import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hamaraticket/features/login/presentation/screens/login.dart';
import '../widgets/ripple_effect.dart';
import '../widgets/splash_content.dart';
import '/providers/color_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

class Splashscreen extends ConsumerStatefulWidget {
  static const routePath = '/splashscreen';
  static const routeName = 'splashscreen';
  const Splashscreen({Key? key}) : super(key: key);

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends ConsumerState<Splashscreen> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  void _initializeApp() {
    _loadDarkModePreference();
    _setupAnimation();
    _navigateToNextScreen();
  }

  void _setupAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _animation = Tween<double>(begin: 0.0, end: 1.5).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.forward();
  }

  Future<void> _loadDarkModePreference() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool("setIsDark") ?? false;
    if (mounted) {
      ref.read(colorProvider.notifier).setDarkMode(isDark);
    }
  }

  void _navigateToNextScreen() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        context.pushReplacementNamed(Login.routeName);
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenSize = MediaQuery.of(context).size;
    final maxRadius = sqrt(pow(screenSize.width, 2) + pow(screenSize.height, 2));

    return Scaffold(
      body: Stack(
        children: [
          RippleEffect(
            maxRadius: maxRadius,
            animation: _animation,
          ),
          SplashContent(
            colorScheme: colorScheme,
          ),
        ],
      ),
    );
  }
}




