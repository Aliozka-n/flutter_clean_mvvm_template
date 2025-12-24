import 'package:flutter/material.dart';
import '../../core/views/base_view.dart';
import 'viewmodels/product_list_view_model.dart';
import 'product_list_service.dart';
import 'views/product_list_view.dart';

/// ProductList ekranının wrapper'ı
class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: BaseView<ProductListViewModel>(
        vmBuilder: (_) => ProductListViewModel(
          service: ProductListService(),
        ),
        builder: (context, viewModel) => ProductListView(
          viewModel: viewModel,
        ),
      ),
    );
  }
}

