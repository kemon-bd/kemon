import '../../../../core/shared/shared.dart';
import '../../login.dart';

class ForgotPasswordUseCase {
  final LoginRepository repository;

  const ForgotPasswordUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, void>> call({
    required String username,
  }) async {
    return await repository.forgot(
      username: username,
    );
  }
}
