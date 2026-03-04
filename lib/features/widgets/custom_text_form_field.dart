import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isPassword;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final void Function(String)? onChanged;
  final double? width;
  final double? height;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.isPassword = false,
    this.controller,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.onChanged, 
    this.width, 
    this.height,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText = true;
 
  @override
  Widget build(BuildContext context) {
    
    return Container(
      decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(8.r),
    boxShadow: [
      BoxShadow(
        color: context.colorScheme.outline.withValues(alpha: 0.25), 
        blurRadius: 10, 
        offset: const Offset(0, 4), 
      ),
    ],
  ),
      child: SizedBox(
        width: widget.width?.w ?? 324.w,
        //height: widget.height?.h ?? 51.h,
        child: TextFormField(
      
          textAlignVertical: TextAlignVertical.center,
          controller: widget.controller,
          validator: widget.validator,
          onChanged: widget.onChanged,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          obscureText: widget.isPassword ? _obscureText : false,
          style: context.textTheme.bodyMedium,
      
      
          decoration: InputDecoration(
            hintText: widget.hintText,
            prefixIconColor: context.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
            suffixIconColor: context.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                  )
                : widget.suffixIcon,
          ),
        ),
      ),
    );
  }
}