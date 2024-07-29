import '../../../../core/shared/shared.dart';
import '../../location.dart';

class FeaturedLocationsUseCase {
  final LocationRepository repository;

  FeaturedLocationsUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, List<LocationEntity>>> call() async {
    return await repository.featured();
  }
}
