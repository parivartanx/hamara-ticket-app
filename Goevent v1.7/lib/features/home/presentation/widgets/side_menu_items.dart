import 'package:flutter/material.dart';
import 'package:hamaraticket/features/terms-and-conditions/screens/terms_and_conditions.dart';
import '../../../privacy-policy/privacy_policy.dart';
import '/booking/upcoming.dart';
import '/features/contact/presentation/screens/contact.dart';
import '/organizer/message.dart';
import '/profile/profile.dart';
import 'package:page_transition/page_transition.dart';
import 'menu_list_item.dart';


class SideMenuItems extends StatelessWidget {
  const SideMenuItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        children: [
          MenuListItem(
            icon: Icons.person_2,
            title: "My Profile",
            onTap: () => _navigateTo(context, const Profile()),
          ),
          MenuListItem(
            icon: Icons.message,
            title: "Message",
            onTap: () => _navigateTo(context, const Message()),
          ),
          MenuListItem(
            icon: Icons.calendar_month,
            title: "My Booking",
            onTap: () => _navigateTo(context, const Upcoming()),
          ),
          MenuListItem(
            icon: Icons.contact_page,
            title: "Contact us",
            onTap: () => _navigateTo(context, const Contact()),
          ),
          MenuListItem(
            icon: Icons.privacy_tip,
            title: "Privacy Policy",
            onTap: () => _navigateTo(context, const PrivacyPolicyScreen()),
          ),
          MenuListItem(
            icon: Icons.accessibility,
            title: "Terms & Conditions",
            onTap: () => _navigateTo(context, const TermsAndConditions()),
          ),
          
          // ... Add other menu items similarly
        ],
      ),
    );
  }

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        child: screen,
      ),
    );
  }
}