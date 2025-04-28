import 'package:flutter/material.dart';

import '../../../login/presentation/widgets/custom_text_field.dart';

class GuestUserForm extends StatefulWidget {
  final Function(bool?) onTermsChanged;
  final bool termsAccepted;
  final TextEditingController _nameController;
  final TextEditingController _emailController;
  final TextEditingController _phoneController;
  
  const GuestUserForm({
    Key? key, 
    required this.onTermsChanged,
    required this.termsAccepted,
    required TextEditingController emailController,
    required TextEditingController nameController,
    required TextEditingController phoneController,
  }) : _phoneController = phoneController, _emailController = emailController, _nameController = nameController, super(key: key);

  @override
  State<GuestUserForm> createState() => _GuestUserFormState();
}

class _GuestUserFormState extends State<GuestUserForm> {
  final _formKey = GlobalKey<FormState>();
 
  
  @override
  void dispose() {
  
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
            controller: widget._nameController,
            hint: 'Full Name',
            prefixIcon: Icons.person_outline,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: widget._emailController,
            hint: 'Email Address',
            prefixIcon: Icons.email_outlined,
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
          CustomTextField(
            controller: widget._phoneController,
            hint: 'Phone Number',
            prefixIcon: Icons.phone_outlined,
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
         ],
      ),
    );
  }
}
