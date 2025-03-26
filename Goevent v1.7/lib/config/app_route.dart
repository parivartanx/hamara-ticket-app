import 'package:go_router/go_router.dart';
import 'package:hamaraticket/privacy-policy/privacy_policy.dart';
import '../features/login/presentation/screens/login.dart';
import '../features/onboarding/presentation/screen/onboarding_screen.dart';
import '../features/splash-screen/presentation/screen/splashscreen.dart';
import '../features/home/presentation/screens/home.dart';

// GoRouter configuration
final appRouter = GoRouter(
  initialLocation: Home.routePath,
  routes: [
    GoRoute(
      path: Home.routePath
      ,name: Home.routeName ,
      builder: (context,state) => const Home()),

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
      builder: (context, state) => const Login(),
    ),
  ],
);
