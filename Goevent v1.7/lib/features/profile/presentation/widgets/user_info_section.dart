import 'package:flutter/material.dart';
import '/models/user_model.dart';

import 'info_card.dart';

class UserInfoSection extends StatelessWidget {
  final User user;

  const UserInfoSection({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InfoCard(
          icon: Icons.phone_outlined,
          title: 'Phone',
          subtitle: user.phone ?? 'Not provided',
        ),
        InfoCard(
          
          icon: Icons.mail_outline_rounded,
          title: 'Email',
          subtitle: user.email,
        ),
      ],
    );
  }
}
