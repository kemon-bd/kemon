import '../../../../core/shared/shared.dart';

class LeaderboardEntity extends Equatable {
  // TODO: implement entity properties
  final String guid;

  LeaderboardEntity({
    required this.guid,
  });

  factory LeaderboardEntity.create() {
    throw UnimplementedError();
  }

  @override
  List<Object?> get props => [
        // TODO: add entity properties
        guid,
      ];
}
