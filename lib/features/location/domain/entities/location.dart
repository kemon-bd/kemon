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
