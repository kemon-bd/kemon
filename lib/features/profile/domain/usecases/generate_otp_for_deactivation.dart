import '../../../../core/shared/shared.dart';
import '../../profile.dart';

class GenerateOtpForAccountDeactivationUseCase {
  final ProfileRepository repository;

  GenerateOtpForAccountDeactivationUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, String>> call() async => await repository.generateOtpForAccountDeactivation();
}
