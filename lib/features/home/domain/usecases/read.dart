import '../../../../core/shared/shared.dart';
import '../../home.dart';

class ReadHomeUseCase {
  final HomeRepository repository;

  ReadHomeUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, List<HomeEntity>>> call() async {
    return await repository.read();
  }
}
