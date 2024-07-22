import '../../../../core/shared/shared.dart';
import '../../home.dart';

class SearchHomeUseCase {
  final HomeRepository repository;

  SearchHomeUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, List<HomeEntity>>> call({
    required String query,
  }) async {
    return await repository.search(
      query: query,
    );
  }
}
