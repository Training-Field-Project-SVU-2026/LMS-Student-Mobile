// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lms_student/core/extensions/context_extensions.dart';

class CustomImg extends StatelessWidget {
  final String? imgUrl;
  final double? width;
  final double? height;
  final double? radius;
  const CustomImg({Key? key, this.imgUrl, this.width, this.height, this.radius})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(radius ?? 0),
      child: CachedNetworkImage(
        imageUrl:
            imgUrl ??
            'https://i.pinimg.com/736x/77/97/7e/77977e0f51ec76e51b1360e5f0685d13.jpg',
        width: width ?? 393.w,
        height: height ?? 225.h,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          color: context.colorScheme.surfaceVariant,
          child: const Center(child: CircularProgressIndicator()),
        ),
        errorWidget: (context, url, error) {
          return Container(
            color: context.colorScheme.onSurfaceVariant,
            child: Icon(
              Icons.broken_image,
              color: context.colorScheme.outline,
              size: 40,
            ),
          );
        },
      ),
    );
  }
}
