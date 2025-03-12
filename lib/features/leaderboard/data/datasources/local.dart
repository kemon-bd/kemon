import '../../../../core/shared/shared.dart';
import '../../leaderboard.dart';

abstract class LeaderboardLocalDataSource {
  FutureOr<void> add({
    required DateTime from,
    required DateTime to,
    required List<RankedLeaderEntity> leaders,
  });

  FutureOr<void> removeAll();

  FutureOr<List<RankedLeaderEntity>> find({
    required DateTime from,
    required DateTime to,
  });
}
