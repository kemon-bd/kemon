import '../../../../core/shared/shared.dart';
import '../../category.dart';

class CategoryLocalDataSourceImpl extends CategoryLocalDataSource {
  final Map<String, CategoryEntity> _cache = {};
  final Map<CategoriesPaginationKey, CategoryPaginatedResponse> _all = {};

  @override
  FutureOr<void> featured({
    required List<CategoryEntity> categories,
  }) {
    for (final category in categories) {
      _cache[category.urlSlug] = category;
    }
    return Future.value();
  }

  @override
  FutureOr<CategoryEntity> find({
    required String urlSlug,
  }) async {
    final category = _cache[urlSlug];

    if (category == null) {
      throw CategoryNotFoundInLocalCacheFailure();
    }
    return category;
  }

  @override
  FutureOr<void> removeAll() async {
    _cache.clear();
    _all.clear();
    return Future.value();
  }

  @override
  FutureOr<void> cachePagination({
    required CategoriesPaginationKey key,
    required CategoryPaginatedResponse result,
  }) async {
    _all[key] = result;
    return Future.value();
  }

  @override
  FutureOr<CategoryPaginatedResponse> findPagination({
  required CategoriesPaginationKey key,
}) async {
  int total = 0;
  List<IndustryBasedCategories> results = [];

  for (int p = 1; p <= key.page; p++) {
    final tempKey = (
      page: p,
      query: key.query,
      industry: key.industry,
    );

    if (!_all.containsKey(tempKey)) {
      throw CategoriesNotFoundInLocalCacheFailure();
    }

    final item = _all[tempKey]; // Use tempKey here
    if (item != null) {
      total = item.total;
      results = results.stitch(item.results);
    }
  }

  return (
    total: total,
    results: results,
  );
}
}
