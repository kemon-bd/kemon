import '../../../../core/shared/shared.dart';
import '../../leaderboard.dart';

abstract class LeaderboardRepository {
  FutureOr<Either<Failure, List<RankedLeaderEntity>>> find({
    required String query,
  });

  FutureOr<Either<Failure, List<RankedLeaderEntity>>> refresh();
}
