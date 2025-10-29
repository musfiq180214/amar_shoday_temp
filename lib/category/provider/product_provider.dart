import 'package:amar_shoday/features/landing_2/provider/landing_2_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedCategoryProductsProvider =
    FutureProvider.family<Map<String, dynamic>, String>((ref, slug) async {
  final apiClient = ref.read(apiClientProvider);
  return await apiClient.getCategoryProducts(slug);
});
