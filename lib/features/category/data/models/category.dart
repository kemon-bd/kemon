import '../../../../core/shared/shared.dart';
import '../../../search/search.dart';
import '../../../sub_category/sub_category.dart';
import '../../category.dart';

class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required super.industry,
    required super.identity,
    required super.name,
    required super.icon,
    required super.urlSlug,
  });

  factory CategoryModel.parse({
    required Map<String, dynamic> map,
  }) {
    try {
      assert(
        map['guid'] is String?,
        'CategoryModel.parse: "guid" is not a String.',
      );
      final String guid = map['guid'] ?? '';

      assert(
        map.containsKey('name'),
        'CategoryModel.parse: "name" not found.',
      );
      assert(
        map['name'] is String,
        'CategoryModel.parse: "name" is not a String.',
      );
      final String name = map['name'] as String;

      final String icon = map['logo'] ?? map['icon'] ?? '';

      assert(
        map.containsKey('urlSlug'),
        'CategoryModel.parse: "urlSlug" not found.',
      );
      assert(
        map['urlSlug'] is String,
        'CategoryModel.parse: "urlSlug" is not a String.',
      );
      final String urlSlug = map['urlSlug'] as String;

      return CategoryModel(
        industry: Identity.guid(guid: map['industry']),
        identity: Identity.guid(guid: guid),
        name: Name.full(name: name),
        icon: icon,
        urlSlug: urlSlug,
      );
    } catch (e, stackTrace) {
      throw CategoryModelParseFailure(
        message: e.toString(),
        stackTrace: stackTrace,
      );
    }
  }
}

class CategoryWithListingCountModel extends CategoryWithListingCountEntity implements CategoryModel, CategoryEntity {
  const CategoryWithListingCountModel({
    required super.identity,
    required super.industry,
    required super.name,
    required super.icon,
    required super.urlSlug,
    required super.listings,
    required super.subCategories,
  });

  factory CategoryWithListingCountModel.parse({
    required Map<String, dynamic> map,
  }) {
    try {
      final category = CategoryModel.parse(map: map);
      return CategoryWithListingCountModel(
        industry: category.industry,
        identity: category.identity,
        name: category.name,
        icon: category.icon,
        urlSlug: category.urlSlug,
        listings: map['count'] ?? 0,
        subCategories: List<dynamic>.from(map['subCategories'])
            .map((subMap) => SubCategoryWithListingCountModel.parse(map: subMap))
            .toList(),
      );
    } catch (e, stackTrace) {
      throw CategoryModelParseFailure(
        message: e.toString(),
        stackTrace: stackTrace,
      );
    }
  }
}

class CategorySuggestionModel extends CategorySuggestionEntity
    implements CategoryEntity, CategoryModel, SearchSuggestionEntity, SearchSuggestionModel {
  const CategorySuggestionModel({
    required super.identity,
    required super.industry,
    required super.name,
    required super.icon,
    required super.urlSlug,
  });

  factory CategorySuggestionModel.parse({
    required Map<String, dynamic> map,
  }) {
    try {
      final category = CategoryModel.parse(map: map);
      return CategorySuggestionModel(
        industry: category.industry,
        identity: category.identity,
        name: category.name,
        icon: category.icon,
        urlSlug: category.urlSlug,
      );
    } catch (e, stackTrace) {
      throw CategoryModelParseFailure(
        message: e.toString(),
        stackTrace: stackTrace,
      );
    }
  }
}
