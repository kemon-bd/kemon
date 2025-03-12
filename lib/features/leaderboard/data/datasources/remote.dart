import '../../../../core/shared/shared.dart';
import '../../leaderboard.dart';

abstract class LeaderboardRemoteDataSource {
  FutureOr<List<LeaderModel>> find({
    required DateTime from,
    required DateTime to,
  });
}
