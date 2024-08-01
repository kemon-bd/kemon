import '../../../../core/shared/shared.dart';
import '../../profile.dart';

class RefreshProfileUseCase {
  final ProfileRepository repository;

  RefreshProfileUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, ProfileEntity>> call({
    required Identity identity,
  }) async {
    return await repository.refresh(identity: identity);
  }
}
