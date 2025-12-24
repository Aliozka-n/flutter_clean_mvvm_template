/// Base model interface
/// Tüm domain modelleri bu sınıftan türemelidir
abstract class BaseModel {
  /// JSON'dan model oluşturur
  BaseModel.fromJson(Map<String, dynamic> json);

  /// Modeli JSON'a dönüştürür
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other);

  @override
  int get hashCode;
}

