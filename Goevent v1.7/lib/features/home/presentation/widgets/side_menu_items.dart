import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/features/booking/presentation/screens/booking.dart';
import '/features/profile/presentation/screens/profile.dart';
import '/features/terms-and-conditions/screens/terms_and_conditions.dart';
import '/features/privacy-policy/privacy_policy.dart';
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
            onTap: () => context.pushNamed(Profile.routeName),
          ),
          MenuListItem(
            icon: Icons.calendar_month,
            title: "My Booking",
            onTap: () => context.pushNamed(Booking.routeName),
          ),
          MenuListItem(
            icon: Icons.privacy_tip,
            title: "Privacy Policy",
            onTap: () => context.pushNamed(PrivacyPolicyScreen.routeName),
          ),
          MenuListItem(
            icon: Icons.accessibility,
            title: "Terms & Conditions",
            onTap: () => context.pushNamed(TermsAndConditions.routeName),
          ),
          
          // ... Add other menu items similarly
        ],
      ),
    );
  }

}