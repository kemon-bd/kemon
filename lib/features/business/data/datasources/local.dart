import '../../../../core/shared/shared.dart';
import '../../../category/category.dart';
import '../../../lookup/lookup.dart';
import '../../../sub_category/sub_category.dart';
import '../../business.dart';

abstract class BusinessLocalDataSource {
  FutureOr<void> add({
    required BusinessEntity business,
  });

  FutureOr<void> addCategory({
    required int page,
    required String urlSlug,
    required String? query,
    required SortBy? sort,
    required LookupEntity? division,
    required LookupEntity? district,
    required LookupEntity? thana,
    required CategoryEntity? category,
    required SubCategoryEntity? sub,
    required List<int> ratings,
    required BusinessesByCategoryPaginatedResponse response,
  });

  FutureOr<void> addLocation({
    required int page,
    required String location,
    required CategoryEntity? category,
    required SubCategoryEntity? sub,
    required String? query,
    required SortBy? sort,
    required List<int> ratings,
    required BusinessesByLocationPaginatedResponse response,
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
    required String urlSlug,
    required String? query,
    required SortBy? sort,
    required LookupEntity? division,
    required LookupEntity? district,
    required LookupEntity? thana,
    required CategoryEntity? category,
    required SubCategoryEntity? sub,
    required List<int> ratings,
  });
  FutureOr<BusinessesByLocationPaginatedResponse> findLocation({
    required int page,
    required String location,
    required CategoryEntity? category,
    required SubCategoryEntity? subCategory,
    required String? query,
    required SortBy? sort,
    required List<int> ratings,
  });
}
