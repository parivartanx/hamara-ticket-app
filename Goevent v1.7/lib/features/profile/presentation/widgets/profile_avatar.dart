import 'package:flutter/material.dart';
import '/models/user_model.dart';
import '/extensions/media_query_ext.dart';

class ProfileAvatar extends StatelessWidget {
  final User user;

  const ProfileAvatar({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'profile-pic',
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: context.colorScheme.onPrimary.withAlpha(150),
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: context.colorScheme.shadow.withAlpha(10),
              blurRadius: 10,
              spreadRadius: 0,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: CircleAvatar(
          radius: 40,
          backgroundColor: context.colorScheme.surface,
          child: ClipOval(
            child: Image.asset(
              'assets/images/default_profile.png',
              errorBuilder: (context, error, stackTrace) => Icon(Icons.person,
                  size: 40, color: context.colorScheme.outline),
              fit: BoxFit.cover,
              width: 80,
              height: 80,
            ),
          ),
        ),
      ),
    );
  }
}
