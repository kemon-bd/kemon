import '../../../../core/shared/shared.dart';
import '../../profile.dart';

class UpdateProfileUseCase {
  final ProfileRepository repository;

  UpdateProfileUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, void>> call({
    required ProfileEntity profile,
  }) async {
    return await repository.update(
      profile: profile,
    );
  }
}
