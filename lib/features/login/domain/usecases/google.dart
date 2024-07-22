import '../../../../core/shared/shared.dart';
import '../../login.dart';

class GoogleSignInUseCase {
  final LoginRepository repository;

  const GoogleSignInUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, void>> call() async {
    return await repository.google();
  }
}
