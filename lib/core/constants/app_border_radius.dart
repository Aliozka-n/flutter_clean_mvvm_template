import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_sizes.dart';

/// Border Radius sabitleri (Responsive)
class AppBorderRadius {
  AppBorderRadius._();

  static BorderRadius circular(double radius) {
    return BorderRadius.circular(radius.r);
  }

  // Predefined Border Radius
  static BorderRadius small() => circular(AppSizes.radiusSmall);
  static BorderRadius medium() => circular(AppSizes.radiusMedium);
  static BorderRadius large() => circular(AppSizes.radiusLarge);
  static BorderRadius xLarge() => circular(AppSizes.radiusXLarge);
  static BorderRadius round() => circular(AppSizes.radiusRound);

  // Specific Corners
  static BorderRadius topLeftRight(double radius) {
    return BorderRadius.only(
      topLeft: Radius.circular(radius.r),
      topRight: Radius.circular(radius.r),
    );
  }

  static BorderRadius bottomLeftRight(double radius) {
    return BorderRadius.only(
      bottomLeft: Radius.circular(radius.r),
      bottomRight: Radius.circular(radius.r),
    );
  }
}

