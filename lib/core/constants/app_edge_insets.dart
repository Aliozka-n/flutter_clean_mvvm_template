import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_sizes.dart';

/// Padding ve Margin sabitleri (Responsive)
class AppEdgeInsets {
  AppEdgeInsets._();

  static EdgeInsets only({
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    return EdgeInsets.only(
      top: top?.h ?? 0,
      bottom: bottom?.h ?? 0,
      left: left?.w ?? 0,
      right: right?.w ?? 0,
    );
  }

  static EdgeInsets symmetric({
    double? horizontal,
    double? vertical,
  }) {
    return EdgeInsets.symmetric(
      horizontal: horizontal?.w ?? 0,
      vertical: vertical?.h ?? 0,
    );
  }

  static EdgeInsets all(double value) {
    return EdgeInsets.all(value.w);
  }

  // Predefined Paddings
  static EdgeInsets xSmall() => all(AppSizes.sizeXSmall);
  static EdgeInsets small() => all(AppSizes.sizeSmall);
  static EdgeInsets medium() => all(AppSizes.sizeMedium);
  static EdgeInsets large() => all(AppSizes.sizeLarge);
  static EdgeInsets xLarge() => all(AppSizes.sizeXLarge);
  static EdgeInsets xxLarge() => all(AppSizes.sizeXXLarge);

  // Symmetric Paddings
  static EdgeInsets symmetricSmall() => symmetric(
        horizontal: AppSizes.sizeSmall,
        vertical: AppSizes.sizeSmall,
      );

  static EdgeInsets symmetricMedium() => symmetric(
        horizontal: AppSizes.sizeMedium,
        vertical: AppSizes.sizeMedium,
      );

  static EdgeInsets symmetricLarge() => symmetric(
        horizontal: AppSizes.sizeLarge,
        vertical: AppSizes.sizeLarge,
      );

  // Horizontal Only
  static EdgeInsets horizontalSmall() => symmetric(horizontal: AppSizes.sizeSmall);
  static EdgeInsets horizontalMedium() => symmetric(horizontal: AppSizes.sizeMedium);
  static EdgeInsets horizontalLarge() => symmetric(horizontal: AppSizes.sizeLarge);

  // Vertical Only
  static EdgeInsets verticalSmall() => symmetric(vertical: AppSizes.sizeSmall);
  static EdgeInsets verticalMedium() => symmetric(vertical: AppSizes.sizeMedium);
  static EdgeInsets verticalLarge() => symmetric(vertical: AppSizes.sizeLarge);
}

