import 'package:amar_shoday/features/profile/data/profile_reposotory.dart';
import 'package:amar_shoday/features/profile/domain/profile_usecase.dart';
import 'package:amar_shoday/features/profile/domain/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// UseCase provider
final getProfileUseCaseProvider = Provider<GetProfileUseCase>((ref) {
  final repo = ref.read(profileRepositoryProvider);
  return GetProfileUseCase(repo);
});

// Async profile data
final profileProvider = FutureProvider<UserModel>((ref) async {
  final useCase = ref.read(getProfileUseCaseProvider);
  return await useCase();
});

final updateProfileUseCaseProvider = Provider<UpdateProfileUseCase>((ref) {
  final repo = ref.read(profileRepositoryProvider);
  return UpdateProfileUseCase(repo);
});
