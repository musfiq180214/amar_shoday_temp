import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:amar_shoday/core/logger/app_logger.dart';
import 'package:amar_shoday/core/api_client.dart';
import 'package:amar_shoday/features/landing_2/data/landign_2_repo.dart';
import 'package:amar_shoday/features/landing_2/domain/landing_2_model.dart';

// Logger provider
final loggerProvider = Provider<AppLogger>((ref) => AppLogger());

// AuthTokenManager provider (optional, for token handling)
final authTokenProvider = StateProvider<String?>((ref) => null);

// ApiClient provider
final apiClientProvider = Provider<ApiClient>((ref) {
  final logger = ref.read(loggerProvider);
  return ApiClient(logger, ref); // pass logger and ref
});

// Landing2Repository provider
final landingRepoProvider = Provider<Landing2Repository>((ref) {
  final apiClient = ref.read(apiClientProvider);
  return Landing2Repository(apiClient);
});

// Categories provider
final categoriesProvider =
    AsyncNotifierProvider<CategoriesNotifier, List<Category>>(
  () => CategoriesNotifier(),
);

class CategoriesNotifier extends AsyncNotifier<List<Category>> {
  @override
  Future<List<Category>> build() async {
    final repo = ref.read(landingRepoProvider);
    return repo.getCategories();
  }
}
