import '../../../../core/shared/shared.dart';
import '../../home.dart';

class CreateHomeUseCase {
  final HomeRepository repository;

  CreateHomeUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, void>> call({
    required HomeEntity home,
  }) async {
    return await repository.create(
      home: home,
    );
  }
}
