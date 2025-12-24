import 'package:dio/dio.dart';
import '../../utils/network_config.dart';
import '../enums/request_type.dart';
import '../models/network_response_model.dart';
import '../../utils/shared_preferences_util.dart';

/// HTTP işlemleri için singleton service
class NetworkService {
  static NetworkService? _instance;
  late Dio _dio;

  NetworkService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: NetworkConfig().baseUrl,
        connectTimeout: NetworkConfig().connectTimeout,
        receiveTimeout: NetworkConfig().receiveTimeout,
        sendTimeout: NetworkConfig().sendTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Interceptors
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Token ekle
          final token = SharedPreferencesUtil.instance.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (error, handler) {
          return handler.next(error);
        },
      ),
    );
  }

  static NetworkService get instance {
    _instance ??= NetworkService._internal();
    return _instance!;
  }

  /// Generic request method
  Future<NetworkResponseModel> makeRequest(
    String url, {
    Map<String, dynamic>? queryParameters,
    String? body,
    required RequestType type,
    Map<String, dynamic>? headers,
  }) async {
    try {
      Response response;

      switch (type) {
        case RequestType.get:
          response = await _dio.get(
            url,
            queryParameters: queryParameters,
            options: Options(headers: headers),
          );
          break;
        case RequestType.post:
          response = await _dio.post(
            url,
            data: body,
            queryParameters: queryParameters,
            options: Options(headers: headers),
          );
          break;
        case RequestType.put:
          response = await _dio.put(
            url,
            data: body,
            queryParameters: queryParameters,
            options: Options(headers: headers),
          );
          break;
        case RequestType.delete:
          response = await _dio.delete(
            url,
            data: body,
            queryParameters: queryParameters,
            options: Options(headers: headers),
          );
          break;
        case RequestType.patch:
          response = await _dio.patch(
            url,
            data: body,
            queryParameters: queryParameters,
            options: Options(headers: headers),
          );
          break;
      }

      return NetworkResponseModel(
        isSuccessful:
            response.statusCode != null &&
            response.statusCode! >= 200 &&
            response.statusCode! < 300,
        data: response.data,
        message: response.statusMessage,
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      return NetworkResponseModel(
        isSuccessful: false,
        message: _handleError(e),
        statusCode: e.response?.statusCode ?? 500,
        data: e.response?.data,
      );
    } catch (e) {
      return NetworkResponseModel(
        isSuccessful: false,
        message: e.toString(),
        statusCode: 500,
      );
    }
  }

  String _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timeout. Please try again.';
      case DioExceptionType.badResponse:
        if (error.response?.statusCode == 401) {
          return 'Unauthorized. Please login again.';
        } else if (error.response?.statusCode == 404) {
          return 'Resource not found.';
        } else if (error.response?.statusCode == 500) {
          return 'Server error. Please try again later.';
        }
        return error.response?.data['message'] ?? 'An error occurred';
      case DioExceptionType.cancel:
        return 'Request cancelled.';
      default:
        return 'Network error. Please check your connection.';
    }
  }
}
