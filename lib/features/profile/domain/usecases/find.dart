import '../../../../core/shared/shared.dart';
import '../../profile.dart';

class FindProfileUseCase {
  final ProfileRepository repository;

  FindProfileUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, ProfileEntity>> call({
    required Identity identity,
  }) async {
    return await repository.find(identity: identity);
  }
}
