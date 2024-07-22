import '../../../../core/shared/shared.dart';
import '../../login.dart';

class FacebookSignInUseCase {
  final LoginRepository repository;

  const FacebookSignInUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, void>> call() async {
    return await repository.facebook();
  }
}
