import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class ProfileImageWidget extends StatelessWidget {
  final String? imageUrl;
  final double size;
  final VoidCallback? onTap;

  const ProfileImageWidget({
    Key? key,
    this.imageUrl,
    this.size = 80,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.r,
        height: size.r,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            width: 2,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(size.r / 2),
          child: imageUrl != null && imageUrl!.isNotEmpty
              ? CachedNetworkImage(
                  imageUrl: imageUrl!,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/image/placeholder_user.png',
                    fit: BoxFit.cover,
                  ),
                )
              : Image.asset(
                  'assets/image/placeholder_user.png',
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }
}