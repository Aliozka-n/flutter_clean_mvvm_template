import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';

/// BuildContext extension'ları
extension BuildContextExtension on BuildContext {
  /// Screen dimensions
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
  double get statusBarHeight => MediaQuery.of(this).padding.top;
  double get bottomPadding => MediaQuery.of(this).padding.bottom;

  /// Theme shortcuts
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Navigation shortcuts
  void pop<T>([T? result]) => Navigator.of(this).pop(result);
  Future<T?> push<T>(Widget page) =>
      Navigator.of(this).push<T>(MaterialPageRoute(builder: (_) => page));
  Future<T?> pushReplacement<T>(Widget page) =>
      Navigator.of(this).pushReplacement<T, T>(
          MaterialPageRoute(builder: (_) => page));
  Future<T?> pushAndRemoveUntil<T>(Widget page) =>
      Navigator.of(this).pushAndRemoveUntil<T>(
          MaterialPageRoute(builder: (_) => page), (route) => false);

  /// Snackbar
  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? AppColors.errorColor : AppColors.successColor,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

/// TextStyle extension'ları
extension TextStyleExtension on BuildContext {
  TextStyle get textStyle => textTheme.bodySmall!.copyWith(
        fontSize: AppSizes.textMedium.sp,
        color: AppColors.textPrimary,
      );

  TextStyle get hintTextStyle => textTheme.bodySmall!.copyWith(
        fontSize: AppSizes.textSmall.sp,
        color: AppColors.textHint,
      );

  TextStyle get titleStyle => textTheme.titleLarge!.copyWith(
        fontSize: AppSizes.textXLarge.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      );

  TextStyle get subtitleStyle => textTheme.titleMedium!.copyWith(
        fontSize: AppSizes.textLarge.sp,
        color: AppColors.textSecondary,
      );
}

