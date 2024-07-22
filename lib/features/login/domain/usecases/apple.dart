import '../../../../core/shared/shared.dart';
import '../../login.dart';

class AppleSignInUseCase {
  final LoginRepository repository;

  const AppleSignInUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, void>> call() async {
    return await repository.apple();
  }
}
