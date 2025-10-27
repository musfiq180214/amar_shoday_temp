import 'package:amar_shoday/features/profile/data/profile_reposotory.dart';
import 'package:amar_shoday/features/profile/domain/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetProfileUseCase {
  final ProfileRepository _repository;
  GetProfileUseCase(this._repository);

  Future<UserModel> call() async {
    return await _repository.fetchProfile();
  }
}

class UpdateProfileUseCase {
  final ProfileRepository _repository;
  UpdateProfileUseCase(this._repository);

  Future<UserModel> call({
    String? name,
    String? email,
    String? dob,
    String? gender,
  }) async {
    return await _repository.updateProfile(
      name: name,
      email: email,
      dob: dob,
      gender: gender,
    );
  }
}
