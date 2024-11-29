import '../../../../core/shared/shared.dart';
import '../../location.dart';

class FindLocationUseCase {
  final LocationRepository repository;

  FindLocationUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, LocationEntity>> call({
    required String urlSlug,
  }) async {
    return await repository.find(urlSlug: urlSlug);
  }
}
