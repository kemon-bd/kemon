import '../../../../core/shared/shared.dart';
import '../../location.dart';

abstract class LocationRemoteDataSource {
  FutureOr<List<LocationModel>> featured();

  FutureOr<LocationModel> find({
    required String urlSlug,
  });
  
  FutureOr<List<DivisionWithListingCountModel>> all({
    required String? query,
  });

  FutureOr<List<DivisionWithListingCountModel>> category({
    required Identity industry,
    required Identity? category,
    required Identity? subCategory,
  });
}
