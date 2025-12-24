/// Network işlemlerinden dönen response model
class NetworkResponseModel {
  final bool isSuccessful;
  final dynamic data;
  final String? message;
  final int? statusCode;

  NetworkResponseModel({
    required this.isSuccessful,
    this.data,
    this.message,
    this.statusCode,
  });
}

