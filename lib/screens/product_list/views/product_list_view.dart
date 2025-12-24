import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_edge_insets.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_border_radius.dart';
import '../../../common_widgets/button_widget.dart';
import '../../../common_widgets/text_field_widget.dart';
import '../../../utils/extensions/context_extension.dart';
import '../../../domain/dtos/product_dto.dart';
import '../viewmodels/product_list_view_model.dart';

/// ProductList ekranının View katmanı
class ProductListView extends StatelessWidget {
  final ProductListViewModel viewModel;

  const ProductListView({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: viewModel.isLoading,
      child: SingleChildScrollView(
        controller: viewModel.scrollController,
        child: Padding(
          padding: AppEdgeInsets.symmetricMedium(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Arama kutusu
              _buildSearchField(context),

              SizedBox(height: AppSizes.sizeLarge.h),

              // Hata mesajı
              if (viewModel.errorMessage != null)
                _buildErrorMessage(context),

              SizedBox(height: AppSizes.sizeMedium.h),

              // Ürün listesi
              _buildProductList(context),

              SizedBox(height: AppSizes.sizeLarge.h),

              // Yeni ürün ekle butonu
              ButtonWidget(
                color: AppColors.primaryColor,
                textTitle: 'Add New Product',
                onTap: () => _showAddProductDialog(context),
              ),

              SizedBox(height: AppSizes.sizeLarge.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return TextFieldWidget(
      textTitle: 'Search',
      textController: viewModel.searchController,
      hintText: 'Search products...',
      textIcon: Icons.search,
      onChanged: (_) {
        viewModel.reloadState();
      },
    );
  }

  Widget _buildErrorMessage(BuildContext context) {
    return Container(
      padding: AppEdgeInsets.medium(),
      decoration: BoxDecoration(
        color: AppColors.errorColor.withOpacity(0.1),
        borderRadius: AppBorderRadius.medium(),
        border: Border.all(color: AppColors.errorColor),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: AppColors.errorColor),
          SizedBox(width: AppSizes.sizeSmall.w),
          Expanded(
            child: Text(
              viewModel.errorMessage!,
              style: context.textStyle.copyWith(
                color: AppColors.errorColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductList(BuildContext context) {
    final products = viewModel.filteredProducts;

    if (products.isEmpty) {
      return Center(
        child: Padding(
          padding: AppEdgeInsets.large(),
          child: Column(
            children: [
              Icon(
                Icons.inventory_2_outlined,
                size: AppSizes.sizeHuge.sp,
                color: AppColors.textHint,
              ),
              SizedBox(height: AppSizes.sizeMedium.h),
              Text(
                'No products found',
                style: context.textStyle.copyWith(
                  color: AppColors.textHint,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return _buildProductCard(context, product);
      },
    );
  }

  Widget _buildProductCard(BuildContext context, product) {
    return Card(
      margin: EdgeInsets.only(bottom: AppSizes.sizeMedium.h),
      shape: RoundedRectangleBorder(
        borderRadius: AppBorderRadius.medium(),
      ),
      elevation: 2,
      child: ListTile(
        contentPadding: AppEdgeInsets.medium(),
        title: Text(
          product.name ?? 'Unnamed Product',
          style: context.titleStyle,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppSizes.sizeSmall.h),
            if (product.description != null)
              Text(
                product.description!,
                style: context.subtitleStyle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            SizedBox(height: AppSizes.sizeSmall.h),
            Text(
              'Price: \$${product.price ?? 0.0}',
              style: context.textStyle.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: AppColors.errorColor),
          onPressed: () async {
            final confirmed = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Delete Product'),
                content: const Text('Are you sure you want to delete this product?'),
                actions: [
                  TextButton(
                    onPressed: () => context.pop(false),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => context.pop(true),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.errorColor,
                    ),
                    child: const Text('Delete'),
                  ),
                ],
              ),
            );

            if (confirmed == true) {
              final success = await viewModel.deleteProduct(product.id!);
              if (success && context.mounted) {
                context.showSnackBar('Product deleted successfully');
              }
            }
          },
        ),
      ),
    );
  }

  void _showAddProductDialog(BuildContext context) {
    final nameController = TextEditingController();
    final priceController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Product'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFieldWidget(
                textTitle: 'Product Name',
                textController: nameController,
              ),
              SizedBox(height: AppSizes.sizeMedium.h),
              TextFieldWidget(
                textTitle: 'Price',
                textController: priceController,
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Cancel'),
          ),
          ButtonWidget(
            textTitle: 'Add',
            onTap: () async {
              if (nameController.text.isNotEmpty &&
                  priceController.text.isNotEmpty) {
                final request = ProductRequest(
                  name: nameController.text,
                  price: double.tryParse(priceController.text) ?? 0.0,
                );

                final success = await viewModel.addProduct(request);
                if (success && context.mounted) {
                  context.pop();
                  context.showSnackBar('Product added successfully');
                }
              }
            },
            width: 100,
            height: 40,
          ),
        ],
      ),
    );
  }
}

