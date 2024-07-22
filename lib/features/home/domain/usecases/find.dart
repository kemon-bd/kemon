import '../../../../core/shared/shared.dart';
import '../../home.dart';

class FindHomeUseCase {
  final HomeRepository repository;

  FindHomeUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, HomeEntity>> call({
    required int id,
  }) async {
    return await repository.find(
      id: id,
    );
  }
}
