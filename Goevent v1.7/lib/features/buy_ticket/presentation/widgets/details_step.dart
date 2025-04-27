import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../profile/presentation/providers/profile_provider.dart';
import '../providers/ticket_state.dart';
import 'guest_user_form.dart';

class DetailsStep extends ConsumerStatefulWidget {
  const DetailsStep({Key? key}) : super(key: key);

  @override
  ConsumerState<DetailsStep> createState() => _DetailsStepState();
}

class _DetailsStepState extends ConsumerState<DetailsStep> {
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
      ref.read(ticketBookingProvider.notifier).setTermsAccepted(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(profileProvider);
    final bookingState = ref.watch(ticketBookingProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return profileAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (user) {
        if (user == null) {
          // Show login form instead of redirecting
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sign In',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Please sign in to continue with your booking',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                ),
                const SizedBox(height: 24),
                GuestUserForm(
                  onTermsChanged: (value) {
                    if (value == true) {
                      _showRefundPolicyDialog(context);
                    } else {
                      ref.read(ticketBookingProvider.notifier).setTermsAccepted(false);
                    }
                  },
                  termsAccepted: bookingState.termsAccepted,
                ),
              ],
            ),
          );
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
                value: bookingState.termsAccepted,
                onChanged: (value) {
                  if (value == true) {
                    _showRefundPolicyDialog(context);
                  } else {
                    ref.read(ticketBookingProvider.notifier).setTermsAccepted(false);
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
}


