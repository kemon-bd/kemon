import '../../../../core/shared/shared.dart';
import '../../home.dart';

class DeleteHomeUseCase {
  final HomeRepository repository;

  DeleteHomeUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, void>> call({
    required int id,
  }) async {
    return await repository.delete(
      id: id,
    );
  }
}
