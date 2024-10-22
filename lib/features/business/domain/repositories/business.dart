import '../../../../core/shared/shared.dart';
import '../../../location/location.dart';
import '../../../sub_category/sub_category.dart';
import '../../business.dart';

typedef BusinessesByCategoryPaginatedResponse = ({
  int total,
  List<BusinessEntity> businesses,
  List<SubCategoryEntity> related,
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
    required SortBy? sort,
    required LocationEntity? division,
    required LocationEntity? district,
    required LocationEntity? thana,
    required SubCategoryEntity? sub,
    required List<int> ratings,
  });
  FutureOr<Either<Failure, BusinessesByCategoryPaginatedResponse>>
      refreshCategory({
    required int page,
    required String category,
    required SortBy? sort,
    required LocationEntity? division,
    required LocationEntity? district,
    required LocationEntity? thana,
    required SubCategoryEntity? sub,
    required List<int> ratings,
  });
}
