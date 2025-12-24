import 'dart:convert';
import '../../core/services/network_service.dart';
import '../../core/enums/request_type.dart';
import '../../core/models/network_response_model.dart';
import '../../utils/network_urls.dart';
import '../../domain/dtos/product_dto.dart';

/// ProductList ekranının servis katmanı
class ProductListService {
  /// Ürün listesini getir
  Future<NetworkResponseModel> getProducts() async {
    var url = NetworkUrls().productsUrl;
    var response = await NetworkService.instance.makeRequest(
      url,
      type: RequestType.get,
    );
    return response;
  }

  /// ID'ye göre ürün getir
  Future<NetworkResponseModel> getProduct(int id) async {
    var url = NetworkUrls().productDetailUrl + id.toString();
    var response = await NetworkService.instance.makeRequest(
      url,
      type: RequestType.get,
    );
    return response;
  }

  /// Yeni ürün oluştur
  Future<NetworkResponseModel> createProduct(ProductRequest request) async {
    var url = NetworkUrls().productsUrl;
    var response = await NetworkService.instance.makeRequest(
      url,
      body: json.encode(request.toJson()),
      type: RequestType.post,
    );
    return response;
  }

  /// Ürün güncelle
  Future<NetworkResponseModel> updateProduct(
    int id,
    ProductRequest request,
  ) async {
    var url = NetworkUrls().productsUrl + id.toString();
    var response = await NetworkService.instance.makeRequest(
      url,
      body: json.encode(request.toJson()),
      type: RequestType.put,
    );
    return response;
  }

  /// Ürün sil
  Future<NetworkResponseModel> deleteProduct(int id) async {
    var url = NetworkUrls().productsUrl + id.toString();
    var response = await NetworkService.instance.makeRequest(
      url,
      type: RequestType.delete,
    );
    return response;
  }
}
