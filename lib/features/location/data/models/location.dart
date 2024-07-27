import '../../../../core/shared/shared.dart';
import '../../location.dart';

class LocationModel extends LocationEntity {
  const LocationModel({
    required super.name,
    required super.urlSlug,
  });

  factory LocationModel.parse({
    required Map<String, dynamic> map,
  }) {
    try {
      assert(
        map.containsKey('locationName') || map.containsKey('name'),
        'BusinessModel.parse: "locationName"/"name" not found.',
      );
      assert(
        map['locationName'] is String || map['name'] is String,
        'BusinessModel.parse: "locationName"/"name" is not a String.',
      );
      final String name = map['locationName'] ?? map['name'];

      assert(
        map.containsKey('locationUrlslug') || map.containsKey('urlslug'),
        'BusinessModel.parse: "locationUrlslug"/"urlslug" not found.',
      );
      assert(
        map['locationUrlslug'] is String || map['urlslug'] is String,
        'BusinessModel.parse: "locationUrlslug"/"urlslug" is not a String.',
      );
      final String urlSlug = map['locationUrlslug'] ?? map['urlslug'];

      return LocationModel(
        name: Name.full(name: name),
        urlSlug: urlSlug,
      );
    } catch (e, stackTrace) {
      throw LocationModelParseFailure(
        message: e.toString(),
        stackTrace: stackTrace,
      );
    }
  }
}
