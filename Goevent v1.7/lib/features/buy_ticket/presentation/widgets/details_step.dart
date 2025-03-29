import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailsStep extends ConsumerWidget {
  const DetailsStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // This is a placeholder for user login status
    // In a real app, you would check if the user is logged in
    const bool isLoggedIn = false; 
    final colorScheme = Theme.of(context).colorScheme;

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
            isLoggedIn
                ? 'Please confirm your details'
                : 'Please login to continue',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 24),
          if (isLoggedIn) _buildUserDetails(context) else _buildLoginForm(context),
        ],
      ),
    );
  }

  Widget _buildUserDetails(BuildContext context) {
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
            'Vinita Bharti',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          subtitle: Text(
            'vinita@example.com',
            style: TextStyle(color: colorScheme.onSurfaceVariant),
          ),
        ),
        const SizedBox(height: 16),
        ListTile(
          leading: Icon(Icons.phone, color: colorScheme.primary),
          title: Text(
            '+91 98765 43210',
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
        const SizedBox(height: 24),
        Divider(color: colorScheme.outline.withOpacity(0.5)),
        const SizedBox(height: 16),
        CheckboxListTile(
          value: true,
          onChanged: (value) {},
          title: Text(
            'I agree to the terms and conditions',
            style: TextStyle(color: colorScheme.onSurface),
          ),
          activeColor: colorScheme.primary,
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
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
