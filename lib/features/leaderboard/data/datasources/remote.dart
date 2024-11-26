import '../../../../core/shared/shared.dart';
import '../../leaderboard.dart';

abstract class LeaderboardRemoteDataSource {
  FutureOr<LeaderboardResponse> find({
    required int page,
    required String query,
    required DateTime from,
    required DateTime to,
  });
}
