import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/extensions/media_query_ext.dart';
import '/providers/color_provider.dart';
import '/features/home/presentation/widgets/advanced_bottom_navigation.dart';

class Contact extends ConsumerStatefulWidget {
  static const String routeName = 'Contact';
  static const String routePath = '/contact';
  const Contact({Key? key}) : super(key: key);

  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends ConsumerState<Contact> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    ref.read(colorProvider.notifier).getdarkmodepreviousstate();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });

      // Simulate API call
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isSubmitting = false;
        });

        // Show success dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Request Submitted',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              'Thank you for your request. Our support team will get back to you within 24-48 hours.',
              style: TextStyle(fontSize: 14.sp),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Clear form
                  _nameController.clear();
                  _emailController.clear();
                  _subjectController.clear();
                  _messageController.clear();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Scaffold(
        backgroundColor: colorScheme.surface,
        appBar: PreferredSize(
        preferredSize: Size.fromHeight(context.height * 0.08),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          context.colorScheme.primaryContainer.withAlpha(200),
                          context.colorScheme.primaryContainer.withAlpha(100),
                          context.colorScheme.surface
                        ],
                      ),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Support',
                    style: TextStyle(
                      color: colorScheme.onSurface,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const Text("How can we help today?")
                  
                ],
              ),
            ),
          ),
        ),
      ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              Padding(
                padding: EdgeInsets.all(16.r),
                child: Container(
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search for help',
                      prefixIcon:
                          Icon(Icons.search, color: colorScheme.primary),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: colorScheme.surface,
                    ),
                  ),
                ),
              ),

              // Quick Help Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.r),
                child: Text(
                  'Quick Help',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.r),
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  childAspectRatio: 1.2,
                  crossAxisSpacing: 12.w,
                  mainAxisSpacing: 12.h,
                  children: [
                    _buildQuickHelpCard(
                      context,
                      icon: Icons.confirmation_number_outlined,
                      title: 'Tickets',
                      description: 'Issues with booking or tickets',
                      color: Colors.blue,
                    ),
                    _buildQuickHelpCard(
                      context,
                      icon: Icons.payment_outlined,
                      title: 'Payments',
                      description: 'Payment methods and refunds',
                      color: Colors.green,
                    ),
                    _buildQuickHelpCard(
                      context,
                      icon: Icons.event_available_outlined,
                      title: 'Events',
                      description: 'Questions about events or venues',
                      color: Colors.purple,
                    ),
                    _buildQuickHelpCard(
                      context,
                      icon: Icons.account_circle_outlined,
                      title: 'Account',
                      description: 'Profile and account settings',
                      color: Colors.orange,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.h),

              // FAQ Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.r),
                child: Text(
                  'Frequently Asked Questions',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              _buildFAQItem(
                context,
                question: 'How do I book tickets?',
                answer:
                    'You can book tickets by selecting an event and clicking on the "Book Now" button.',
              ),
              _buildFAQItem(
                context,
                question: 'What payment methods are accepted?',
                answer:
                    'We accept credit cards, debit cards, and digital wallets.',
              ),
              _buildFAQItem(
                context,
                question: 'How can I cancel my booking?',
                answer:
                    'You can cancel your booking through the "My Bookings" section.',
              ),

              SizedBox(height: 24.h),

              // Support Request Form
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.r),
                child: Text(
                  'Raise a Support Request',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              _buildSupportRequestForm(context),

              SizedBox(height: 24.h),
            ],
          ),
        ),
        bottomNavigationBar: const AdvancedBottomNavigation(),
      );
    
  }

  Widget _buildSupportRequestForm(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.r),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Submit your request and our team will get back to you within 24-48 hours.',
              style: TextStyle(
                fontSize: 14.sp,
                color: context.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            SizedBox(height: 16.h),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Your Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                prefixIcon:
                    Icon(Icons.person, color: context.colorScheme.primary),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            SizedBox(height: 12.h),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email Address',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                prefixIcon:
                    Icon(Icons.email, color: context.colorScheme.primary),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            SizedBox(height: 12.h),
            TextFormField(
              controller: _subjectController,
              decoration: InputDecoration(
                labelText: 'Subject',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                prefixIcon:
                    Icon(Icons.subject, color: context.colorScheme.primary),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a subject';
                }
                return null;
              },
            ),
            SizedBox(height: 12.h),
            TextFormField(
              controller: _messageController,
              decoration: InputDecoration(
                labelText: 'Message',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                alignLabelWithHint: true,
                prefixIcon:
                    Icon(Icons.message, color: context.colorScheme.primary),
              ),
              maxLines: 5,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your message';
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
            SizedBox(
              width: double.infinity,
              height: 45.h,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.colorScheme.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: _isSubmitting
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20.r,
                            height: 20.r,
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Submitting...',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      )
                    : Text(
                        'Submit Request',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickHelpCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          // Handle category tap
        },
        borderRadius: BorderRadius.circular(12.r),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withOpacity(0.1),
                color.withOpacity(0.2),
              ],
            ),
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.1),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(12.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(6.r),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Icon(
                        icon,
                        color: color,
                        size: 22.r,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: color.withOpacity(0.7),
                      size: 14.r,
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  title,
                  style: TextStyle(
                    color: color.withOpacity(0.8),
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Expanded(
                  child: Text(
                    description,
                    style: TextStyle(
                      color: context.colorScheme.onSurface.withOpacity(0.6),
                      fontSize: 11.sp,
                      height: 1.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFAQItem(
    BuildContext context, {
    required String question,
    required String answer,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.r, vertical: 8.h),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ExpansionTile(
        title: Text(
          question,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: context.colorScheme.onSurface,
          ),
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Text(
              answer,
              style: TextStyle(
                fontSize: 14.sp,
                color: context.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
