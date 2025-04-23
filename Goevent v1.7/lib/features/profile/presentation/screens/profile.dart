import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/extensions/media_query_ext.dart';
import '/models/user_model.dart';
import '/features/home/presentation/widgets/advanced_bottom_navigation.dart';
import '/features/login/presentation/screens/login.dart';
import '/features/login/data/data_sources/local_datasource.dart';
import '/config/auth/google_signin_auth.dart';
import 'package:go_router/go_router.dart';

// A provider to store the current user
final userProvider = StateProvider<User>((ref) {
  // This is dummy data. In a real app, this would be fetched from a repository
  return User(
    id: 'user123',
    name: 'Vinita Bharti',
    email: 'vinita.bharti@example.com',
    phone: '+91 9876543210',
  );
});

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
    final user = ref.watch(userProvider);

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
        child: Column(
          children: [
            // Fixed header section (non-collapsible)
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
              child: Stack(
                children: [
                  
                  // Profile content
                  SafeArea(
                    child: Center(
                      child: Column(
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
                              color:
                                  context.colorScheme.outline,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Scrollable content
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
      bottomNavigationBar: const AdvancedBottomNavigation(),
    );
  }
}

class ProfileAvatar extends StatelessWidget {
  final User user;

  const ProfileAvatar({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'profile-pic',
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: context.colorScheme.onPrimary.withAlpha(150),
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: context.colorScheme.shadow.withAlpha(10),
              blurRadius: 10,
              spreadRadius: 0,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: CircleAvatar(
          radius: 40,
          backgroundColor: context.colorScheme.surface,
          child: ClipOval(
            child: Image.asset(
              'assets/images/default_profile.png',
              errorBuilder: (context, error, stackTrace) => Icon(Icons.person,
                  size: 40, color: context.colorScheme.outline),
              fit: BoxFit.cover,
              width: 80,
              height: 80,
            ),
          ),
        ),
      ),
    );
  }
}

class GreetingWidget extends StatelessWidget {
  final String greeting;
  final String userName;

  const GreetingWidget({
    super.key,
    required this.greeting,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '$greeting, $userName',
      style: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: context.colorScheme.onSurface,
        letterSpacing: 0.3,
        height: 1.1,
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: context.colorScheme.onSurface,
        letterSpacing: 0.2,
      ),
    );
  }
}

class UserInfoSection extends StatelessWidget {
  final User user;

  const UserInfoSection({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InfoCard(
          icon: Icons.phone_outlined,
          title: 'Phone',
          subtitle: user.phone ?? 'Not provided',
        ),
        InfoCard(
          icon: Icons.mail_outline_rounded,
          title: 'Email',
          subtitle: user.email,
        ),
      ],
    );
  }
}

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      color: context.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: context.colorScheme.outlineVariant.withAlpha(100),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: context.colorScheme.primary.withAlpha(30),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: context.colorScheme.primary,
                size: 18.sp,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      color: context.colorScheme.outline,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: context.colorScheme.onSurface,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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

class ActionButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const ActionButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: context.colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: context.colorScheme.shadow.withAlpha(10),
                offset: const Offset(0, 1),
                blurRadius: 3,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: context.colorScheme.primary.withAlpha(30),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: FaIcon(
                    icon,
                    color: context.colorScheme.primary,
                    size: 14.sp,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: context.colorScheme.onSurface,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14,
                  color: context.colorScheme.onSurface.withAlpha(100),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LogoutButton extends ConsumerWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: TextButton.icon(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: context.colorScheme.surface,
              title: Text(
                'Log Out',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: context.colorScheme.onSurface,
                ),
              ),
              content: Text(
                'Are you sure you want to log out?',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: context.colorScheme.outline,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.poppins(
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    // Clear auth data
                    await ref.read(localDataSourceProvider).clearAuthData();
                    // Sign out from Google if using Google Sign-in
                    await GoogleSignInAuth().signOut();

                    if (context.mounted) {
                      // Close the dialog
                      Navigator.pop(context);
                      // Navigate to login screen
                      context.goNamed(Login.routeName);
                    }
                  },
                  child: Text(
                    'Log Out',
                    style: GoogleFonts.poppins(
                      color: context.colorScheme.error,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        icon: Icon(
          Icons.logout_rounded,
          size: 18,
          color: context.colorScheme.primary,
        ),
        label: Text(
          'Log Out',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            color: context.colorScheme.primary,
          ),
        ),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),
    );
  }
}
