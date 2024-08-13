import '../../../../core/shared/shared.dart';
import '../../profile.dart';

class DeactivateAccountUseCase {
  final ProfileRepository repository;

  DeactivateAccountUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, void>> call({
    required String otp,
  }) async =>
      await repository.deactivateAccount(otp: otp);
}
