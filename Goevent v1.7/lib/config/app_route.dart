import 'package:go_router/go_router.dart';
import '/login_signup/login.dart';
import '/onbonding.dart';
import '/splashscreen.dart';
import '/home/home.dart';
import 'package:flutter/material.dart';

// GoRouter configuration
final appRouter = GoRouter(
  initialLocation: Onbonding.routePath,
  routes: [
    GoRoute(path: Home.routePath,name: Home.routeName ,builder: (context,state) => const Home()),
    // GoRoute(
    //   name: Home.routeName, // Optional, add name to your routes. Allows you navigate by name instead of path
    //   path: Home.routePath,
    //   builder: (context, state) => const Home(),
    // ),

    GoRoute(
      path: Onbonding.routePath,
      name: Onbonding.routeName,
      builder: (context, state) => const Onbonding(),
    ),

    GoRoute(         
        path: Splashscreen.routePath,
        name: Splashscreen.routeName,
        builder: (context, state) => const Splashscreen()),

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
