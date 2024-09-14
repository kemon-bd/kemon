import '../../../../core/shared/shared.dart';
import '../../leaderboard.dart';

class SearchLeaderboardUseCase {
  final LeaderboardRepository repository;

  SearchLeaderboardUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, List<LeaderboardEntity>>> call({
    required String query,
  }) async {
    return await repository.search(
      query: query,
    );
  }
}
