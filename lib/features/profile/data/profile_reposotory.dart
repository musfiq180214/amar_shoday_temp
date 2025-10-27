import 'package:amar_shoday/core/api_client.dart';
import 'package:amar_shoday/features/profile/domain/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  final apiClient = ref.read(apiClientProvider);
  return ProfileRepository(apiClient);
});

class ProfileRepository {
  final ApiClient _apiClient;
  ProfileRepository(this._apiClient);

  Future<UserModel> fetchProfile() async {
    final response = await _apiClient.getProfileInfo();
    final userData = response['user'];
    return UserModel.fromJson(userData);
  }
}
