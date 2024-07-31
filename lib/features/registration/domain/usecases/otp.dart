import '../../../../core/shared/shared.dart';
import '../../registration.dart';

class OtpUseCase {
  final RegistrationRepository repository;

  OtpUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, String>> call({
    required String username,
  }) async {
    return await repository.otp(username: username);
  }
}
