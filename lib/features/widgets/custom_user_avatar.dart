import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';

class CustomUserAvatar extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String? imagePath;
  final double size;
  final double borderWidth;
  final Color? borderColor;
  final Color? backgroundColor;
  final TextStyle? textStyle;

  const CustomUserAvatar({
    super.key,
    required this.firstName,
    required this.lastName,
    this.imagePath,
    this.size = 110,
    this.borderWidth = 4,
    this.borderColor,
    this.backgroundColor,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage = imagePath != null && imagePath!.isNotEmpty;
    final initials = '${firstName.isNotEmpty ? firstName[0] : ''}${lastName.isNotEmpty ? lastName[0] : ''}'.toUpperCase();

    return Container(
      width: size.r,
      height: size.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor ?? context.colorScheme.outline.withValues(
            alpha: 0.5,
          ),
          width: borderWidth.r,
        ),
      ),
      child: ClipOval(
        child: hasImage
            ? CachedNetworkImage(
                imageUrl: imagePath!,
                width: size.r,
                height: size.r,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: backgroundColor ?? context.colorScheme.primary.withValues(alpha: 0.1),
                  child: const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
                errorWidget: (context, url, error) => _buildInitialsWidget(context, initials),
              )
            : _buildInitialsWidget(context, initials),
      ),
    );
  }

  Widget _buildInitialsWidget(BuildContext context, String initials) {
    final calculatedFontSize = (size * 0.35).sp;
    return CircleAvatar(
      backgroundColor: backgroundColor ?? context.colorScheme.primary.withValues(alpha: 0.1),
      child: Text(
        initials,
        style: textStyle ?? context.textTheme.displayMedium?.copyWith(
          color: context.colorScheme.primary,
          fontWeight: FontWeight.bold,
          fontSize: calculatedFontSize,
        ),
      ),
    );
  }
}
