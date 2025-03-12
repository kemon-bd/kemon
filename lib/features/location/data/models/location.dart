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
        map.containsKey('name'),
        'BusinessModel.parse: "name" not found.',
      );
      assert(
        map['name'] is String,
        'BusinessModel.parse: "name" is not a String.',
      );
      final String name = map['name'];

      assert(
        map.containsKey('urlSlug'),
        'BusinessModel.parse: "urlSlug" not found.',
      );
      assert(
        map['urlSlug'] is String,
        'BusinessModel.parse: "urlSlug" is not a String.',
      );
      final String urlSlug = map['urlSlug'];

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

class DivisionModel extends DivisionEntity implements LocationModel, LocationEntity {
  const DivisionModel({
    required super.name,
    required super.urlSlug,
  });

  factory DivisionModel.parse({
    required Map<String, dynamic> map,
  }) {
    try {
      return DivisionModel(
        name: Name.full(name: map['name']),
        urlSlug: map['urlSlug'],
      );
    } catch (e, stackTrace) {
      throw LocationModelParseFailure(
        message: e.toString(),
        stackTrace: stackTrace,
      );
    }
  }
}

class DistrictModel extends DistrictEntity implements LocationModel, LocationEntity {
  const DistrictModel({
    required super.name,
    required super.urlSlug,
    required super.division,
  });

  factory DistrictModel.parse({
    required Map<String, dynamic> map,
  }) {
    try {
      return DistrictModel(
        name: Name.full(name: map['name']),
        urlSlug: map['urlSlug'],
        division: map['division'],
      );
    } catch (e, stackTrace) {
      throw LocationModelParseFailure(
        message: e.toString(),
        stackTrace: stackTrace,
      );
    }
  }
}

class ThanaModel extends ThanaEntity implements LocationModel, LocationEntity {
  const ThanaModel({
    required super.name,
    required super.urlSlug,
    required super.division,
    required super.district,
  });

  factory ThanaModel.parse({
    required Map<String, dynamic> map,
  }) {
    try {
      return ThanaModel(
        name: Name.full(name: map['name']),
        urlSlug: map['urlSlug'],
        division: map['division'],
        district: map['district'],
      );
    } catch (e, stackTrace) {
      throw LocationModelParseFailure(
        message: e.toString(),
        stackTrace: stackTrace,
      );
    }
  }
}

class DivisionWithListingCountModel extends DivisionWithListingCountEntity
    implements DivisionEntity, LocationModel, LocationEntity {
  const DivisionWithListingCountModel({
    required super.count,
    required super.name,
    required super.urlSlug,
    required super.districts,
  });

  factory DivisionWithListingCountModel.parse({
    required Map<String, dynamic> map,
  }) {
    try {
      final division = DivisionModel.parse(map: map);
      return DivisionWithListingCountModel(
        name: division.name,
        urlSlug: division.urlSlug,
        count: map['count'],
        districts: List<dynamic>.from(map['districts'])
            .map(
              (district) => DistrictWithListingCountModel.parse(map: district),
            )
            .toList(),
      );
    } catch (e, stackTrace) {
      throw LocationModelParseFailure(
        message: e.toString(),
        stackTrace: stackTrace,
      );
    }
  }
}

class DistrictWithListingCountModel extends DistrictWithListingCountEntity
    implements DistrictEntity, LocationModel, LocationEntity {
  const DistrictWithListingCountModel({
    required super.count,
    required super.name,
    required super.urlSlug,
    required super.division,
    required super.thanas,
  });

  factory DistrictWithListingCountModel.parse({
    required Map<String, dynamic> map,
  }) {
    try {
      final district = DistrictModel.parse(map: map);
      return DistrictWithListingCountModel(
        name: district.name,
        urlSlug: district.urlSlug,
        division: district.division,
        count: map['count'],
        thanas: List<dynamic>.from(map['thanas']).map((thana) => ThanaWithListingCountModel.parse(map: thana)).toList(),
      );
    } catch (e, stackTrace) {
      throw LocationModelParseFailure(
        message: e.toString(),
        stackTrace: stackTrace,
      );
    }
  }
}

class ThanaWithListingCountModel extends ThanaWithListingCountEntity implements ThanaEntity, LocationModel, LocationEntity {
  const ThanaWithListingCountModel({
    required super.count,
    required super.name,
    required super.urlSlug,
    required super.division,
    required super.district,
  });

  factory ThanaWithListingCountModel.parse({
    required Map<String, dynamic> map,
  }) {
    try {
      final thana = ThanaModel.parse(map: map);
      return ThanaWithListingCountModel(
        name: thana.name,
        urlSlug: thana.urlSlug,
        division: thana.division,
        district: thana.district,
        count: map['count'],
      );
    } catch (e, stackTrace) {
      throw LocationModelParseFailure(
        message: e.toString(),
        stackTrace: stackTrace,
      );
    }
  }
}
