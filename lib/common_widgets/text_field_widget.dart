import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_sizes.dart';
import '../utils/extensions/context_extension.dart';

/// Özelleştirilebilir text field widget
class TextFieldWidget extends StatelessWidget {
  final String textTitle;
  final TextEditingController? textController;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;
  final IconData? textIcon;
  final bool obscureText;
  final int? maxLength;
  final TextInputType? keyboardType;
  final String? hintText;
  final bool enabled;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final FocusNode? focusNode;

  const TextFieldWidget({
    super.key,
    required this.textTitle,
    this.textController,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.textIcon,
    this.obscureText = false,
    this.maxLength,
    this.keyboardType,
    this.hintText,
    this.enabled = true,
    this.maxLines = 1,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          textTitle,
          style: context.textStyle.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: AppSizes.sizeSmall.h),
        TextFormField(
          controller: textController,
          validator: validator,
          onSaved: onSaved,
          onChanged: onChanged,
          obscureText: obscureText,
          maxLength: maxLength,
          keyboardType: keyboardType,
          enabled: enabled,
          maxLines: maxLines,
          inputFormatters: inputFormatters,
          textCapitalization: textCapitalization,
          focusNode: focusNode,
          style: context.textStyle,
          decoration: InputDecoration(
            hintText: hintText ?? textTitle,
            hintStyle: context.hintTextStyle,
            prefixIcon: textIcon != null
                ? Icon(textIcon, color: AppColors.textHint)
                : null,
            suffixIcon: obscureText
                ? IconButton(
                    icon: const Icon(Icons.visibility_off),
                    onPressed: () {
                      // Toggle visibility logic can be added
                    },
                  )
                : null,
            counterText: '',
          ),
        ),
      ],
    );
  }
}

