import 'package:amar_shoday/core/api_client.dart';
import 'package:amar_shoday/core/logger/app_logger.dart';
import 'package:amar_shoday/features/landing_2/domain/landing_2_model.dart';

class Landing2Repository {
  final ApiClient _apiClient;

  Landing2Repository(this._apiClient);

  Future<List<Category>> getCategories() async {
    try {
      final data = await _apiClient.getCategories();
      // Assuming each item is a JSON map
      return (data as List).map((e) => Category.fromJson(e)).toList();
    } catch (e) {
      AppLogger().e("Error fetching categories: $e");
      rethrow;
    }
  }

  Future<List<SubCategory>> getSubCategories() async {
    try {
      final data = await _apiClient.getSubCategories();
      return (data as List).map((e) => SubCategory.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Product>> getCategoryProducts(String slug) async {
    try {
      final data = await _apiClient.getCategoryProducts(slug);
      // Assuming 'products' key in the response contains the list
      final products = data['products'] as List;
      return products.map((e) => Product.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
