import '../../../../core/shared/shared.dart';
import '../../leaderboard.dart';

abstract class LeaderboardRemoteDataSource {
  FutureOr<void> create({
    required LeaderboardEntity leaderboard,
  });

  FutureOr<void> delete({
    required String guid,
  });

  FutureOr<LeaderboardModel> find({
    required String guid,
  });

  FutureOr<List<LeaderboardModel>> read();

  FutureOr<List<LeaderboardModel>> refresh();

  FutureOr<List<LeaderboardModel>> search({
    required String query,
  });

  FutureOr<void> update({
    required LeaderboardEntity leaderboard,
  });
}
