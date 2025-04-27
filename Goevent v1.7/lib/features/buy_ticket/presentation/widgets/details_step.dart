import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../profile/presentation/providers/profile_provider.dart';
import '../providers/ticket_state.dart';

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

class GuestUserForm extends StatefulWidget {
  final Function(bool?) onTermsChanged;
  final bool termsAccepted;
  
  const GuestUserForm({
    Key? key, 
    required this.onTermsChanged,
    required this.termsAccepted,
  }) : super(key: key);

  @override
  State<GuestUserForm> createState() => _GuestUserFormState();
}

class _GuestUserFormState extends State<GuestUserForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            controller: _nameController,
            label: 'Full Name',
            icon: Icons.person_outline,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          CustomTextFormField(
            controller: _emailController,
            label: 'Email Address',
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          CustomTextFormField(
            controller: _phoneController,
            label: 'Phone Number',
            icon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          Divider(color: colorScheme.outline.withOpacity(0.5)),
          const SizedBox(height: 16),
          CheckboxListTile(
            value: widget.termsAccepted,
            enabled: _formKey.currentState?.validate() ?? true,
            onChanged: widget.onTermsChanged,
            title: Text(
              'I agree to the terms and conditions',
              style: TextStyle(color: colorScheme.onSurface),
            ),
            activeColor: colorScheme.primary,
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
          ),
          const SizedBox(height: 24),
          // SizedBox(
          //   width: double.infinity,
          //   child: ElevatedButton(
          //     onPressed: () {
          //       if (_formKey.currentState!.validate() && widget.termsAccepted) {
          //         // Submit user details
          //         // You can use the controllers to get the values and process them
          //       }
          //     },
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: colorScheme.primary,
          //       foregroundColor: colorScheme.onPrimary,
          //       padding: const EdgeInsets.symmetric(vertical: 16),
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(8),
          //       ),
          //     ),
          //     child: const Text(
          //       'Continue',
          //       style: TextStyle(fontWeight: FontWeight.bold),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.label,
    required this.icon,
    this.keyboardType,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: colorScheme.primary),
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
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        filled: true,
        fillColor: colorScheme.surface,
      ),
      keyboardType: keyboardType,
      validator: validator,
    );
  }
}
