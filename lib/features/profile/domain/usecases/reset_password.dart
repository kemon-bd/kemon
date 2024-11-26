import '../../../../core/shared/shared.dart';
import '../../profile.dart';

class ResetPasswordUseCase {
  final ProfileRepository repository;

  ResetPasswordUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, void>> call({
    required String username,
    required String password,
  }) async =>
      await repository.resetPassword(
        username: username,
        password: password,
      );
}
