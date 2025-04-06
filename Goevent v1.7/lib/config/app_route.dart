import 'package:go_router/go_router.dart';
import 'package:hamaraticket/features/privacy-policy/privacy_policy.dart';
import 'package:hamaraticket/features/profile/presentation/screens/profile.dart';
import 'package:hamaraticket/features/terms-and-conditions/screens/terms_and_conditions.dart';
import '../features/booking/presentation/screens/booking.dart';
import '../features/login/presentation/screens/login.dart';
import '../features/onboarding/presentation/screen/onboarding_screen.dart';
import '../features/splash-screen/presentation/screen/splashscreen.dart';
import '../features/home/presentation/screens/home.dart';
import '../features/contact/presentation/screens/contact.dart';

// GoRouter configuration
final appRouter = GoRouter(
  initialLocation: Home.routePath,
  routes: [
    GoRoute(
        path: Home.routePath,
        name: Home.routeName,
        builder: (context, state) => const Home()),
    GoRoute(
      path: Profile.routePath,
      name: Profile.routeName,
      builder: (context, state) => const Profile(),
    ),
    GoRoute(
      path: Booking.routePath,
      name: Booking.routeName,
      builder: (context, state) => const Booking(),
    ),
    GoRoute(
      path: OnboardingScreen.routePath,
      name: OnboardingScreen.routeName,
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
        path: Splashscreen.routePath,
        name: Splashscreen.routeName,
        builder: (context, state) => const Splashscreen()),
    GoRoute(
        path: PrivacyPolicyScreen.routePath,
        name: PrivacyPolicyScreen.routeName,
        builder: (context, state) => const PrivacyPolicyScreen()),
    GoRoute(
        path: TermsAndConditions.routePath,
        name: TermsAndConditions.routeName,
        builder: (context, state) => const TermsAndConditions()),
    GoRoute(
      path: Login.routePath,
      name: Login.routeName,
      builder: (context, state) => const Login(),
    ),
    GoRoute(
      path: Contact.routePath,
      name: Contact.routeName,
      builder: (context, state) => const Contact(),
    ),
  ],
);
