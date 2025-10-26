// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final authTokenManagerProvider =
//     Provider<AuthTokenManager>((ref) => AuthTokenManager(ref));

// class AuthTokenManager {
//   final Ref ref;

//   AuthTokenManager(this.ref);

//   // Internal StateProvider for token
//   static final _tokenProvider = StateProvider<String?>((ref) => null);

//   // Set token (encapsulated)
//   void setToken(String token) {
//     ref.read(_tokenProvider.notifier).state = token;
//   }

//   // Clear token
//   void clearToken() {
//     ref.read(_tokenProvider.notifier).state = null;
//   }

//   // Get token
//   String? get token => ref.read(_tokenProvider);
// }
