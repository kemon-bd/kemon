import '../../../../core/shared/shared.dart';
import '../../login.dart';

class LoginUseCase {
  final LoginRepository repository;

  const LoginUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, void>> call({
    required String username,
    required String password,
    required bool remember,
  }) async {
    return await repository.login(
      username: username,
      password: password,
      remember: remember,
    );
  }
}
