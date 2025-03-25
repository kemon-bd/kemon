import '../../../../core/shared/shared.dart';
import '../../profile.dart';

class BlockSomeoneUseCase {
  final ProfileRepository repository;

  BlockSomeoneUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, void>> call({
    required Identity victim,
    required String? reason,
  }) {
    return repository.block(victim: victim, reason: reason);
  }
}
