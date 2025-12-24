import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_clean_mvvm_template/screens/product_list/viewmodels/product_list_view_model.dart';
import 'package:flutter_clean_mvvm_template/screens/product_list/product_list_service.dart';
import 'package:flutter_clean_mvvm_template/core/models/network_response_model.dart';
import 'package:flutter_clean_mvvm_template/domain/dtos/product_dto.dart';

// Mock service class (in a real project, use mockito)
class MockProductListService extends ProductListService {
  bool shouldReturnError = false;
  List<ProductResponse> mockProducts = [];

  @override
  Future<NetworkResponseModel> getProducts() async {
    if (shouldReturnError) {
      return NetworkResponseModel(
        isSuccessful: false,
        message: 'Error occurred',
        statusCode: 500,
      );
    }
    return NetworkResponseModel(
      isSuccessful: true,
      data: mockProducts.map((p) => p.toJson()).toList(),
      statusCode: 200,
    );
  }
}

void main() {
  group('ProductListViewModel Tests', () {
    late ProductListViewModel viewModel;
    late MockProductListService mockService;

    setUp(() {
      mockService = MockProductListService();
      viewModel = ProductListViewModel(service: mockService);
    });

    tearDown(() {
      viewModel.dispose();
    });

    test('Initial state should be loading', () {
      // ViewModel constructor calls load() automatically
      expect(viewModel.isInitialized, false);
    });

    test('Load products successfully', () async {
      // Setup mock data
      mockService.mockProducts = [
        ProductResponse(id: 1, name: 'Test Product', price: 99.99),
      ];

      // Wait for initialization
      await Future.delayed(const Duration(milliseconds: 100));

      // Verify products are loaded
      expect(viewModel.products.length, 1);
      expect(viewModel.products.first.name, 'Test Product');
      expect(viewModel.errorMessage, null);
    });

    test('Handle error when loading products', () async {
      mockService.shouldReturnError = true;

      // Wait for initialization
      await Future.delayed(const Duration(milliseconds: 100));

      // Verify error state
      expect(viewModel.errorMessage, isNotNull);
      expect(viewModel.products.isEmpty, true);
    });

    test('Filter products by search text', () {
      viewModel.products.addAll([
        ProductResponse(id: 1, name: 'Product A'),
        ProductResponse(id: 2, name: 'Product B'),
      ]);

      viewModel.searchController.text = 'A';
      final filtered = viewModel.filteredProducts;

      expect(filtered.length, 1);
      expect(filtered.first.name, 'Product A');
    });
  });
}
