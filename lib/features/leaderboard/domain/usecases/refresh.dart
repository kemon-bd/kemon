import '../../../../core/shared/shared.dart';
import '../../leaderboard.dart';

class RefreshLeaderboardUseCase {
  final LeaderboardRepository repository;

  RefreshLeaderboardUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, LeaderboardResponse>> call() async {
    return await repository.refresh();
  }
}
