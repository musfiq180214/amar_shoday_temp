import 'package:amar_shoday/features/profile/data/profile_reposotory.dart';
import 'package:amar_shoday/features/profile/domain/user_model.dart';

class GetProfileUseCase {
  final ProfileRepository _repository;
  GetProfileUseCase(this._repository);

  Future<UserModel> call() async {
    return await _repository.fetchProfile();
  }
}
