import '../../../../core/shared/shared.dart';
import '../../leaderboard.dart';

class UpdateLeaderboardUseCase {
  final LeaderboardRepository repository;

  UpdateLeaderboardUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, void>> call({
    required LeaderboardEntity leaderboard,
  }) async {
    return await repository.update(
      leaderboard: leaderboard,
    );
  }
}
