import '../../../../core/shared/shared.dart';
import '../../profile.dart';

class RequestOtpForPasswordChangeUseCase {
  final ProfileRepository repository;

  RequestOtpForPasswordChangeUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, String>> call({
    required String username,
    required bool verificationOnly,
  }) async =>
      await repository.requestOtpForPasswordChange(
        username: username,
        verificationOnly: verificationOnly,
      );
}
