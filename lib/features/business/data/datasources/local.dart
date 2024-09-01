import '../../../../core/shared/shared.dart';
import '../../../location/location.dart';
import '../../../sub_category/sub_category.dart';
import '../../business.dart';

abstract class BusinessLocalDataSource {
  FutureOr<void> add({
    required BusinessEntity business,
  });

  FutureOr<void> addCategory({
    required int page,
    required String category,
    required SortBy? sort,
    required LocationEntity? division,
    required LocationEntity? district,
    required LocationEntity? thana,
    required SubCategoryEntity? sub,
    required List<int> ratings,
    required BusinessesByCategoryPaginatedResponse response,
  });

  FutureOr<void> addAll({
    required List<BusinessEntity> businesses,
  });

  FutureOr<void> removeAll();

  FutureOr<BusinessEntity> find({
    required String urlSlug,
  });

  FutureOr<BusinessesByCategoryPaginatedResponse> findCategory({
    required int page,
    required String category,
    required SortBy? sort,
    required LocationEntity? division,
    required LocationEntity? district,
    required LocationEntity? thana,
    required SubCategoryEntity? sub,
    required List<int> ratings,
  });

  FutureOr<void> removeCategory({
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
