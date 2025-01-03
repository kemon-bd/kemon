import '../../../../core/shared/shared.dart';
import '../../../location/location.dart';
import '../../../lookup/lookup.dart';
import '../../../sub_category/sub_category.dart';
import '../../business.dart';

typedef BusinessesByCategoryPaginatedResponse = ({
  int total,
  List<BusinessEntity> businesses,
  List<SubCategoryEntity> related,
});
typedef BusinessesByLocationPaginatedResponse = ({
  int total,
  List<BusinessEntity> businesses,
  List<LocationEntity> related,
});

abstract class BusinessRepository {
  FutureOr<Either<Failure, BusinessEntity>> find({
    required String urlSlug,
  });

  FutureOr<Either<Failure, BusinessEntity>> refresh({
    required String urlSlug,
  });

  FutureOr<Either<Failure, BusinessesByCategoryPaginatedResponse>> category({
    required int page,
    required String category,
    required String? query,
    required SortBy? sort,
    required LookupEntity? division,
    required LookupEntity? district,
    required LookupEntity? thana,
    required SubCategoryEntity? sub,
    required List<int> ratings,
  });
  FutureOr<Either<Failure, BusinessesByCategoryPaginatedResponse>>
      refreshCategory({
    required String category,
    required String? query,
    required SortBy? sort,
    required LookupEntity? division,
    required LookupEntity? district,
    required LookupEntity? thana,
    required SubCategoryEntity? sub,
    required List<int> ratings,
  });

  FutureOr<Either<Failure, BusinessesByLocationPaginatedResponse>> location({
    required int page,
    required String location,
    required String? query,
    required SortBy? sort,
    required List<int> ratings,
  });
  FutureOr<Either<Failure, BusinessesByLocationPaginatedResponse>>
      refreshLocation({
    required String location,
    required String? query,
    required SortBy? sort,
    required List<int> ratings,
  });
}
