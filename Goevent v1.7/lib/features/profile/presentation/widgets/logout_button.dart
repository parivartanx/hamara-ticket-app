import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../config/auth/google_signin_auth.dart';
import '../../../login/data/data_sources/local_datasource.dart';
import '../../../login/presentation/screens/login.dart';
import '/extensions/media_query_ext.dart';

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
