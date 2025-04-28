import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamaraticket/features/login/presentation/screens/login.dart';
import '../widgets/circular_animation.dart';
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

class _SplashscreenState extends ConsumerState<Splashscreen>
    with TickerProviderStateMixin {
  late final AnimationController _logoScaleController;
  late final AnimationController _rotationController;
  late final AnimationController _fadeController;
  late final AnimationController _textSlideController;

  late final Animation<double> _logoScaleAnimation;
  late final Animation<double> _rotationAnimation;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _textSlideAnimation;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  void _initializeApp() {
    _loadDarkModePreference();
    _setupAnimations();
    _navigateToNextScreen();
  }

  void _setupAnimations() {
    // Logo scale animation
    _logoScaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _logoScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoScaleController,
        curve: Curves.elasticOut,
      ),
    );

    // Rotation animation for circles
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 10000),
    );
    _rotationAnimation = Tween<double>(begin: 0, end: 2 * pi).animate(
      CurvedAnimation(
        parent: _rotationController,
        curve: Curves.linear,
      ),
    );
    _rotationController.repeat();

    // Fade animation
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: Curves.easeIn,
      ),
    );

    // Text slide animation
    _textSlideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _textSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _textSlideController,
        curve: Curves.easeOutCubic,
      ),
    );

    // Start animations with sequence
    Future.delayed(const Duration(milliseconds: 300), () {
      _logoScaleController.forward();
    });

    Future.delayed(const Duration(milliseconds: 600), () {
      _fadeController.forward();
    });

    Future.delayed(const Duration(milliseconds: 800), () {
      _textSlideController.forward();
    });
  }

  Future<void> _loadDarkModePreference() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool("setIsDark") ?? false;
    if (mounted) {
      ref.read(colorProvider.notifier).setDarkMode(isDark);
    }
  }

  void _navigateToNextScreen() {
    // call api to check is token is expired or not 
    // if token is expired then delete token user and logout from firebase 
    // else navigate to home screen
    Future.delayed(const Duration(milliseconds: 3000), () {
      if (mounted) {
        context.pushReplacementNamed(Login.routeName);
      }
    });
  }

  @override
  void dispose() {
    _logoScaleController.dispose();
    _rotationController.dispose();
    _fadeController.dispose();
    _textSlideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background circular patterns
          CircularAnimation(
            animation: _rotationAnimation,
            colorScheme: colorScheme,
          ),

          // Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo with scale animation
                ScaleTransition(
                  scale: _logoScaleAnimation,
                  child: Container(
                    width: screenSize.width * 0.4,
                    height: screenSize.width * 0.4,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: colorScheme.primary.withOpacity(0.2),
                          blurRadius: 20,
                          spreadRadius: 5,
                        )
                      ],
                    ),
                    padding: EdgeInsets.all(15.r),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.r),
                      child: Image.asset(
                        "assets/image/hamara-ticket-logo.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 40.h),

                // App name with fade and slide animations
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _textSlideAnimation,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Hamara",
                            style: TextStyle(
                              fontSize: 36.sp,
                              fontFamily: 'Gilroy ExtraBold',
                              color: colorScheme.primary,
                              letterSpacing: 1.2,
                            ),
                          ),
                          TextSpan(
                            text: " Ticket",
                            style: TextStyle(
                              fontSize: 36.sp,
                              fontFamily: 'Gilroy ExtraBold',
                              color: Colors.grey.shade800,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 16.h),

                // Tagline with fade animation
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Text(
                    "Your gateway to amazing experiences",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),

                SizedBox(height: 40.h),

                // Loading indicator with fade animation
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: SizedBox(
                    width: 40.w,
                    height: 40.h,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Version text
          Positioned(
            bottom: 20.h,
            left: 0,
            right: 0,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Center(
                child: Text(
                  "v1.0.0",
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
