import '../../../../core/shared/shared.dart';

class HomeEntity extends Equatable {
  // TODO: implement entity properties
  final int id;

  HomeEntity({
    required this.id,
  });

  factory HomeEntity.create() {
    throw UnimplementedError();
  }

  @override
  List<Object?> get props => [
        // TODO: add entity properties
        id,
      ];
}
