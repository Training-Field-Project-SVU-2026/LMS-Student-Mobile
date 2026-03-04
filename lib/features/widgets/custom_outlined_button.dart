import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String text;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final double? iconPadding;
  final double? iconSize;
  final ButtonStyle? style;
  final TextStyle? textStyle;

  const CustomOutlinedButton({
    super.key,
    required this.text,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.width,
    this.height,
    this.iconPadding,
    this.iconSize,
    this.style, 
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {

    final Color defaultColor = style?.foregroundColor?.resolve({}) ?? context.colorScheme.primary;

    return SizedBox(
      width: width?.w ?? 278.w,
      height: height?.h ?? 50.h,
      child: OutlinedButton(
        onPressed: onTap,
        style: style, 
        child: IconTheme(
          data: IconThemeData(
            color: defaultColor,
            size: iconSize?.w ?? 20.w, 
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // if prefix icon exists
              if (prefixIcon != null) ...[
                prefixIcon!,
                SizedBox(width: iconPadding?.w ?? 8.w),
              ],
              
              Flexible(
                child: Text(
                  text,
                  style: (textStyle ?? context.textTheme.labelLarge)?.copyWith(
                    color: defaultColor,
                  ),
                ),
              ),
          
              // if suffix icon exists
              if (suffixIcon != null) ...[
                SizedBox(width: iconPadding?.w ?? 8.w),
                suffixIcon!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}