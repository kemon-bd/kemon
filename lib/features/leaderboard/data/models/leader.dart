import '../../../../core/shared/shared.dart';
import '../../leaderboard.dart';

class LeaderModel extends LeaderEntity {
  const LeaderModel({
    required super.identity,
    required super.point,
  });

  factory LeaderModel.parse({
    required Map<String, dynamic> map,
  }) {
    try {
      return LeaderModel(
        identity: Identity.guid(guid: map['userId']),
        point:  (map['point'] as num).toInt(),
      );
    } catch (e, stackTrace) {
      throw LeaderboardModelParseFailure(
        message: e.toString(),
        stackTrace: stackTrace,
      );
    }
  }
}
