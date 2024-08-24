import '../../../../core/shared/shared.dart';
import '../../registration.dart';

class CreateRegistrationUseCase {
  final RegistrationRepository repository;

  CreateRegistrationUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, Identity>> call({
    required String username,
    required String password,
    required String refference,
  }) async {
    return await repository.create(
      username: username,
      password: password,
      refference: refference,
    );
  }
}
