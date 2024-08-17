import '../../../../core/shared/shared.dart';
import '../../category.dart';

class CategoryLocalDataSourceImpl extends CategoryLocalDataSource {
  final Map<String, CategoryEntity> _cache = {};
  final Map<String, List<CategoryEntity>> _industry = {};

  @override
  FutureOr<void> add({
    required CategoryEntity category,
  }) async {
    _cache[category.urlSlug] = category;
    return Future.value();
  }

  @override
  FutureOr<void> addAll({
    required List<CategoryEntity> categories,
  }) {
    for (final category in categories) {
      add(category: category);
    }
    return Future.value();
  }

  @override
  FutureOr<void> addAllByIndustry({
    required String industry,
    required List<CategoryEntity> categories,
  }) async {
    _industry[industry] = categories;
    await addAll(categories: categories);
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
  FutureOr<List<CategoryEntity>> findByIndustry({
    required String industry,
  }) async {
    final categories = _industry[industry];

    if (categories == null) {
      throw IndustryNotFoundInLocalCacheFailure();
    }
    return categories;
  }

  @override
  FutureOr<void> removeAll() async {
    _cache.clear();
    _industry.clear();
    return Future.value();
  }
}
