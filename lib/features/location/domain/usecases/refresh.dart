import '../../../../core/shared/shared.dart';
import '../../location.dart';

class RefreshLocationUseCase {
  final LocationRepository repository;

  RefreshLocationUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, LocationEntity>> call({
    required String urlSlug,
  }) async {
    return await repository.refresh(urlSlug: urlSlug);
  }
}
