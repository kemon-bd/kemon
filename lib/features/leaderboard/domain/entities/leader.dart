import '../../../../core/shared/shared.dart';

class LeaderEntity extends Equatable {
  final Identity identity;
  final Name name;
  final String avatar;
  final int point;

  const LeaderEntity({
    required this.identity,
    required this.name,
    required this.avatar,
    required this.point,
  });

  @override
  List<Object?> get props => [identity, point, name, avatar];
}

class RankedLeaderEntity extends LeaderEntity {
  final int rank;
  const RankedLeaderEntity({
    required this.rank,
    required super.identity,
    required super.name,
    required super.avatar,
    required super.point,
  });
}
