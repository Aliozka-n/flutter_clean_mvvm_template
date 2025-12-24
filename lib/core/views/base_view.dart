import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';
import '../viewmodels/base_view_model.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

/// Tüm ekranlar için base view wrapper
/// Loading durumunu otomatik yönetir ve Provider ile state management sağlar
class BaseView<T extends BaseViewModel> extends StatefulWidget {
  /// ViewModel oluşturucu - Service'i inject et
  final T Function(BuildContext)? vmBuilder;
  
  /// UI builder - ViewModel'i widget'lara aktar
  final Widget Function(BuildContext, T)? builder;
  
  /// Mevcut ViewModel kullan (navigation için)
  final bool useValue;

  const BaseView({
    super.key,
    required this.vmBuilder,
    required this.builder,
    this.useValue = false,
  }) : assert(vmBuilder != null, builder != null);

  @override
  State<BaseView<T>> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseViewModel> extends State<BaseView<T>> {
  @override
  Widget build(BuildContext context) {
    return widget.useValue
        ? ChangeNotifierProvider<T>.value(
            value: widget.vmBuilder!(context),
            child: Consumer<T>(builder: _buildScreenContent),
          )
        : ChangeNotifierProvider<T>(
            create: (context) => widget.vmBuilder!(context),
            child: Consumer<T>(builder: _buildScreenContent),
          );
  }

  Widget _buildScreenContent(BuildContext context, T viewModel, Widget? child) {
    // İlk yükleniyorsa loading göster
    if (!viewModel.isInitialized) {
      return Center(
        child: LoadingAnimationWidget.hexagonDots(
          color: AppColors.primaryColor,
          size: AppSizes.sizeXXXLarge.h,
        ),
      );
    }

    // UI'ı göster, eğer loading varsa overlay loading ekle
    return Stack(
      children: [
        widget.builder!(context, viewModel),
        if (viewModel.isLoading)
          Container(
            color: Colors.black.withOpacity(0.3),
            child: Center(
              child: LoadingAnimationWidget.hexagonDots(
                color: AppColors.primaryColor,
                size: AppSizes.sizeXXXLarge.h,
              ),
            ),
          ),
      ],
    );
  }
}

