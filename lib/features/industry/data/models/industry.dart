import '../../../../core/shared/shared.dart';
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
        map.containsKey('icon'),
        'IndustryModel.parse: "icon" not found.',
      );
      assert(
        map['icon'] is String,
        'IndustryModel.parse: "icon" is not a String.',
      );
      final String icon = map['icon'] as String;

      assert(
        map.containsKey('urlslug'),
        'IndustryModel.parse: "urlslug" not found.',
      );
      assert(
        map['urlslug'] is String,
        'IndustryModel.parse: "urlslug" is not a String.',
      );
      final String urlSlug = map['urlslug'] as String;

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
