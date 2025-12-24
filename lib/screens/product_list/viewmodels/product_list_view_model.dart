import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/viewmodels/base_view_model.dart';
import '../../../domain/dtos/product_dto.dart';
import '../product_list_service.dart';

/// ProductList ekranının ViewModel'i
class ProductListViewModel extends BaseViewModel {
  final ProductListService service;

  // Private fields
  List<ProductResponse> _products = [];
  String? _selectedCategory;
  String? _errorMessage;

  // Controllers
  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final formKey = GlobalKey<FormState>();

  ProductListViewModel({required this.service}) {
    searchController.addListener(() {
      reloadState();
    });
  }

  // Public getters
  List<ProductResponse> get products => _products;
  String? get selectedCategory => _selectedCategory;
  String? get errorMessage => _errorMessage;

  @override
  FutureOr<void> init() async {
    await loadProducts();
    loadUserPreference();
  }

  /// Ürün listesini yükle
  Future<void> loadProducts() async {
    isLoading = true;
    try {
      var response = await service.getProducts();

      if (response.isSuccessful && response.data != null) {
        _products =
            (response.data as List)
                .map((item) => ProductResponse.fromJson(item))
                .toList();
        _errorMessage = null;
        setCompleted();
      } else {
        _errorMessage = response.message ?? 'Something went wrong';
        setError(_errorMessage);
      }
    } catch (e) {
      _errorMessage = 'Error loading products: ${e.toString()}';
      setError(_errorMessage);
    } finally {
      isLoading = false;
    }
  }

  /// Yeni ürün ekle
  Future<bool> addProduct(ProductRequest request) async {
    isLoading = true;
    try {
      var response = await service.createProduct(request);

      if (response.isSuccessful) {
        await loadProducts();
        return true;
      } else {
        _errorMessage = response.message ?? 'Failed to add product';
        setError(_errorMessage);
        return false;
      }
    } catch (e) {
      _errorMessage = 'Error adding product: ${e.toString()}';
      setError(_errorMessage);
      return false;
    } finally {
      isLoading = false;
    }
  }

  /// Ürün sil
  Future<bool> deleteProduct(int productId) async {
    isLoading = true;
    try {
      var response = await service.deleteProduct(productId);

      if (response.isSuccessful) {
        _products.removeWhere((p) => p.id == productId);
        reloadState();
        return true;
      } else {
        _errorMessage = response.message ?? 'Failed to delete product';
        setError(_errorMessage);
        return false;
      }
    } catch (e) {
      _errorMessage = 'Error deleting product: ${e.toString()}';
      setError(_errorMessage);
      return false;
    } finally {
      isLoading = false;
    }
  }

  /// Kategori değiştir
  void setSelectedCategory(String? category) {
    _selectedCategory = category;
    reloadState();
  }

  /// Filtrelenmiş ürünler (arama ve kategoriye göre)
  List<ProductResponse> get filteredProducts {
    var filtered = _products;

    // Kategori filtresi
    if (_selectedCategory != null && _selectedCategory!.isNotEmpty) {
      filtered =
          filtered.where((p) {
            // Kategori filtresi implementasyonu (categoryId ile eşleştirme)
            return true; // Placeholder
          }).toList();
    }

    // Arama filtresi
    if (searchController.text.isNotEmpty) {
      filtered =
          filtered.where((product) {
            return product.name!.toLowerCase().contains(
              searchController.text.toLowerCase(),
            );
          }).toList();
    }

    return filtered;
  }

  /// Kullanıcı tercihlerini yükle (SharedPreferences'tan)
  void loadUserPreference() {
    // Örnek: Son seçilen kategoriyi yükle
    // _selectedCategory = SharedPreferencesUtil().getString('selectedCategory');
  }

  @override
  void dispose() {
    searchController.dispose();
    scrollController.dispose();
    super.dispose();
  }
}
