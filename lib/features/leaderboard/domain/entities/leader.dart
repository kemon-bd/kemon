import '../../../../core/shared/shared.dart';

class LeaderEntity extends Equatable {
  final Identity identity;
  final int point;

  const LeaderEntity({
    required this.identity,
    required this.point,
  });

  @override
  List<Object?> get props => [identity, point];
}
