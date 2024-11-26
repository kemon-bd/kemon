import '../../../../core/shared/shared.dart';
import '../../profile.dart';

class RequestOtpForPasswordChangeUseCase {
  final ProfileRepository repository;

  RequestOtpForPasswordChangeUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, String>> call({
    required String username,
  }) async =>
      await repository.requestOtpForPasswordChange(
        username: username,
      );
}
