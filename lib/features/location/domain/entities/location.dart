import '../../../../core/shared/shared.dart';

class LocationEntity extends Equatable {
  // TODO: implement entity properties
  final String guid;

  LocationEntity({
    required this.guid,
  });

  factory LocationEntity.create() {
    throw UnimplementedError();
  }

  @override
  List<Object?> get props => [
        // TODO: add entity properties
        guid,
      ];
}
