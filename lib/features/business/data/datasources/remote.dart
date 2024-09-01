import '../../../../core/shared/shared.dart';
import '../../../location/location.dart';
import '../../../sub_category/sub_category.dart';
import '../../business.dart';

abstract class BusinessRemoteDataSource {
  FutureOr<BusinessModel> find({
    required String urlSlug,
  });

  FutureOr<BusinessesByCategoryPaginatedResponse> category({
    required int page,
    required String urlSlug,
    required SortBy? sort,
    required LocationEntity? division,
    required LocationEntity? district,
    required LocationEntity? thana,
    required SubCategoryEntity? subCategory,
    required List<int> ratings,
  });
}
