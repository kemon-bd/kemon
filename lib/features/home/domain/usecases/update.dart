import '../../../../core/shared/shared.dart';
import '../../home.dart';

class UpdateHomeUseCase {
  final HomeRepository repository;

  UpdateHomeUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, void>> call({
    required HomeEntity home,
  }) async {
    return await repository.update(
      home: home,
    );
  }
}
