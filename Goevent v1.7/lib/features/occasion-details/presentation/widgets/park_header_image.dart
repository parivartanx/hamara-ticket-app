import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import '/extensions/media_query_ext.dart';

class ParkHeaderImage extends StatelessWidget {
  final String imageUrl;

  const ParkHeaderImage({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      height: context.height / 4,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            color: Colors.white,
          ),
        ),
        errorWidget: (context, error, stackTrace) {
          return Image.asset(
            "assets/image/park.png",
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}