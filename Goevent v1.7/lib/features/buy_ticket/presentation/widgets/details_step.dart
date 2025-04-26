import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../profile/presentation/providers/profile_provider.dart';

class DetailsStep extends ConsumerStatefulWidget {
  const DetailsStep({Key? key}) : super(key: key);

  @override
  ConsumerState<DetailsStep> createState() => _DetailsStepState();
}

class _DetailsStepState extends ConsumerState<DetailsStep> {
  bool _acceptedRefundPolicy = false;

  void _showRefundPolicyDialog(BuildContext context) async {
    final colorScheme = Theme.of(context).colorScheme;
    final accepted = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Refund Policy'),
        content: const Text(
          'Tickets are only refundable if the event or park day is cancelled. Do you accept this policy?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Decline'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
            ),
            child: const Text('Accept'),
          ),
        ],
      ),
    );
    if (accepted == true) {
      setState(() {
        _acceptedRefundPolicy = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(profileProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return profileAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (user) {
        if (user == null) {
          Future.microtask(() {
            if (context.mounted) {
              Navigator.of(context).pushReplacementNamed('/login');
            }
          });
          return const SizedBox.shrink();
        }
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Details',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Please confirm your details',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
              ),
              const SizedBox(height: 24),
              _buildUserDetails(context, user),
              const SizedBox(height: 24),
              Divider(color: colorScheme.outline.withOpacity(0.5)),
              const SizedBox(height: 16),
              CheckboxListTile(
                value: _acceptedRefundPolicy,
                onChanged: (value) {
                  if (value == true) {
                    _showRefundPolicyDialog(context);
                  } else {
                    setState(() {
                      _acceptedRefundPolicy = false;
                    });
                  }
                },
                title: Text(
                  'I agree to the terms and conditions',
                  style: TextStyle(color: colorScheme.onSurface),
                ),
                activeColor: colorScheme.primary,
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _acceptedRefundPolicy ? () {/* Pay Now logic */} : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Pay Now',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildUserDetails(BuildContext context, user) {
    final colorScheme = Theme.of(context).colorScheme;
    
    // This would show the logged-in user's details
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundColor: colorScheme.primary,
            child: Icon(Icons.person, color: colorScheme.onPrimary),
          ),
          title: Text(
            user.name ?? '-',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          subtitle: Text(
            user.email ?? '-',
            style: TextStyle(color: colorScheme.onSurfaceVariant),
          ),
        ),
        const SizedBox(height: 16),
        ListTile(
          leading: Icon(Icons.phone, color: colorScheme.primary),
          title: Text(
            user.phone ?? '-',
            style: TextStyle(color: colorScheme.onSurface),
          ),
          trailing: TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              foregroundColor: colorScheme.primary,
            ),
            child: const Text('Change'),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Email field
        TextField(
          decoration: InputDecoration(
            labelText: 'Email',
            labelStyle: TextStyle(color: colorScheme.onSurfaceVariant),
            hintText: 'Enter your email',
            hintStyle: TextStyle(color: colorScheme.onSurfaceVariant.withOpacity(0.6)),
            prefixIcon: Icon(Icons.email_outlined, color: colorScheme.primary),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: colorScheme.outline),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: colorScheme.outline),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: colorScheme.primary),
            ),
            filled: true,
            fillColor: colorScheme.surface,
          ),
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(color: colorScheme.onSurface),
        ),
        const SizedBox(height: 16),
        
        // Login button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 2,
              shadowColor: colorScheme.shadow,
            ),
            child: const Text(
              'Continue',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(child: Divider(color: colorScheme.outline.withOpacity(0.5))),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'OR',
                style: TextStyle(color: colorScheme.onSurfaceVariant),
              ),
            ),
            Expanded(child: Divider(color: colorScheme.outline.withOpacity(0.5))),
          ],
        ),
        const SizedBox(height: 24),
        
        // Social login buttons
        _buildSocialLoginButton(
          context,
          'Continue with Google',
          'assets/image/google.png',
          () {},
        ),
        const SizedBox(height: 12),
        _buildSocialLoginButton(
          context,
          'Continue with Facebook',
          'assets/image/facebook.png',
          () {},
        ),
      ],
    );
  }

  Widget _buildSocialLoginButton(
    BuildContext context,
    String text,
    String iconPath,
    VoidCallback onPressed,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: colorScheme.outline),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          foregroundColor: colorScheme.onSurface,
        ),
        icon: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Image.asset(
            iconPath,
            height: 24,
            width: 24,
          ),
        ),
        label: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
