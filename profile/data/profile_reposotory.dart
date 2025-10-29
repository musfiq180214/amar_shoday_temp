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
    return UserModel.fromJson(response['user']);
  }

  Future<UserModel> updateProfile({
    String? name,
    String? email,
    String? dob,
    String? gender,
  }) async {
    final res = await _apiClient.updateProfile(
      name: name,
      email: email,
      dob: dob,
      gender: gender,
    );
    return UserModel.fromJson(res['user']);
  }
}
