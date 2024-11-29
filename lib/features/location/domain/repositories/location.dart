import '../../../../core/shared/shared.dart';
import '../../location.dart';

abstract class LocationRepository {
  FutureOr<Either<Failure, List<LocationEntity>>> featured();
  FutureOr<Either<Failure, LocationEntity>> find({
    required String urlSlug,
  });
  FutureOr<Either<Failure, LocationEntity>> refresh({
    required String urlSlug,
  });
}
