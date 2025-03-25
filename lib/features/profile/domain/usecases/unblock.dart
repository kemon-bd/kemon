import '../../../../core/shared/shared.dart';
import '../../profile.dart';

class UnblockSomeoneUseCase {
  final ProfileRepository repository;

  UnblockSomeoneUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, void>> call({
    required Identity victim,
  }) {
    return repository.unblock(victim: victim);
  }
}
