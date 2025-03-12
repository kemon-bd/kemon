import '../../../../core/shared/shared.dart';
import '../../../category/category.dart';
import '../../../search/search.dart';
import '../../industry.dart';

class IndustryModel extends IndustryEntity {
  const IndustryModel({
    required super.identity,
    required super.name,
    required super.icon,
    required super.urlSlug,
  });

  factory IndustryModel.parse({
    required Map<String, dynamic> map,
  }) {
    try {
      assert(
        map.containsKey('name'),
        'IndustryModel.parse: "name" not found.',
      );
      assert(
        map['name'] is String,
        'IndustryModel.parse: "name" is not a String.',
      );
      final String name = map['name'] as String;

      assert(
        map['icon'] is String? || map['logo'] is String?,
        'IndustryModel.parse: "icon" is not a String.',
      );
      final String icon = map['icon'] ?? map['logo'] ?? '';

      assert(
        map.containsKey('urlSlug'),
        'IndustryModel.parse: "urlSlug" not found.',
      );
      assert(
        map['urlSlug'] is String,
        'IndustryModel.parse: "urlSlug" is not a String.',
      );
      final String urlSlug = map['urlSlug'] as String;

      return IndustryModel(
        identity: Identity.guid(guid: map['guid'] ?? ''),
        name: Name.full(name: name),
        icon: icon,
        urlSlug: urlSlug,
      );
    } catch (e, stackTrace) {
      throw IndustryModelParseFailure(
        message: e.toString(),
        stackTrace: stackTrace,
      );
    }
  }
}

class IndustryWithListingCountModel extends IndustryWithListingCountEntity
    implements IndustryModel, CategoryModel, CategoryEntity {
  const IndustryWithListingCountModel({
    required super.identity,
    required super.name,
    required super.icon,
    required super.urlSlug,
    required super.listings,
    required super.categories,
  });

  factory IndustryWithListingCountModel.parse({
    required Map<String, dynamic> map,
  }) {
    try {
      final industry = IndustryModel.parse(map: map);
      return IndustryWithListingCountModel(
        identity: industry.identity,
        name: industry.name,
        icon: industry.icon,
        urlSlug: industry.urlSlug,
        listings: map['count'] ?? 0,
        categories:
            List<dynamic>.from(map['categories']).map((catMap) => CategoryWithListingCountModel.parse(map: catMap)).toList(),
      );
    } catch (e, stackTrace) {
      throw CategoryModelParseFailure(
        message: e.toString(),
        stackTrace: stackTrace,
      );
    }
  }
}

class IndustrySuggestionModel extends IndustrySuggestionEntity
    implements IndustryEntity, IndustryModel, SearchSuggestionEntity, SearchSuggestionModel {
  const IndustrySuggestionModel({
    required super.identity,
    required super.name,
    required super.icon,
    required super.urlSlug,
  });

  factory IndustrySuggestionModel.parse({
    required Map<String, dynamic> map,
  }) {
    try {
      final industry = IndustryModel.parse(map: map);
      return IndustrySuggestionModel(
        identity: industry.identity,
        name: industry.name,
        icon: industry.icon,
        urlSlug: industry.urlSlug,
      );
    } catch (e, stackTrace) {
      throw IndustryModelParseFailure(
        message: e.toString(),
        stackTrace: stackTrace,
      );
    }
  }
}
