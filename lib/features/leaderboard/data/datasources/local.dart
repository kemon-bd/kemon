import '../../../../core/shared/shared.dart';
import '../../leaderboard.dart';

abstract class LeaderboardLocalDataSource {
  FutureOr<void> add({
    required int page,
    required String query,
    required DateTime from,
    required DateTime to,
    required LeaderboardResponse leaderboard,
  });

  FutureOr<void> removeAll();

  FutureOr<LeaderboardResponse> find({
    required int page,
    required String query,
    required DateTime from,
    required DateTime to,
  });
}
