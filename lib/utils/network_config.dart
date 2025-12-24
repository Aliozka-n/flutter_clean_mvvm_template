/// Network yapılandırması (Environment management)
enum Environment {
  dev,
  staging,
  prod;

  String get baseUrl {
    switch (this) {
      case Environment.dev:
        return 'https://api-dev.example.com/api/';
      case Environment.staging:
        return 'https://api-staging.example.com/api/';
      case Environment.prod:
        return 'https://api.example.com/api/';
    }
  }
}

class NetworkConfig {
  static Environment _environment = Environment.dev;

  static Environment get environment => _environment;

  static void setEnvironment(Environment env) {
    _environment = env;
  }

  String get baseUrl => _environment.baseUrl;

  // Timeout süreleri
  Duration get connectTimeout => const Duration(seconds: 30);
  Duration get receiveTimeout => const Duration(seconds: 30);
  Duration get sendTimeout => const Duration(seconds: 30);
}

