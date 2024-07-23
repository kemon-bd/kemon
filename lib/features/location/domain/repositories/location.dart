import '../../../../core/shared/shared.dart';
import '../../location.dart';

abstract class LocationRepository {
  FutureOr<Either<Failure, List<LocationEntity>>> featured();
}
