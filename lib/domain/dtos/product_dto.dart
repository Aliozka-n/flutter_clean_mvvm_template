/// Product Request DTO (API'ye göndermek için)
class ProductRequest {
  String? name;
  String? description;
  double? price;
  int? categoryId;
  String? imageUrl;

  ProductRequest({
    this.name,
    this.description,
    this.price,
    this.categoryId,
    this.imageUrl,
  });

  /// Map'e dönüştür (API'ye göndermek için)
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['categoryId'] = categoryId;
    data['imageUrl'] = imageUrl;
    return data;
  }
}

/// Product Response DTO (API'den gelen veriyi parse etmek için)
class ProductResponse {
  int? id;
  String? name;
  String? description;
  double? price;
  int? categoryId;
  String? imageUrl;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? isActive;

  ProductResponse({
    this.id,
    this.name,
    this.description,
    this.price,
    this.categoryId,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
    this.isActive,
  });

  ProductResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price']?.toDouble() ?? 0.0;
    categoryId = json['categoryId'];
    imageUrl = json['imageUrl'];
    createdAt = json['createdAt'] != null
        ? DateTime.parse(json['createdAt'])
        : null;
    updatedAt = json['updatedAt'] != null
        ? DateTime.parse(json['updatedAt'])
        : null;
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['categoryId'] = categoryId;
    data['imageUrl'] = imageUrl;
    data['createdAt'] = createdAt?.toIso8601String();
    data['updatedAt'] = updatedAt?.toIso8601String();
    data['isActive'] = isActive;
    return data;
  }
}

