import 'package:get_it/get_it.dart';
import '../services/network_service.dart';
import '../../utils/shared_preferences_util.dart';
import '../../screens/product_list/product_list_service.dart';

/// Dependency Injection container
final getIt = GetIt.instance;

/// Initialize all dependencies
Future<void> initializeDependencies() async {
  // Initialize SharedPreferences
  await SharedPreferencesUtil.getInstance();

  // Singleton services
  getIt.registerLazySingleton<NetworkService>(() => NetworkService.instance);

  // Feature services (Factory - her çağrıda yeni instance)
  getIt.registerFactory<ProductListService>(() => ProductListService());
}

/// Reset all dependencies (useful for testing)
Future<void> resetDependencies() async {
  await getIt.reset();
}
