// import 'package:amar_shoday/core/logger/app_logger.dart';
// import 'package:amar_shoday/features/landing_2/provider/landing_2_providers.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// // Auth token provider (state is managed centrally)
// final authTokenProvider = StateProvider<String?>((ref) => null);

// // ApiClient provider
// final apiClientProvider = Provider<ApiClient>((ref) {
//   final logger = ref.read(loggerProvider);
//   return ApiClient(logger, ref);
// });

// class ApiClient {
//   final Dio _dio;
//   final AppLogger _logger;
//   final Ref _ref;

//   ApiClient(this._logger, this._ref)
//       : _dio = Dio(
//           BaseOptions(
//             baseUrl: "https://stage-api.amarshoday.com/",
//             connectTimeout: const Duration(seconds: 15),
//             receiveTimeout: const Duration(seconds: 15),
//             headers: {"Accept": "application/json"},
//           ),
//         ) {
//     // Add interceptors
//     _dio.interceptors.add(
//       InterceptorsWrapper(
//         onRequest: (options, handler) {
//           // Attach token if available
//           final token = _ref.read(authTokenProvider);
//           if (token != null) {
//             options.headers['Authorization'] = 'Bearer $token';
//           }

//           _logger.i(
//             "token: $token\n"
//             "➡️ [REQUEST] ${options.method} ${options.uri}\n"
//             "Body: ${options.data ?? 'Empty'}\n"
//             "Headers: ${options.headers}",
//           );
//           handler.next(options);
//         },
//         onResponse: (response, handler) {
//           _logger.i(
//             "✅ [RESPONSE] ${response.statusCode} ${response.realUri}\n"
//             "Response: ${response.data}",
//           );
//           handler.next(response);
//         },
//         onError: (DioException e, handler) {
//           _logger.e("❌ [ERROR] ${e.message}");
//           handler.next(e);
//         },
//       ),
//     );
//   }

//   // ---------------- Login API ----------------
//   Future<Map<String, dynamic>> login(String phone, String password) async {
//     final res = await _dio.post('/user/login', data: {
//       'phone': phone,
//       'password': password,
//     });

//     // Save token centrally
//     final token = res.data['token'] as String?;
//     if (token != null) {
//       _ref.read(authTokenProvider.notifier).state = token;
//     }

//     return res.data;
//   }

//   Future<Map<String, dynamic>> logout() async {
//     try {
//       final token = _ref.read(authTokenProvider);
//       final res = await _dio.delete(
//         '/users/logout',
//         options: Options(
//           headers: {'Authorization': 'Bearer $token'},
//         ),
//       );

//       // Clear token after successful logout
//       _ref.read(authTokenProvider.notifier).state = null;

//       return res.data;
//     } on DioException catch (e) {
//       // Handle API or network errors gracefully
//       return {
//         'message': e.response?.data['message'] ?? 'Logout failed',
//         'error': true,
//       };
//     }
//   }

//   // ---------------- Other APIs ----------------
//   Future<List<dynamic>> getCategories() async {
//     final res = await _dio.get('/user/categories');
//     return res.data;
//   }

//   Future<List<dynamic>> getSubCategories() async {
//     final res = await _dio.get('/user/sub_categories');
//     return res.data;
//   }

//   Future<Map<String, dynamic>> getCategoryProducts(String slug) async {
//     final res = await _dio.get('/user/categories/$slug');
//     return res.data;
//   }

//   Future<Map<String, dynamic>> getProfileInfo() async {
//     final res = await _dio.get('/user/profile');
//     return res.data;
//   }

//   Future<Map<String, dynamic>> updateProfile({
//     String? name,
//     String? email,
//     String? dob, // format: "dd-MM-yyyy"
//     String? gender, // e.g., "male", "female"
//   }) async {
//     final Map<String, dynamic> data = {};

//     if (name != null) data['name'] = name;
//     if (email != null) data['email'] = email;
//     if (dob != null) data['dob'] = dob;
//     if (gender != null) {
//       if (gender == 'Female') {
//         data['gender'] = 1;
//       } else {
//         data['gender'] = 0;
//       }
//     }

//     final res = await _dio.put('/user/profile', data: data);

//     _logger.i("✏️ [UPDATE PROFILE] Body: $data");
//     _logger.i("✏️ [UPDATE PROFILE] Response: ${res.data}");

//     return res.data;
//   }
// }

import 'package:amar_shoday/core/logger/app_logger.dart';
import 'package:amar_shoday/features/landing_2/provider/landing_2_providers.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Auth token provider (shared globally)
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
    // Attach interceptors for logging and auth
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = _ref.read(authTokenProvider);
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          _logger.i(
            "➡️ [REQUEST] ${options.method} ${options.uri}\n"
            "Token: $token\nBody: ${options.data ?? 'Empty'}",
          );
          handler.next(options);
        },
        onResponse: (response, handler) {
          _logger.i("✅ [RESPONSE] ${response.statusCode} ${response.realUri}");
          handler.next(response);
        },
        onError: (e, handler) {
          _logger.e("❌ [ERROR] ${e.message}");
          handler.next(e);
        },
      ),
    );
  }

  // ---------------- Login ----------------
  Future<Map<String, dynamic>> login(String phone, String password) async {
    final res = await _dio.post('/user/login', data: {
      'phone': phone,
      'password': password,
    });

    final token = res.data['token'] as String?;
    if (token != null) {
      _ref.read(authTokenProvider.notifier).state = token;
    }

    return res.data;
  }

  // ---------------- Logout ----------------
  Future<Map<String, dynamic>> logout() async {
    try {
      final token = _ref.read(authTokenProvider);
      final res = await _dio.delete(
        '/user/logout',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      // Clear token after successful logout
      _ref.read(authTokenProvider.notifier).state = null;

      // Handle cases where the server returns non-JSON responses
      if (res.data is Map<String, dynamic>) {
        return res.data;
      } else {
        return {
          'message': 'Logged out successfully',
          'error': false,
          'status': res.statusCode,
        };
      }
    } on DioException catch (e) {
      return {
        'message': e.response?.data is Map<String, dynamic>
            ? (e.response?.data['message'] ?? 'Logout failed')
            : 'Logout failed',
        'error': true,
      };
    }
  }

  // ---------------- Categories ----------------
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

  // ---------------- Profile ----------------
  Future<Map<String, dynamic>> getProfileInfo() async {
    final res = await _dio.get('/user/profile');
    return res.data;
  }

  Future<Map<String, dynamic>> updateProfile({
    String? name,
    String? email,
    String? dob,
    String? gender,
  }) async {
    final Map<String, dynamic> data = {};
    if (name != null) data['name'] = name;
    if (email != null) data['email'] = email;
    if (dob != null) data['dob'] = dob;
    if (gender != null) data['gender'] = gender == 'Female' ? 1 : 0;

    final res = await _dio.put('/user/profile', data: data);
    _logger.i("✏️ [UPDATE PROFILE] Body: $data");
    return res.data;
  }
}
