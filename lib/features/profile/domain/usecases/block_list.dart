import '../../../../core/shared/shared.dart';
import '../../profile.dart';

class BlockListUseCase {
  final ProfileRepository repository;

  BlockListUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, List<UserPreviewEntity>>> call() {
    return repository.blockList();
  }
}
