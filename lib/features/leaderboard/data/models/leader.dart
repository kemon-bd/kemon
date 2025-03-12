import '../../../../core/shared/shared.dart';
import '../../leaderboard.dart';

class LeaderModel extends LeaderEntity {
  const LeaderModel({
    required super.identity,
    required super.name,
    required super.avatar,
    required super.point,
  });

  factory LeaderModel.parse({
    required Map<String, dynamic> map,
  }) {
    try {
      return LeaderModel(
        identity: Identity.guid(guid: map['guid']),
        point:  (map['point'] as num).toInt(),
        name: Name.full(name: map['name']),
        avatar: map['profilePicture'],
      );
    } catch (e, stackTrace) {
      throw LeaderboardModelParseFailure(
        message: e.toString(),
        stackTrace: stackTrace,
      );
    }
  }
}
