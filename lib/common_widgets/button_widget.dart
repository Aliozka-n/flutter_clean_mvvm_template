import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_sizes.dart';
import '../core/constants/app_border_radius.dart';

/// Özelleştirilebilir button widget
class ButtonWidget extends StatelessWidget {
  final String textTitle;
  final VoidCallback? onTap;
  final Color? color;
  final Color? textColor;
  final bool enabled;
  final double? height;
  final double? width;
  final IconData? icon;
  final bool isLoading;

  const ButtonWidget({
    super.key,
    required this.textTitle,
    this.onTap,
    this.color,
    this.textColor,
    this.enabled = true,
    this.height,
    this.width,
    this.icon,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height?.h ?? AppSizes.buttonHeight.h,
      child: ElevatedButton(
        onPressed: enabled && !isLoading ? onTap : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? AppColors.primaryColor,
          foregroundColor: textColor ?? AppColors.white,
          disabledBackgroundColor: AppColors.textHint,
          disabledForegroundColor: AppColors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: AppBorderRadius.medium(),
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: 20.w,
                height: 20.h,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    textColor ?? AppColors.white,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: AppSizes.iconMedium.sp),
                    SizedBox(width: AppSizes.sizeSmall.w),
                  ],
                  Text(
                    textTitle,
                    style: TextStyle(
                      fontSize: AppSizes.textLarge.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

