import '../../../../core/shared/shared.dart';
import '../../leaderboard.dart';

class RefreshLeaderboardUseCase {
  final LeaderboardRepository repository;

  RefreshLeaderboardUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, LeaderboardResponse>> call({
    required DateTime from,
    required DateTime to,
  }) async {
    return await repository.refresh(from: from, to: to);
  }
}
