import 'package:go_router/go_router.dart';
import 'package:hamaraticket/privacy-policy/privacy_policy.dart';
import '../features/login/presentation/screens/login.dart';
import '../features/onboarding/presentation/screen/onboarding_screen.dart';
import '../features/splash-screen/presentation/screen/splashscreen.dart';
import '../features/home/presentation/screens/home.dart';
import 'package:flutter/material.dart';

// GoRouter configuration
final appRouter = GoRouter(
  initialLocation: Splashscreen.routePath,
  routes: [
    GoRoute(path: Home.routePath,name: Home.routeName ,builder: (context,state) => const Home()),
    // GoRoute(
    //   name: Home.routeName, // Optional, add name to your routes. Allows you navigate by name instead of path
    //   path: Home.routePath,
    //   builder: (context, state) => const Home(),
    // ),

    GoRoute(
      path: OnboardingScreen.routePath,
      name: OnboardingScreen.routeName,
      builder: (context, state) => const OnboardingScreen(),
    ),

    GoRoute(         
        path: Splashscreen.routePath,
        name: Splashscreen.routeName,
        builder: (context, state) => const Splashscreen()),
        
    GoRoute(path: PrivacyPolicy.routePath,name: PrivacyPolicy.routeName,
    builder:(context,state) => const PrivacyPolicy() ),

    GoRoute(
      path: Login.routePath,
      name: Login.routeName,
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const Login(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 300),
        key: state.pageKey,
      ),
    ),
    // GoRoute(
    //   name: 'page2',
    //   path: '/page2',
    //   builder: (context, state) => Page2Screen(),
    // ),
  ],
);
