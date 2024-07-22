import '../../../../core/shared/shared.dart';
import '../../profile.dart';

class DeleteProfileUseCase {
  final ProfileRepository repository;

  DeleteProfileUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, void>> call({
    required Identity identity,
  }) async {
    return await repository.delete(identity: identity);
  }
}
