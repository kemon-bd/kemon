import '../../../../core/shared/shared.dart';
import '../../home.dart';

class RefreshHomeUseCase {
  final HomeRepository repository;

  RefreshHomeUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, List<HomeEntity>>> call() async {
    return await repository.refresh();
  }
}
