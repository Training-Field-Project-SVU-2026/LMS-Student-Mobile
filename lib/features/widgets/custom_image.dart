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

    if (imagePath == null || imagePath!.isEmpty) {
    return AspectRatio(
      aspectRatio: aspectRatio ?? 16 / 10,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.vertical(top: Radius.circular(12.r)),
        child: Container(
          color: context.colorScheme.surfaceVariant,
          child: Icon(Icons.image_not_supported, color: context.colorScheme.outline),
        ),
      ),
    );
  }

    return AspectRatio(
      aspectRatio: aspectRatio ?? 16 / 10, // نسبة العرض الي الطول
      child: ClipRRect(
        // عشان يبقي شكل الصورة ليها راديس من فوق زي الكونتينر
        borderRadius: borderRadius ?? BorderRadius.vertical(top: Radius.circular(12.r)),
        child: CachedNetworkImage(
          imageUrl: imagePath ?? '',
          width: width?.w,
          height: height?.h,
          fit: BoxFit.cover,
          // ده بيظهر عقبال ما الصورة تيجي من ال api
          placeholder: (context, url) => Container(
            color: context.colorScheme.surfaceVariant,
            child: const Center(child: CircularProgressIndicator()),
          ),
          // لو الصورة حصل فيها مشكلة
          errorWidget: (context, url, error) => Container(
            color: context.colorScheme.onSurfaceVariant,
            child: Icon(
              Icons.broken_image,
              color: context.colorScheme.outline,
              size: 40,
            ),
          ),
        ),
      ),
    );
  }
}
