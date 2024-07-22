import '../../../../core/shared/shared.dart';
import '../../profile.dart';

class CheckProfileUseCase {
  final ProfileRepository repository;

  CheckProfileUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, CheckResponse>> call({
    required String username,
  }) async {
    return await repository.check(username: username);
  }
}
