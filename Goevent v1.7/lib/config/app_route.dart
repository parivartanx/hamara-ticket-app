import 'package:go_router/go_router.dart';
import 'package:hamaraticket/features/home/presentation/screens/bottom_nav_page.dart';
import '../features/payment_failure_page.dart';
import '../features/payment_success_page.dart';
import '/features/home/presentation/screens/all_parks_page.dart';
import '/features/occasion-details/presentation/screens/event_details_screen.dart';
import '/features/privacy-policy/privacy_policy.dart';
import '/features/profile/presentation/screens/profile.dart';
import '/features/terms-and-conditions/screens/terms_and_conditions.dart';
import '../features/booking/presentation/screens/booking.dart';
import '../features/login/presentation/screens/login.dart';
import '../features/occasion-details/presentation/screens/park_details_screen.dart';
import '../features/onboarding/presentation/screen/onboarding_screen.dart';
import '../features/splash-screen/presentation/screen/splashscreen.dart';
import '../features/home/presentation/screens/home.dart';
import '../features/contact/presentation/screens/contact.dart';

// GoRouter configuration
final appRouter = GoRouter(
  initialLocation: Splashscreen.routePath,
  redirect: (context,state){
    return null;
  
    /// check if route is login and user is logged in
    /// if yes redirect to home
  
  },
  routes: [

    GoRoute(path: BottomNavPage.routePath,
        name: BottomNavPage.routeName,
        builder: (context, state) => const BottomNavPage()),
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
    GoRoute(
      path: ParkDetailsScreen.routePath,
      name: ParkDetailsScreen.routeName,
      builder: (context, state) => ParkDetailsScreen(
        parkId: state.extra as String,
      ),
    ),
    GoRoute(
      path: EventDetailsScreen.routePath,
      name: EventDetailsScreen.routeName,
      builder: (context, state) => EventDetailsScreen(
        eventId: state.extra as String,
      ),
    ),
    GoRoute(
      path: AllParksPage.routePath,
      name: AllParksPage.routeName,
      builder: (context, state) => const AllParksPage(),
    ),

    // Payment Success Page
    GoRoute(
      path: PaymentSuccessPage.routeAddress,
      name: PaymentSuccessPage.routeName,
      builder: (context, state) => PaymentSuccessPage(
        paymentId: state.extra as String,
        onShowBookings: () {
          context.pushNamed(Booking.routeName);
        },
      ),
    ),

    // Payment Failure Page
    GoRoute(
      path: PaymentFailurePage.routeAddress,
      name: PaymentFailurePage.routeName,
      builder: (context, state) => PaymentFailurePage(
        reason:state.extra as String,
      ),
    ),
    
  ],
);
