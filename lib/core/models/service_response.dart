/// API yanıtları için generic model
class ServiceResponse<T> {
  final bool isSuccessful;
  final T? data;
  final String? message;
  final int? statusCode;
  final dynamic error;

  ServiceResponse({
    required this.isSuccessful,
    this.data,
    this.message,
    this.statusCode,
    this.error,
  });

  /// Başarılı yanıt
  factory ServiceResponse.success({
    T? data,
    String? message,
    int? statusCode,
  }) {
    return ServiceResponse(
      isSuccessful: true,
      data: data,
      message: message,
      statusCode: statusCode ?? 200,
    );
  }

  /// Hatalı yanıt
  factory ServiceResponse.error({
    String? message,
    int? statusCode,
    dynamic error,
  }) {
    return ServiceResponse(
      isSuccessful: false,
      message: message ?? 'An error occurred',
      statusCode: statusCode ?? 500,
      error: error,
    );
  }
}

