import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Widget extension'ları
extension WidgetExtension on Widget {
  /// Center widget
  Widget center() => Center(child: this);

  /// Padding
  Widget paddingAll(double value) => Padding(
        padding: EdgeInsets.all(value.w),
        child: this,
      );

  Widget paddingSymmetric({double? horizontal, double? vertical}) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontal?.w ?? 0,
          vertical: vertical?.h ?? 0,
        ),
        child: this,
      );

  Widget paddingOnly({
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) =>
      Padding(
        padding: EdgeInsets.only(
          top: top?.h ?? 0,
          bottom: bottom?.h ?? 0,
          left: left?.w ?? 0,
          right: right?.w ?? 0,
        ),
        child: this,
      );

  /// Expanded
  Widget expanded({int flex = 1}) => Expanded(flex: flex, child: this);

  /// Flexible
  Widget flexible({int flex = 1, FlexFit fit = FlexFit.loose}) =>
      Flexible(flex: flex, fit: fit, child: this);

  /// SizedBox
  Widget sizedBox({double? width, double? height}) => SizedBox(
        width: width?.w,
        height: height?.h,
        child: this,
      );

  /// Opacity
  Widget opacity(double opacity) => Opacity(opacity: opacity, child: this);

  /// Visibility
  Widget visibility(bool visible) =>
      Visibility(visible: visible, child: this);
}

