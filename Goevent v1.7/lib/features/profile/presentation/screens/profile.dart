import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/action_button.dart';
import '../widgets/logout_button.dart';
import '../widgets/profile_avatar.dart';
import '../widgets/section_header.dart';
import '../widgets/user_info_section.dart';
import '/features/profile/presentation/providers/profile_provider.dart';
import '/extensions/media_query_ext.dart';
import '/features/home/presentation/widgets/advanced_bottom_navigation.dart';
import '/features/login/presentation/screens/login.dart';
import 'package:go_router/go_router.dart';
import '../widgets/greeting_widget.dart';



class Profile extends ConsumerStatefulWidget {
  static const String routeName = 'Profile';
  static const String routePath = '/profile';
  const Profile({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutQuint,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(profileProvider);
    return Scaffold(
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: child,
            ),
          );
        },
        child: profileAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 60, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  'Failed to load profile',
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: context.colorScheme.error,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  e.toString(),
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    color: context.colorScheme.outline,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          data: (user) => Column(
            children: [
              Container(
                height: context.height * 0.25,
                width: context.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      context.colorScheme.secondaryContainer.withAlpha(230),
                      context.colorScheme.secondaryContainer.withAlpha(200),
                      context.colorScheme.surface
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Center(
                    child: user == null
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.person_outline, size: 60),
                              const SizedBox(height: 16),
                              Text(
                                'Not logged in',
                                style: GoogleFonts.poppins(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  color: context.colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () {
                                  context.goNamed(Login.routeName);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: context.colorScheme.primary,
                                  foregroundColor: context.colorScheme.onPrimary,
                                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text('Go to Login'),
                              ),
                            ],
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ProfileAvatar(user: user),
                            const SizedBox(height: 16),
                            GreetingWidget(
                              greeting: _getGreeting(),
                              userName: user.name,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              user.email,
                              style: GoogleFonts.poppins(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                                color: context.colorScheme.outline,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ],
                        ),
                  ),
                ),
              ),
              if (user != null)
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 24),
                          const SectionHeader(title: 'Your Information'),
                          const SizedBox(height: 16),
                          UserInfoSection(user: user),
                          const SizedBox(height: 32),
                          const SectionHeader(title: 'Quick Actions'),
                          const SizedBox(height: 16),
                          const ActionButtonsList(),
                          const SizedBox(height: 32),
                          const LogoutButton(),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AdvancedBottomNavigation(),
    );
  }
}







class ActionButtonsList extends StatelessWidget {
  const ActionButtonsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ActionButton(
          title: 'My Bookings',
          icon: FontAwesomeIcons.ticket,
          onTap: () {
            // Navigate to bookings
          },
        ),
        ActionButton(
          title: 'Wallet',
          icon: FontAwesomeIcons.wallet,
          onTap: () {
            // Navigate to wallet
          },
        ),
        ActionButton(
          title: 'Support',
          icon: FontAwesomeIcons.headset,
          onTap: () {
            // Navigate to support
          },
        ),
      ],
    );
  }
}



