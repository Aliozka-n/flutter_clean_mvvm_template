import 'network_config.dart';

/// API endpoint'lerini merkezi olarak yönetir
class NetworkUrls {
  final _baseUrl = NetworkConfig().baseUrl;

  // Controller isimleri
  final String _productsController = 'Products/';
  final String _usersController = 'Users/';

  // Products Endpoints
  String get productsUrl => _baseUrl + _productsController;
  String get productDetailUrl => _baseUrl + _productsController + 'GetById/';

  // Users Endpoints
  String get usersUrl => _baseUrl + _usersController;
  String get userLoginUrl => _baseUrl + _usersController + 'Login';
}

