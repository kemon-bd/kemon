import '../../../../core/shared/shared.dart';
import '../../leaderboard.dart';

class FindLeaderboardUseCase {
  final LeaderboardRepository repository;

  FindLeaderboardUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, List<RankedLeaderEntity>>> call({
    required String query,
  }) async {
    return await repository.find(query: query);
  }
}
