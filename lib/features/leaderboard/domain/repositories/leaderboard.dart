import '../../../../core/shared/shared.dart';
import '../../leaderboard.dart';

typedef LeaderboardEntityPaginatedResponse = ({
  List<LeaderboardEntity> items,
  int total,
});

abstract class LeaderboardRepository {
  FutureOr<Either<Failure, void>> create({
    required LeaderboardEntity leaderboard,
  });

  FutureOr<Either<Failure, void>> delete({
    required String guid,
  });

  FutureOr<Either<Failure, LeaderboardEntity>> find({
    required String guid,
  });

  FutureOr<Either<Failure, List<LeaderboardEntity>>> read();

  FutureOr<Either<Failure, List<LeaderboardEntity>>> refresh();

  FutureOr<Either<Failure, List<LeaderboardEntity>>> search({
    required String query,
  });

  FutureOr<Either<Failure, void>> update({
    required LeaderboardEntity leaderboard,
  });
}
