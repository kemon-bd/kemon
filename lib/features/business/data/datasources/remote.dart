import '../../../../core/shared/shared.dart';
import '../../../category/category.dart';
import '../../../lookup/lookup.dart';
import '../../../sub_category/sub_category.dart';
import '../../business.dart';

abstract class BusinessRemoteDataSource {
  FutureOr<BusinessModel> find({
    required String urlSlug,
  });

  FutureOr<BusinessesByCategoryPaginatedResponse> category({
    required int page,
    required String urlSlug,
    required String? query,
    required SortBy? sort,
    required LookupEntity? division,
    required LookupEntity? district,
    required LookupEntity? thana,
    required CategoryEntity? category,
    required SubCategoryEntity? subCategory,
    required List<int> ratings,
  });

  FutureOr<BusinessesByLocationPaginatedResponse> location({
    required int page,
    required String location,
    required String? division,
    required String? district,
    required String? thana,
    required String? query,
    required SortBy? sort,
    required List<int> ratings,
    required CategoryEntity? category,
    required SubCategoryEntity? sub,
  });
}
