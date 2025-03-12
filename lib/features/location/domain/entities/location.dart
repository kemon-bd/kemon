import '../../../../core/shared/shared.dart';

class LocationEntity extends Equatable {
  final Name name;
  final String urlSlug;

  const LocationEntity({
    required this.name,
    required this.urlSlug,
  });

  @override
  List<Object?> get props => [
        name,
        urlSlug,
      ];
}

class DivisionEntity extends LocationEntity {
  const DivisionEntity({
    required super.name,
    required super.urlSlug,
  });
}

class DistrictEntity extends LocationEntity {
  final String division;
  const DistrictEntity({
    required this.division,
    required super.name,
    required super.urlSlug,
  });
}

class ThanaEntity extends LocationEntity {
  final String division;
  final String district;
  const ThanaEntity({
    required this.division,
    required this.district,
    required super.name,
    required super.urlSlug,
  });
}

class DivisionWithListingCountEntity extends DivisionEntity implements LocationEntity {
  final int count;
  final List<DistrictWithListingCountEntity> districts;

  const DivisionWithListingCountEntity({
    required super.name,
    required super.urlSlug,
    required this.districts,
    required this.count,
  });

  @override
  List<Object?> get props => [
        name,
        urlSlug,
        count,
        districts,
      ];
}

class DistrictWithListingCountEntity extends DistrictEntity implements LocationEntity {
  final int count;
  final List<ThanaWithListingCountEntity> thanas;

  const DistrictWithListingCountEntity({
    required super.name,
    required super.urlSlug,
    required super.division,
    required this.thanas,
    required this.count,
  });

  @override
  List<Object?> get props => [
        name,
        urlSlug,
        division,
        count,
        thanas,
      ];
}

class ThanaWithListingCountEntity extends ThanaEntity implements LocationEntity {
  final int count;

  const ThanaWithListingCountEntity({
    required super.name,
    required super.urlSlug,
    required super.division,
    required super.district,
    required this.count,
  });

  @override
  List<Object?> get props => [
        name,
        urlSlug,
        division,
        district,
        count,
      ];
}
