import '../../../../core/shared/shared.dart';
import '../../leaderboard.dart';

abstract class LeaderboardLocalDataSource {
  FutureOr<void> add({
    required LeaderboardEntity leaderboard,
  });

  FutureOr<void> addAll({
    required List<LeaderboardEntity> items,
  });

  FutureOr<void> update({
    required LeaderboardEntity leaderboard,
  });

  FutureOr<void> remove({
    required String guid,
  });

  FutureOr<void> removeAll();

  FutureOr<LeaderboardEntity> find({
    required String guid,
  });
}
