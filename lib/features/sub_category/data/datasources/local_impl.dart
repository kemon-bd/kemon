import '../../../../core/shared/shared.dart';
import '../../sub_category.dart';

class SubCategoryLocalDataSourceImpl extends SubCategoryLocalDataSource {
  final Map<String, SubCategoryEntity> _cache = {};
  final Map<String, List<SubCategoryEntity>> _category = {};

  @override
  FutureOr<void> add({
    required SubCategoryEntity subCategory,
  }) {
    _cache[subCategory.urlSlug] = subCategory;
  }

  @override
  FutureOr<void> addAll({
    required List<SubCategoryEntity> subCategories,
  }) {
    for (final subCategory in subCategories) {
      add(subCategory: subCategory);
    }
  }

  @override
  FutureOr<void> addAllByCategory({
    required String category,
    required List<SubCategoryEntity> subCategories,
  }) {
    _category[category] = subCategories;
    addAll(subCategories: subCategories);
  }

  @override
  FutureOr<SubCategoryEntity> find({
    required String urlSlug,
  }) {
    final category = _cache[urlSlug];

    if (category == null) {
      throw SubCategoryNotFoundInLocalCacheFailure();
    }
    return category;
  }

  @override
  FutureOr<List<SubCategoryEntity>> findByCategory({
    required String category,
  }) {
    final categories = _category[category];

    if (categories == null) {
      throw CategoryNotFoundInLocalCacheFailure();
    }
    return categories;
  }

  @override
  FutureOr<void> removeAll() {
    _cache.clear();
    _category.clear();
  }
}
