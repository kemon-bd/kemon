import '../../../../core/shared/shared.dart';
import '../../sub_category.dart';

class SubCategoryModel extends SubCategoryEntity {
  const SubCategoryModel({
    required super.name,
    required super.icon,
    required super.urlSlug,
  });

  factory SubCategoryModel.parse({
    required Map<String, dynamic> map,
  }) {
    try {
      assert(
        map.containsKey('name'),
        'SubCategoryModel.parse: "name" not found.',
      );
      assert(
        map['name'] is String,
        'SubCategoryModel.parse: "name" is not a String.',
      );
      final String name = map['name'] as String;

      // assert(
      //   map.containsKey('icon'),
      //   'SubCategoryModel.parse: "icon" not found.',
      // );
      assert(
        map['icon'] is String?,
        'SubCategoryModel.parse: "icon" is not a String?.',
      );
      final String icon = map['icon'] ?? '';

      assert(
        map.containsKey('urlslug'),
        'SubCategoryModel.parse: "urlslug" not found.',
      );
      assert(
        map['urlslug'] is String,
        'SubCategoryModel.parse: "urlslug" is not a String.',
      );
      final String urlSlug = map['urlslug'] as String;

      return SubCategoryModel(
        name: Name.full(name: name),
        icon: icon,
        urlSlug: urlSlug,
      );
    } catch (e, stackTrace) {
      throw SubCategoryModelParseFailure(
        message: e.toString(),
        stackTrace: stackTrace,
      );
    }
  }
}
