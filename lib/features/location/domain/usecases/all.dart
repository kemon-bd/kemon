import '../../../../core/shared/shared.dart';
import '../../location.dart';

class FindAllLocationsUseCase {
  final LocationRepository repository;

  FindAllLocationsUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, List<DivisionWithListingCountEntity>>> call({
    required String? query,
  }) async {
    return await repository.all(query: query);
  }
}
