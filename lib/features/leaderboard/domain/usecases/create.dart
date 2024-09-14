import '../../../../core/shared/shared.dart';
import '../../leaderboard.dart';

class CreateLeaderboardUseCase {
  final LeaderboardRepository repository;

  CreateLeaderboardUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, void>> call({
    required LeaderboardEntity leaderboard,
  }) async {
    return await repository.create(
      leaderboard: leaderboard,
    );
  }
}
