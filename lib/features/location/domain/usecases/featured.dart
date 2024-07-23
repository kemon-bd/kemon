import '../../../../core/shared/shared.dart';
import '../../location.dart';

class FeaturedLocationUseCase {
  final LocationRepository repository;

  FeaturedLocationUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, List<LocationEntity>>> call() async {
    return await repository.featured();
  }
}
