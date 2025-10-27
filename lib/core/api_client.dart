import 'package:amar_shoday/core/logger/app_logger.dart';
import 'package:amar_shoday/features/landing_2/provider/landing_2_providers.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Auth token provider (state is managed centrally)
final authTokenProvider = StateProvider<String?>((ref) => null);

// ApiClient provider
final apiClientProvider = Provider<ApiClient>((ref) {
  final logger = ref.read(loggerProvider);
  return ApiClient(logger, ref);
});

class ApiClient {
  final Dio _dio;
  final AppLogger _logger;
  final Ref _ref;

  ApiClient(this._logger, this._ref)
      : _dio = Dio(
          BaseOptions(
            baseUrl: "https://stage-api.amarshoday.com/",
            connectTimeout: const Duration(seconds: 15),
            receiveTimeout: const Duration(seconds: 15),
            headers: {"Accept": "application/json"},
          ),
        ) {
    // Add interceptors
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Attach token if available
          final token = _ref.read(authTokenProvider);
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          _logger.i(
            "➡️ [REQUEST] ${options.method} ${options.uri}\n"
            "Body: ${options.data ?? 'Empty'}\n"
            "Headers: ${options.headers}",
          );
          handler.next(options);
        },
        onResponse: (response, handler) {
          _logger.i(
            "✅ [RESPONSE] ${response.statusCode} ${response.realUri}\n"
            "Response: ${response.data}",
          );
          handler.next(response);
        },
        onError: (DioException e, handler) {
          _logger.e("❌ [ERROR] ${e.message}");
          handler.next(e);
        },
      ),
    );
  }

  // ---------------- Login API ----------------
  Future<Map<String, dynamic>> login(String phone, String password) async {
    final res = await _dio.post('/user/login', data: {
      'phone': phone,
      'password': password,
    });

    // Save token centrally
    final token = res.data['token'] as String?;
    if (token != null) {
      _ref.read(authTokenProvider.notifier).state = token;
    }

    return res.data;
  }

  // ---------------- Other APIs ----------------
  Future<List<dynamic>> getCategories() async {
    final res = await _dio.get('/user/categories');
    return res.data;
  }

  Future<List<dynamic>> getSubCategories() async {
    final res = await _dio.get('/user/sub_categories');
    return res.data;
  }

  Future<Map<String, dynamic>> getCategoryProducts(String slug) async {
    final res = await _dio.get('/user/categories/$slug');
    return res.data;
  }

  Future<Map<String, dynamic>> getProfileInfo() async {
    final res = await _dio.get('/user/profile');
    return res.data;
  }

  // Optional: logout method to clear token
  void logout() {
    _ref.read(authTokenProvider.notifier).state = null;
  }
}
