import '../../../../core/shared/shared.dart';
import '../../location.dart';

abstract class LocationRepository {
  FutureOr<Either<Failure, List<LocationEntity>>> featured();

  FutureOr<Either<Failure, List<DivisionWithListingCountEntity>>> all({
    required String? query,
  });

  FutureOr<Either<Failure, List<DivisionWithListingCountEntity>>> category({
    required String? query,
    required Identity industry,
    Identity? category,
    Identity? subCategory,
  });
  FutureOr<Either<Failure, LocationEntity>> deeplink({
    required String urlSlug,
  });
}
