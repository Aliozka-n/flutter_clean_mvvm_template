/// HTTP Request tipleri
enum RequestType {
  get,
  post,
  put,
  delete,
  patch;

  String get method {
    switch (this) {
      case RequestType.get:
        return 'GET';
      case RequestType.post:
        return 'POST';
      case RequestType.put:
        return 'PUT';
      case RequestType.delete:
        return 'DELETE';
      case RequestType.patch:
        return 'PATCH';
    }
  }
}

