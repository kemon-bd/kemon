import '../../../../core/shared/shared.dart';
import '../../sub_category.dart';

class SubCategoryLocalDataSourceImpl extends SubCategoryLocalDataSource {
  final Map<String, SubCategoryEntity> _cache = {};
  final Map<String, List<SubCategoryEntity>> location = {};
  final Map<String, List<SubCategoryEntity>> _category = {};

  @override
  FutureOr<void> add({
    required SubCategoryEntity subCategory,
  }) async {
    _cache[subCategory.urlSlug] = subCategory;
    return Future.value();
  }

  @override
  FutureOr<void> addAll({
    required List<SubCategoryEntity> subCategories,
  }) async {
    for (final subCategory in subCategories) {
      await add(subCategory: subCategory);
    }
    return Future.value();
  }

  @override
  FutureOr<void> addAllByCategory({
    required String category,
    required List<SubCategoryEntity> subCategories,
  }) async {
    _category[category] = subCategories;
    await addAll(subCategories: subCategories);
    return Future.value();
  }

  @override
  FutureOr<SubCategoryEntity> find({
    required String urlSlug,
  }) async {
    final category = _cache[urlSlug];

    if (category == null) {
      throw SubCategoryNotFoundInLocalCacheFailure();
    }
    return category;
  }

  @override
  FutureOr<List<SubCategoryEntity>> findByCategory({
    required String category,
  }) async {
    final categories = _category[category];

    if (categories == null) {
      throw CategoryNotFoundInLocalCacheFailure();
    }
    return categories;
  }

  @override
  FutureOr<void> removeAll() async {
    _cache.clear();
    _category.clear();
    location.clear();
    return Future.value();
  }

  @override
  void addByLocation({
    required String? query,
    required String division,
    String? district,
    String? thana,
    required String industry,
    required String category,
    required List<SubCategoryEntity> subCategories,
  }) {
    final String key = buildLocationKey(
      query: query,
      division: division,
      district: district,
      thana: thana,
      industry: industry,
      category: category,
    );
    for (SubCategoryEntity category in subCategories) {
      add(subCategory: category);
    }
    location[key] = subCategories;
  }

  @override
  List<SubCategoryEntity> findByLocation({
    required String? query,
    required String division,
    String? district,
    String? thana,
    required String industry,
    required String category,
  }) {
    final String key = buildLocationKey(
      query: query,
      division: division,
      district: district,
      thana: thana,
      industry: industry,
      category: category,
    );
    final entities = location[key];

    if (entities == null) {
      throw SubCategoryNotFoundInLocalCacheFailure();
    }

    return entities;
  }

  String buildLocationKey({
    required String? query,
    required String division,
    String? district,
    String? thana,
    required String industry,
    required String category,
  }) =>
      '$query-$division-$district-$thana-$industry-$category';
}
