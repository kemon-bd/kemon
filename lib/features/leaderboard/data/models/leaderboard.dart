import '../../../../core/shared/shared.dart';
import '../../leaderboard.dart';

class LeaderboardModel extends LeaderboardEntity {
  const LeaderboardModel({
    required super.guid,
  });

  factory LeaderboardModel.parse({
    required Map<String, dynamic> map,
  }) {
    try {
      throw UnimplementedError();
    } catch (e, stackTrace) {
      throw LeaderboardModelParseFailure(
        message: e.toString(),
        stackTrace: stackTrace,
      );
    }
  }
}
