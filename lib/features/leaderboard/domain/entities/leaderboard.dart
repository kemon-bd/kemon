import '../../../../core/shared/shared.dart';

class LeaderboardEntity extends Equatable {
  final String guid;

  const LeaderboardEntity({
    required this.guid,
  });

  factory LeaderboardEntity.create() {
    throw UnimplementedError();
  }

  @override
  List<Object?> get props => [
        guid,
      ];
}
