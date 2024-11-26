import '../../../../core/shared/shared.dart';
import '../../leaderboard.dart';

typedef LeaderboardResponse = ({
  List<LeaderEntity> leaders,
  int total,
  DateTime deadline,
});
abstract class LeaderboardRepository {
  FutureOr<Either<Failure, LeaderboardResponse>> find({
    required int page,
    required String query,
    required DateTime from,
    required DateTime to,
  });

  FutureOr<Either<Failure, LeaderboardResponse>> refresh({
    required DateTime from,
    required DateTime to,
  });
}
