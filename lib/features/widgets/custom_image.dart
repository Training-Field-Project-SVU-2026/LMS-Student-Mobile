import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';

class CustomImage extends StatelessWidget {
  final String? imagePath;
  final double? width;
  final double? height;
  final double? aspectRatio;
  final BorderRadiusGeometry? borderRadius;

  const CustomImage({
    super.key,
    this.imagePath,
    this.width,
    this.height,
    this.aspectRatio,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio ?? 16 / 10,
      child: ClipRRect(
        borderRadius:
            borderRadius ?? BorderRadius.vertical(top: Radius.circular(12.r)),
        child: CachedNetworkImage(
          imageUrl: imagePath ?? '',
          width: width?.w,
          height: height?.h,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            color: context.colorScheme.surfaceVariant,
            child: const Center(child: CircularProgressIndicator()),
          ),
          errorWidget: (context, url, error) {
            return Image.asset(
              "assets/images/default_image.jpeg",
              width: width?.w,
              height: height?.h,
              fit: BoxFit.cover,
            );
          },
        ),
      ),
    );
  }
}
