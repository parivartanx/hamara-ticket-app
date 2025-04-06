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
  @override
  void initState() {
    super.initState();
    ref.read(colorProvider.notifier).getdarkmodepreviousstate();
  }

  @override
  Widget build(BuildContext context) {
    final height = context.height;
    final width = context.width;
    final colorScheme = context.colorScheme;

    return ScreenUtilInit(
      builder: (BuildContext context, child) => Scaffold(
        backgroundColor: colorScheme.surface,
        appBar: AppBar(
          backgroundColor: colorScheme.surface,
          elevation: 0,
          title: Text(
            'Support',
            style: TextStyle(
              color: colorScheme.onSurface,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
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
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16.r),
                child: Row(
                  children: [
                    _buildQuickHelpCard(
                      context,
                      icon: Icons.confirmation_number,
                      title: 'Tickets',
                      color: Colors.blue,
                    ),
                    _buildQuickHelpCard(
                      context,
                      icon: Icons.payment,
                      title: 'Payments',
                      color: Colors.green,
                    ),
                    _buildQuickHelpCard(
                      context,
                      icon: Icons.event,
                      title: 'Events',
                      color: Colors.purple,
                    ),
                    _buildQuickHelpCard(
                      context,
                      icon: Icons.account_circle,
                      title: 'Account',
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

              // Contact Options
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.r),
                child: Text(
                  'Contact Us',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              _buildContactOption(
                context,
                icon: Icons.email,
                title: 'Email Support',
                subtitle: 'Get help via email',
                onTap: () {
                  // Handle email support
                },
              ),
              _buildContactOption(
                context,
                icon: Icons.chat,
                title: 'Live Chat',
                subtitle: 'Chat with our support team',
                onTap: () {
                  // Handle live chat
                },
              ),
              _buildContactOption(
                context,
                icon: Icons.phone,
                title: 'Phone Support',
                subtitle: 'Call our support team',
                onTap: () {
                  // Handle phone support
                },
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
        bottomNavigationBar: const AdvancedBottomNavigation(),
      ),
    );
  }

  Widget _buildQuickHelpCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color color,
  }) {
    return Container(
      width: 100.w,
      margin: EdgeInsets.only(right: 12.r),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: color,
            size: 32.r,
          ),
          SizedBox(height: 8.h),
          Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
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

  Widget _buildContactOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
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
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: context.colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(
            icon,
            color: context.colorScheme.primary,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: context.colorScheme.onSurface,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 14.sp,
            color: context.colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16.r,
          color: context.colorScheme.onSurface.withOpacity(0.5),
        ),
        onTap: onTap,
      ),
    );
  }
}
